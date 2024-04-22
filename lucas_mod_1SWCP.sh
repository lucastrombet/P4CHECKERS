#!/bin/bash
#Cria o volume
docker volume create shared
#cria uma pasta no volume
mkdir /var/lib/docker/volumes/shared/_data/codes
#Copia o arquivo standard.json local para a pasta dentro do volume
docker cp standard.json /var/lib/docker/volumes/shared/_data/codes


docker run -itd --name h1  --network="none" --privileged -v shared:/codes --workdir /codes lucastrombet/p4d:nch1
docker run -itd --name h2   --network="none" --privileged -v shared:/codes  --workdir /codes lucastrombet/p4d:nch1
docker run -itd --name sw1  --network="none" --privileged -v shared:/codes  --workdir /codes dnredson/p4d
docker run -itd --name compiler  --network="none" --privileged -v shared:/codes  --workdir /codes dnredson/p4c
#Para usar o compilador, crie um arquivo .p4 e execute o comando:
# p4c-bm2-ss arquivo.p4 -o saida.json 
# esta saída é a que deverá ser iniciada no switch no comando na linha 73 que inicia o BMV2
# O comando da linha 73 roda em background, é só usar o comando "fg" no container para verificar o log
# utilize "docker exec -it <nome> /bin/bash" para conectar em um container 

#A imagem dnredson/net conta com os seguintes programas instalados: iperf3, python3, net-tools, iputils

sudo ip link add veth1 type veth peer name veth2
sudo ip link add veth3 type veth peer name veth4

PIDSW1=$(docker inspect -f '{{.State.Pid}}' sw1)
PIDH1=$(docker inspect -f '{{.State.Pid}}' h1)
PIDH2=$(docker inspect -f '{{.State.Pid}}' h2)


sudo ip link set veth1 netns $PIDSW1
sudo ip link set veth2 netns $PIDH1
sudo ip link set veth3 netns $PIDSW1
sudo ip link set veth4 netns $PIDH2

#SWITCH 1
#Port 1
sudo nsenter -t $PIDSW1 -n ip addr add 10.0.1.1/24 dev veth1
sudo nsenter -t $PIDSW1 -n ip link set dev veth1 address 00:00:00:00:01:01
sudo nsenter -t $PIDSW1 -n ip link set veth1 up
#Port 2
sudo nsenter -t $PIDSW1 -n ip addr add 10.0.2.1/24 dev veth3
sudo nsenter -t $PIDSW1 -n ip link set dev veth3 address 00:00:00:00:02:01
sudo nsenter -t $PIDSW1 -n ip link set veth3 up

#Host 1
sudo nsenter -t $PIDH1 -n ip addr add 10.0.1.2/24 dev veth2
sudo nsenter -t $PIDH1 -n ip link set dev veth2 address 00:00:00:00:01:02
sudo nsenter -t $PIDH1 -n ip link set veth2 up

#Host 2
sudo nsenter -t $PIDH2 -n ip addr add 10.0.2.2/24 dev veth4
sudo nsenter -t $PIDH2 -n ip link set dev veth4 address 00:00:00:00:02:02
sudo nsenter -t $PIDH2 -n ip link set veth4 up


sudo ip link set veth1 promisc on
sudo ip link set veth3 promisc on

docker exec h1 ip link set veth2 promisc on
docker exec h2 ip link set veth4 promisc on
docker exec h1 ethtool -K veth2 tx off tx off
docker exec h2 ethtool -K veth4 tx off tx off
docker exec sw1 sh -c 'echo 0 >> /proc/sys/net/ipv4/ip_forward'

#Configurar as rotas no switch para utilizarem o switch na mesma rede como gateway
docker exec h1 route add -net 10.0.2.2 netmask 255.255.255.255 gw 10.0.1.1
docker exec h2 route add -net 10.0.1.2 netmask 255.255.255.255 gw 10.0.2.1

docker exec h1 sh -c 'arp -i veth2 -s 10.0.2.2 00:00:00:00:02:02'
docker exec h1 sh -c 'arp -i veth2 -s 10.0.2.1 00:00:00:00:02:01'
docker exec h1 sh -c 'arp -i veth2 -s 10.0.1.1 00:00:00:00:01:01'

docker exec h2 sh -c 'arp -i veth4 -s 10.0.1.2 00:00:00:00:01:02'
docker exec h2 sh -c 'arp -i veth4 -s 10.0.1.1 00:00:00:00:01:01'
docker exec h2 sh -c 'arp -i veth4 -s 10.0.2.1 00:00:00:00:02:01'

docker exec sw1 sh -c 'arp -i veth3 -s 10.0.2.2 00:00:00:00:02:02'
docker exec sw1 sh -c 'arp -i veth1 -s 10.0.1.2 00:00:00:00:01:02'


#Inicia o BMV2
#docker exec sw1 sh -c 'nohup simple_switch  --log-console --thrift-port 50001 -i 1@veth1 -i 2@veth3  standard.json &'
# Standard.json é o arquivo gerado pela montagem do p4-bm2-ss
#docker exec sw1 sh -c 'nohup simple_switch --thrift-port 50001 -i 1@veth1 -i 2@veth3  standard.json &'
docker exec sw1 sh -c 'nohup simple_switch --thrift-port 50001 -i 1@veth1 -i 2@veth3 --log-console  checkers.json >> switch.log  &'


docker exec sw1 sh -c 'echo "table_add MyIngress.ipv4_lpm ipv4_forward 10.0.1.2/32  => 00:00:00:00:01:02 1" | simple_switch_CLI --thrift-port 50001'
docker exec sw1 sh -c 'echo "table_add MyIngress.ipv4_lpm ipv4_forward 10.0.2.2/32 =>  00:00:00:00:02:02 2" | simple_switch_CLI --thrift-port 50001'

#table_add ipv4_lpm ipv4_forward 10.0.1.2/32 => 00:00:00:00:01:02 1
#table_add ipv4_lpm ipv4_forward 10.0.2.2/32 => 00:00:00:00:02:02 2
