#include <core.p4>
#include <v1model.p4>

#define BOOL_T bit<8>
const bit<16> TYPE_IPV4 = 0x800;
// Postprocessing options
#define SKIP 0
#define SENDBACK 1
#define DROP 2

// Note: egress port numbers can have different types depending on the target
#define EGRESS_PORT_T bit<9>
#ifdef TARGET_NFP
    #undef EGRESS_PORT_T
    #define EGRESS_PORT_T bit<16>
#endif


// clone workaround
#ifdef TARGET_NFP
    #define clone(T,S) clone(CloneType.I2I,S);standard_metadata.clone_spec=1<<31|(bit<32>)standard_metadata.egress_spec
#endif

// atomic workaround for NFP
#define ATOMIC_BEGIN 
#define ATOMIC_END
#ifdef TARGET_NFP
    extern void atomic_begin();
    extern void atomic_end();
    #undef ATOMIC_BEGIN 
    #undef ATOMIC_END
    #define ATOMIC_BEGIN atomic_begin(); 
    #define ATOMIC_END atomic_end();
#endif

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;


#include "standard_headers.p4"

#include "a_headers.p4"

header dummy_h{
    bit<8> dummy_data;
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
    udp_t        udp;
    tcp_t        tcp;

    #include "a_hdrlist.p4"
}

//register<bit<1>>(1) checker_turn;

register<bit<1>>(1) checkers_turn;
// 0 brancas - 1 pretas

register<bit<1>>(1) jogo_iniciado;
//verificador de jogo iniciado

register<bit<8>>(64) checkerboard;
//register<bit<376>>(1) map;
//register<bit<8>>(18) map2;
//map.write(0, 0x2D322D322D320A302D302D302D0A2D302D302D300A302D302D302D0A2D312D302D300A302D312D312D0A0A);

struct metadata {
    #ifdef USE_DUMMY_PARSER
        bool dummy;
    #endif

    bit<16> size_growth;
    bit<16> size_loss;
    bit<8>  postprocessing;

    bit<32> parsed_bytes;
    bit<32> truncated_to;
}

parser MyParser(packet_in pkt,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        meta.size_growth = 0;
        meta.size_loss = 0;
        meta.postprocessing = SKIP;
        meta.parsed_bytes = 0;
        meta.truncated_to = 0;

        #ifndef USE_DUMMY_PARSER
            transition parse_ethernet;
        #else
            transition select(meta.dummy || (!meta.dummy) ){
                true : parse_ethernet;
                default : dummy;
            }
        #endif
    }

    #ifdef USE_DUMMY_PARSER
        #include "dummy.p4"
    #endif

    state parse_ethernet {
        pkt.extract(hdr.ethernet);
        meta.parsed_bytes = meta.parsed_bytes + 14;
        transition select(hdr.ethernet.etherType) {
            16w0x800: parse_ipv4;
            default: accept;
        }
    }

    state parse_ipv4 {
        pkt.extract(hdr.ipv4);
        meta.parsed_bytes = meta.parsed_bytes + 20;
        transition select(hdr.ipv4.protocol){
            17 : parse_udp;
            6  : parse_tcp;
            default: chain_ipv4_raw;
        }
    }

    state parse_udp{
        pkt.extract(hdr.udp);
        meta.parsed_bytes = meta.parsed_bytes + 8;
        transition chain_ipv4_udp;
    }

    state parse_tcp{
        pkt.extract(hdr.tcp);
        meta.parsed_bytes = meta.parsed_bytes + 20;
        transition chain_ipv4_tcp;
    }

    #include "a_chains.p4"

    #ifndef CHAIN_IPV4_UDP
    state chain_ipv4_udp{
        transition accept;
    }
    #endif

    #ifndef CHAIN_IPV4_TCP
    state chain_ipv4_tcp{
        transition accept;
    }
    #endif

    #ifndef CHAIN_IPV4_RAW
    state chain_ipv4_raw{
        transition accept;
    }
    #endif

}


control MyVerifyChecksum(inout headers hdr,
                         inout metadata meta) {
    apply { }
}

control SendBack(inout headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    apply{
        standard_metadata.egress_spec = standard_metadata.ingress_port;
        
        if (hdr.ethernet.isValid()){
            bit<48> tmp = hdr.ethernet.srcAddr;
            hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
            hdr.ethernet.dstAddr = tmp;
        }
        
        if (hdr.ipv4.isValid()){
            bit<32> tmp = hdr.ipv4.src;
            hdr.ipv4.src = hdr.ipv4.dst;
            hdr.ipv4.dst = tmp;
        }

        if (hdr.udp.isValid()){
            bit<16> tmp = hdr.udp.srcPort;
            hdr.udp.srcPort = hdr.udp.dstPort;
            hdr.udp.dstPort = tmp;
            hdr.udp.csum = 0;
        }

        if (hdr.tcp.isValid()){
            bit<16> tmp = hdr.tcp.srcPort;
            hdr.tcp.srcPort = hdr.tcp.dstPort;
            hdr.tcp.dstPort = tmp;
            hdr.tcp.csum = 0;
        }

    }

}

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

	#include "a_gerarsaida.p4"

    
    /*action set_eport(EGRESS_PORT_T port){
        standard_metadata.egress_spec = port;
    }

    table portfwd{
        key = {
            standard_metadata.ingress_port: exact;
        }
        actions = {
            set_eport;
        }
        const default_action = set_eport(5);
        const entries = {
            #ifdef TARGET_NFP
                1 : set_eport(0x0300);
                0x0300 : set_eport(1);
                0x0302 : set_eport(0x0303);
                0x0303 : set_eport(0x0302);
                0x0304 : set_eport(0x0303);
            #else
                1 : set_eport(2);
                2 : set_eport(1);
		3 : set_eport(2);
            #endif
        }
    }*/
	action drop() {
	        mark_to_drop(standard_metadata);
	}

	action ipv4_forward(macAddr_t dstAddr, egressSpec_t port) {

		//set the src mac address as the previous dst, this is not correct right?
		//hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
	  
	   //set the destination mac address that we got from the match in the table
		hdr.ethernet.dstAddr = dstAddr;

		//set the output port that we also get from the table
		standard_metadata.egress_spec = port;

		//decrease ttl by 1
		hdr.ipv4.ttl = hdr.ipv4.ttl -1;
		/*update_checksum(
		hdr.ipv4.isValid(),
			{ hdr.ipv4.version,
		  hdr.ipv4.ihl,
			  hdr.ipv4.diffserv,
			  hdr.ipv4.totalLen,
			  hdr.ipv4.identification,
			  hdr.ipv4.flags,
			  hdr.ipv4.fragOffset,
			  hdr.ipv4.ttl,
			  hdr.ipv4.protocol,
			  hdr.ipv4.src,
			  hdr.ipv4.dst },
			hdr.ipv4.hdrChecksum,
			HashAlgorithm.csum16);*/
	}

	table ipv4_lpm {
		key = {
			hdr.ipv4.dst: exact;
		}
		actions = {
			ipv4_forward;
			drop;
			NoAction;
		}
		size = 1024;
		default_action = NoAction();
	}

    #include "a_declarations.p4"

    apply {
/*
        portfwd.apply();
*/
        if (hdr.ipv4.isValid()){
            ipv4_lpm.apply();

        }
        #include "a_apply.p4"

        // erase checksums an update packet sizes
        if (hdr.tcp.isValid()){
            hdr.tcp.csum = 0;
        }
        else if (hdr.udp.isValid()){
            hdr.udp.csum = 0;
            hdr.udp.len = hdr.udp.len + meta.size_growth;
            hdr.udp.len = hdr.udp.len - meta.size_loss;
            if (meta.truncated_to!=0){
                hdr.udp.len = (bit<16>) meta.truncated_to - 34;
            }
        }
        if (hdr.ipv4.isValid()){
            hdr.ipv4.totalLen = hdr.ipv4.totalLen + meta.size_growth;
            hdr.ipv4.totalLen = hdr.ipv4.totalLen - meta.size_loss;
            if (meta.truncated_to!=0){
                hdr.ipv4.totalLen = (bit<16>) meta.truncated_to - 14;
            }
            // Note: checksum is updated later
        }

        if (meta.postprocessing==SENDBACK){
            SendBack.apply(hdr,meta,standard_metadata);
        }
        else if (meta.postprocessing==DROP){
            #ifdef TARGET_NFP
                mark_to_drop();
            #else
                mark_to_drop(standard_metadata);
            #endif
        }
    }
}


control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply { }
}


control MyComputeChecksum(inout headers hdr, inout metadata meta) {
    apply {
        update_checksum(
                hdr.ipv4.isValid(),
                { 
	                hdr.ipv4.version,
	                hdr.ipv4.ihl, 
	                hdr.ipv4.diffserv,
	                hdr.ipv4.totalLen, 
	                hdr.ipv4.identification,
	                hdr.ipv4.flags, 
	                hdr.ipv4.fragOffset, 
	                hdr.ipv4.ttl,
	                hdr.ipv4.protocol, 
	                hdr.ipv4.src, 
	                hdr.ipv4.dst 
                },
                hdr.ipv4.hdrChecksum,
                HashAlgorithm.csum16
            );
    }
}

control MyDeparser(packet_out pkt, in headers hdr) {
    apply {
        pkt.emit(hdr);
        // TODO: checksum calculations
    }
}

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
