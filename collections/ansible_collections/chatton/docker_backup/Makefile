e2e: test clean

test:
	cp -r tests/host_vars .
	cp tests/ansible.cfg .
	cp tests/docker-compose.yml .
	cp tests/playbook.yml .
	ansible-playbook playbook.yml

clean:
	rm -r host_vars
	rm ansible.cfg
	rm docker-compose.yml
	rm playbook.yml

deps:
	pip install -r requirements.txt
