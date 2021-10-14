#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y python-pip libssl-dev build-essential libffi-dev libpython-dev httpie redis-tools
pip install --upgrade pip
pip install ansible
cp /vagrant/ansible.cfg /home/vagrant/ansible.cfg
chown vagrant:vagrant /home/vagrant/ansible.cfg
su vagrant -c "ssh-keygen -t rsa -N \"\" -f /home/vagrant/.ssh/id_rsa"
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/
cat /vagrant/hosts >> /etc/hosts
