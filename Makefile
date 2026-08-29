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

monitoring:
	ansible-playbook playbooks/setup-homelab.yml --tags monitoring

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

maintenance-agent:
	ansible-playbook playbooks/homelab_maintenance_agent.yml

npm-tf-apply:
	cd terraform/nginx-proxy-manager && terraform apply

grafana-tf-apply:
	cd terraform/grafana && terraform apply

radarr-tf-plan:
	cd terraform/radarr && terraform plan -var-file=../common.tfvars -var-file=../common_secrets.tfvars

radarr-tf-apply:
	cd terraform/radarr && terraform apply -var-file=../common.tfvars -var-file=../common_secrets.tfvars

sonarr-tf-plan:
	cd terraform/sonarr && terraform plan -var-file=../common.tfvars -var-file=../common_secrets.tfvars

sonarr-tf-apply:
	cd terraform/sonarr && terraform apply -var-file=../common.tfvars -var-file=../common_secrets.tfvars

days ?= 14
stale-downloads:
	scp roles/portainer_arr/files/find_stale_downloads.sh qnap:/tmp/find_stale_downloads.sh
	ssh qnap "chmod +x /tmp/find_stale_downloads.sh && /tmp/find_stale_downloads.sh $(days)"
