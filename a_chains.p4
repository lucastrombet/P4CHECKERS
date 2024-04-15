state parse_genhdr_uid1{
	pkt.extract(hdr.genhdr_uid1);
	transition accept;
}

state parse_genhdr_uid3{
	pkt.extract(hdr.genhdr_uid3);
	transition accept;
}

state check_uid3{
	transition select(hdr.udp.dstPort,hdr.udp.len){
		//(5555,21) : parse_genhdr_uid1;
		(5555,16) : parse_genhdr_uid1;
		default: check_uid4;
	}	
}

state check_uid4{
	transition select(hdr.udp.srcPort,hdr.udp.len){
		//(5555,21) : parse_genhdr_uid1;
		(5555,16) : parse_genhdr_uid3;
		default: accept;
	}	
}


#define CHAIN_IPV4_UDP
state chain_ipv4_udp{
	transition check_uid3;
}
