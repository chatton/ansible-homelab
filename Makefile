#!/usr/bin/make -f
all: deps homelab

SHELL := /bin/bash

qnap:
	ansible-playbook playbooks/setup-homelab.yml --limit qnap

dell:
	ansible-playbook playbooks/setup-homelab.yml --limit dell

services:
	ansible-playbook playbooks/setup-homelab.yml --tags services

portainer:
	ansible-playbook playbooks/setup-homelab.yml --tags portainer

qnap-services:
	ansible-playbook playbooks/setup-homelab.yml --tags services --limit qnap

homelab:
	ansible-playbook playbooks/setup-homelab.yml

verify:
	ansible-playbook playbooks/verify-homelab.yml

deps:
	pip install --upgrade pip
	pip install -r requirements.txt
	ansible-galaxy install -r requirements.yml

backup: deps
	ansible-playbook playbooks/backup-docker-volumes.yml

backup-qnap: deps
	ansible-playbook playbooks/backup-docker-volumes.yml --limit qnap

backup-qnap-weekly: deps
	ansible-playbook playbooks/backup-docker-volumes.yml --limit qnap -e schedule=weekly

backup-qnap-monthly: deps
	ansible-playbook playbooks/backup-docker-volumes.yml --limit qnap -e schedule=monthly

backup-qnap-dirs: deps
	ansible-playbook playbooks/backup-directories.yml --limit qnap

restore: deps
	ansible-playbook playbooks/restore-docker-volumes.yml -e volume_name="$(volume_name)"  --limit "$(host)"

cron:
	ansible-playbook playbooks/setup-homelab.yml --tags cron
