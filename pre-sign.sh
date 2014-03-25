#!/bin/bash

host=$1

ssh root@puppet "puppet cert generate $host >/dev/null; 
cd \$(puppet config print ssldir);
tar -cf - \
	private_keys/$host.pem \
	certs/$host.pem \
	certs/ca.pem
"
