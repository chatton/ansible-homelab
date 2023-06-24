#!/usr/bin/make -f
all: deps bootstrap homelab

SHELL := /bin/bash
bootstrap:
	ansible-playbook playbooks/bootstrap.yml -K -e ansible_ssh_user=cianhatton -e ansible_ssh_private_key_file=~/.ssh/id_rsa

qnap:
	ansible-playbook playbooks/setup-homelab.yml --limit qnap

services:
	ansible-playbook playbooks/setup-homelab.yml --tags services

portainer:
	ansible-playbook playbooks/setup-homelab.yml --tags portainer

qnap-services:
	ansible-playbook playbooks/setup-homelab.yml --tags services --limit qnap

snunmu-services:
	ansible-playbook playbooks/setup-homelab.yml --tags services --limit snunmu

snunmu:
	ansible-playbook playbooks/setup-homelab.yml --limit snunmu

homelab:
	ansible-playbook playbooks/setup-homelab.yml

verify:
	ansible-playbook playbooks/verify-homelab.yml

venv:
	# activate venv if it exists
	if [ -d "./venv" ]; then \
		source venv/bin/activate; \
	fi

deps: venv
	pip install --upgrade pip
	pip install -r requirements.txt
	ansible-galaxy install -r requirements.yml

format:
	scripts/format_all_yaml.sh

lint-all:
	make lint dir=host_vars
	make lint dir=group_vars
	make lint dir=roles
	make lint dir=playbooks

lint:
	ansible-lint $(dir) --exclude "roles/sprat.*" --exclude roles/docker_restore_container --exclude "roles/geerlingguy.*" --exclude collections --exclude .github

backup: deps
	ansible-playbook playbooks/backup-docker-volumes.yml

backup-snunmu: deps
	ansible-playbook playbooks/backup-docker-volumes.yml --limit snunmu

backup-qnap: deps
	ansible-playbook playbooks/backup-docker-volumes.yml --limit qnap

backup-qnap-monthly: deps
	ansible-playbook playbooks/backup-docker-volumes.yml --limit qnap -e schedule=monthly

backup-qnap-dirs: deps
	ansible-playbook playbooks/backup-directories.yml --limit qnap

restore: deps
	ansible-playbook playbooks/restore-docker-volumes.yml -e volume_name="$(volume_name)"  --limit "$(host)"

cron:
	ansible-playbook playbooks/setup-homelab.yml --tags cron
