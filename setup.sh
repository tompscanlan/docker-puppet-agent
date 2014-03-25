#!/bin/bash

sudo dnsmasq --conf-file=./dnsmasq.conf -H conf/hosts
ssh-keygen -f docker_rsa -P ""
docker build -t "pabase" .

