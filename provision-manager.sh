#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get install -y python-pip libssl-dev build-essential libffi-dev libpython-dev
pip install --upgrade pip
pip install ansible
cp /vagrant/ansible.cfg /home/ubuntu/ansible.cfg
chown ubuntu:ubuntu /home/ubuntu/ansible.cfg
su ubuntu -c "ssh-keygen -t rsa -N \"\" -f /home/ubuntu/.ssh/id_rsa"
cp /home/ubuntu/.ssh/id_rsa.pub /vagrant/
cat /vagrant/hosts >> /etc/hosts