#!/usr/bin/make -f
all: deps bootstrap homelab

SHELL := /bin/bash
bootstrap:
	ansible-playbook bootstrap.yml -K -e ansible_ssh_user=cianhatton -e ansible_ssh_private_key_file=~/.ssh/id_rsa

qnap:
	ansible-playbook setup-homelab.yml --limit qnap

homelab:
	ansible-playbook setup-homelab.yml

deps:
	pip install -r requirements.txt
	ansible-galaxy install -r requirements.yml
