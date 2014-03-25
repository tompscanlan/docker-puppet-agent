#!/bin/bash

agent=$1
[ -n "$agent" ] || exit 1

docker kill  $agent
docker rm $agent
./cert-clean.sh $agent 

