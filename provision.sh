#!/bin/bash

apt-get install -y python python-apt
cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys