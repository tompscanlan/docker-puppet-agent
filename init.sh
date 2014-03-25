#!/bin/bash

agent=$1
[ -n "$agent" ] || exit 1

id=$(docker run -P -d -t --dns=172.17.42.1  -h $agent  pabase)
ssh_port=$(docker port $id 22 | cut -d: -f2 )


ssh="ssh -i docker_rsa -o StrictHostKeyChecking=no -p $ssh_port root@localhost"

echo "pre-sign cert for $agent"
./pre-sign.sh $agent > $agent.tar
cat $agent.tar | $ssh "dir=\$( puppet config print ssldir ) ;
mkdir -p \$dir;
cd \$dir;
tar -xf - ; "

$ssh "puppet agent --test"

#docker stop $id
#docker rm $id
#./cert-clean.sh $agent 

