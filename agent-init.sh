#!/bin/bash

agent=$1
[ -n "$agent" ] || exit 1

docker start $agent 2>/dev/null || docker run -P -d -t --dns=172.17.42.1  -h $agent --name="$agent" pabase 2>/dev/null
ssh_port=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "22/tcp") 0).HostPort}}'  $agent)
#ssh_port=$(docker port $agent 22 | cut -d: -f2 )


ssh="ssh -i docker_rsa -o StrictHostKeyChecking=no -p $ssh_port root@localhost"

until $ssh "/bin/true" ; do 
	sleep 1;
done
echo "pre-sign cert for $agent"
./pre-sign.sh $agent > $agent.tar

$ssh " rm /usr/sbin/policy-rc.d;
	curl -k https://puppet:8140/packages/current/install.bash | bash"

cat $agent.tar | $ssh "dir=\$( puppet config print ssldir ) ;
mv \$dir /tmp;
mkdir -p \$dir;
cd \$dir;
tar -xf - ; "


$ssh "puppet agent --test"

#docker stop $agent
#docker rm $agent
#./cert-clean.sh $agent 

