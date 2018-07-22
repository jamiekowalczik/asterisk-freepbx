#!/bin/bash
yum -y install git python-virtualenv
virtualenv ansible
. ./ansible/bin/activate
pip install pip -U
pip install setuptools -U
pip install ansible
git clone https://github.com/jamiekowalczik/asterisk-freepbx.git
cd asterisk-freepbx/provision
ansible-playbook freepbx-gvsip-el7.yml -i inventory
