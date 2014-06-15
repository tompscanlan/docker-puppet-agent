This is just a container used for testing puppet.  Allows a quick sanity check of manifest changes.  Expects the puppet host
to be at hostname "puppet" and that you can ssh to puppet without passwords

dnsmasq is also run to allow several to run side-by-side

	./setup.sh

generates an ssh key, sets up dnsmasq, and builds the base docker image

	# create a new agent
	agent-init.sh agent1

	# destroy the agent named agent1
	agent-decomm.sh agent1

	# if agent1 is running, ssh to it
	agent-ssh.sh agent1

	# setup pre-signed certs at the master and put them on the agent1
	# this is handed by the agent-init and really shouldn't need to be run again
	pre-sign.sh agent1

	# remove certs for agent1 from the puppet master
	# is handled by the decomm
	cert-clean.sh agent1






