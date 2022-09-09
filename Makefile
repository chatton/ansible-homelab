#!/usr/bin/make -f
all: deps bootstrap homelab

SHELL := /bin/bash
bootstrap:
	ansible-playbook playbooks/bootstrap.yml -K -e ansible_ssh_user=cianhatton -e ansible_ssh_private_key_file=~/.ssh/id_rsa

qnap:
	ansible-playbook playbooks/setup-homelab.yml --limit qnap

services:
	ansible-playbook playbooks/setup-homelab.yml --tags services

snunmu:
	ansible-playbook playbooks/setup-homelab.yml --limit snunmu


homelab:
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
	ansible-lint roles --exclude "roles/sprat.*" --exclude roles/docker_restore_container --exclude "roles/geerlingguy.*"
	ansible-lint playbooks --exclude "roles/sprat.*" --exclude roles/docker_restore_container --exclude "roles/geerlingguy.*"

backup: deps
	ansible-playbook playbooks/backup-docker-volumes.yml

restore: deps
	ansible-playbook playbooks/restore-docker-volumes.yml

cron:
	ansible-playbook playbooks/setup-homelab.yml --tags cron
