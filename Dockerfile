FROM ubuntu:12.10
MAINTAINER Tom Scanlan "tscanlan@momentumsi.com"


RUN apt-get -y update
RUN apt-get -y install wget
RUN wget --no-check-certificate https://apt.puppetlabs.com/puppetlabs-release-precise.deb
RUN sudo dpkg -i puppetlabs-release-precise.deb
RUN apt-get -y update
RUN apt-get -y install rubygems  bash-completion rsync sudo puppet
RUN apt-get -y install supervisor openssh-server net-tools
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc



RUN mkdir /var/run/sshd
ADD supervisor.conf /opt/supervisor.conf

RUN mkdir /root/.ssh
ADD docker_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
RUN chown root:root /root/.ssh/authorized_keys

EXPOSE 22 8140 8081 443
CMD supervisord -n -c /opt/supervisor.conf
#CMD supervisord -c /opt/supervisor.conf && /bin/bash
