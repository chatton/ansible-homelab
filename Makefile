#!/usr/bin/make -f
all: deps bootstrap homelab

SHELL := /bin/bash
bootstrap:
	ansible-playbook playbooks/bootstrap.yml -K -e ansible_ssh_user=cianhatton -e ansible_ssh_private_key_file=~/.ssh/id_rsa

qnap:
	ansible-playbook playbooks/setup-homelab.yml --limit qnap

homelab: bootstrap
	ansible-playbook playbooks/setup-homelab.yml

verify:
	ansible-playbook playbooks/verify-homelab.yml

deps:
	pip install --upgrade pip
	pip install -r requirements.txt
	ansible-galaxy install -r requirements.yml

format:
	scripts/format_all_yaml.sh

lint:
	ansible-lint host_vars
	ansible-lint group_vars
	ansible-lint roles
	ansible-lint playbooks

backup:
	ansible-playbook playbooks/backup-docker-volumes.yml

restore:
	ansible-playbook playbooks/restore-docker-volumes.yml
