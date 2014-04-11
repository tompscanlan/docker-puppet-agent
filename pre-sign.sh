#!/bin/bash

host=$1

ssh -o StrictHostKeyChecking=no root@puppet "puppet cert generate $host >/dev/null; 
cd \$(puppet config print ssldir);
tar -cf - \
	crl.pem \
	certs/$host.pem \
	public_keys/$host.pem \
	private_keys/$host.pem \
	certs/ca.pem
"
