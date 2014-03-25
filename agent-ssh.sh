#!/bin/bash

agent=$1
[ -n "$agent" ] || exit 1
shift; 

docker start $agent 2>/dev/null  || docker run -P -d -t --dns=172.17.42.1  -h $agent --name="$agent" pabase 2>/dev/null
ssh_port=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "22/tcp") 0).HostPort}}'  $agent)
ssh="ssh -i docker_rsa -o StrictHostKeyChecking=no -p $ssh_port root@localhost"

$ssh "$@"
