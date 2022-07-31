FROM debian

# Install prerequisities for Ansible
RUN apt-get update
RUN apt-get -y install python3 python3-nacl python3-pip libffi-dev

# Install ansible
RUN pip3 install ansible

# Copy your ansible configuration into the image
ADD ansible /ansible
COPY ansible/homelab/hosts /etc/ansible/hosts

CMD [ "ansible-playbook", "/ansible/homelab/playbooks/setup-home-lab.yml", "-v","--connection", "local"]
