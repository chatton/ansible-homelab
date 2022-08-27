#!/usr/bin/python

from __future__ import (absolute_import, division, print_function)

__metaclass__ = type

import requests

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my longer description explaining my test module.

options:
    name:
        description: This is the message to send to the test module.
        required: true
        type: str
    new:
        description:
            - Control to demo if the result of this module is changed or not.
            - Parameter description can be a list as well.
        required: false
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_doc_fragment_name

author:
    - Your Name (@chatton)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'hello world'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'goodbye'
'''

from ansible.module_utils.basic import AnsibleModule


def _extract_creds(module):
    return {
        "username": module.params["username"],
        "password": module.params["password"],
        "base_url": module.params["base_url"],
    }


def _get_jwt_token(creds):
    payload = {
        "Username": creds["username"],
        "Password": creds["password"],
    }

    base_url = creds["base_url"]
    auth_url = f"{base_url}/api/auth"
    resp = requests.post(auth_url, json=payload)
    resp.raise_for_status()
    return resp.json()["jwt"]


COMPOSE_STACK = 2
STRING_METHOD = "string"


def _query_params_to_string(params):
    s = "?"
    for k, v in params.items():
        s += f"&{k}={v}"
    return s


def _load_envs_from_file(filepath):
    envs = []
    with open(filepath) as f:
        file_contents = f.read()
    lines = file_contents.splitlines()
    for line in lines:
        name, value = line.split("=")
        envs.append({
            "name": name,
            "value": value
        })
    return envs


class PortainerClient:
    def __init__(self, creds):
        self.base_url = creds["base_url"]
        self.token = _get_jwt_token(creds)
        self.headers = {
            "Authorization": f"Bearer {self.token}"
        }

    def get(self, endpoint, query_params=None):
        url = f"{self.base_url}/api/{endpoint}"
        if query_params:
            url = url + _query_params_to_string(query_params)

        res = requests.get(url, headers=self.headers)
        res.raise_for_status()
        return res.json()

    def delete(self, endpoint):
        url = f"{self.base_url}/api/{endpoint}"
        try:
            # TODO: deletion works, but the request fails?
            res = requests.delete(url, headers=self.headers)
            res.raise_for_status()
        except Exception:
            pass
        return {}

    def put(self, endpoint, body):
        url = f"{self.base_url}/api/{endpoint}"
        res = requests.put(url, json=body, headers=self.headers)
        res.raise_for_status()
        return res.json()

    def post(self, endpoint, body, query_params=None):
        url = f"{self.base_url}/api/{endpoint}" + _query_params_to_string(query_params)

        res = requests.post(url, json=body, headers=self.headers)
        res.raise_for_status()
        return res.json()


def _create_stack(client, module, file_contents, envs=None):
    if not envs:
        envs = []
    target_stack_name = module.params["stack_name"]
    body = {
        "env": envs,
        "name": target_stack_name,
        "stackFileContent": file_contents,
    }

    query_params = {
        "type": COMPOSE_STACK,
        "method": STRING_METHOD,
        "endpointId": 2,
    }
    return client.post("stacks", body=body, query_params=query_params)


def _update_stack(client, module, stack_id, envs=None):
    if not envs:
        envs = []
    target_stack_name = module.params["stack_name"]
    with open(module.params["docker_compose_file_path"]) as f:
        file_contents = f.read()
    return client.put(f"stacks/{stack_id}?&endpointId=2", body={
        "env": envs,
        "name": target_stack_name,
        "stackFileContent": file_contents,
    })


def handle_state_present(client, module):
    result = dict(
        changed=False,
        stack_name=module.params["stack_name"]
    )

    already_exists = False
    stacks = client.get("stacks")
    result["stacks"] = stacks

    with open(module.params["docker_compose_file_path"]) as f:
        file_contents = f.read()

    target_stack_name = module.params["stack_name"]
    for stack in stacks:
        if stack["Name"] == target_stack_name:
            already_exists = True
            result["stack_id"] = stack["Id"]
            break

    if not already_exists:
        stack = _create_stack(client, module, file_contents)
        result["changed"] = True
        result["stack_id"] = stack["Id"]
        module.exit_json(**result)
        return

    stack_id = result["stack_id"]
    current_file_contents_resp = client.get(f"stacks/{stack_id}/file", query_params={
        "endpointId": 2
    })

    result["are_equal"] = current_file_contents_resp["StackFileContent"] == file_contents
    if result["are_equal"]:
        module.exit_json(**result)
        return

    # the stack exists and we have a new config.
    _update_stack(client, module, stack_id)
    result["changed"] = True
    module.exit_json(**result)


def handle_state_absent(client, module):
    result = dict(
        changed=False,
        stack_name=module.params["stack_name"]
    )
    already_exists = False
    target_stack_name = module.params["stack_name"]
    stacks = client.get("stacks")
    for stack in stacks:
        if stack["Name"] == target_stack_name:
            already_exists = True
            result["stack_id"] = stack["Id"]
            break

    if not already_exists:
        module.exit_json(**result)
        return

    stack_id = result['stack_id']
    client.delete(f"stacks/{stack_id}" + _query_params_to_string({"endpointId": 2}))
    result["changed"] = True
    module.exit_json(**result)


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        stack_name=dict(type='str', required=True),
        docker_compose_file_path=dict(type='str', required=True),
        username=dict(type='str', default='admin'),
        password=dict(type='str', required=True, no_log=True),
        base_url=dict(type='str', default="http://localhost:9000"),
        state=dict(type='str', default="present", choices=['present', 'absent'])
    )

    state_fns = {
        "present": handle_state_present,
        "absent": handle_state_absent
    }

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=False
    )

    client = PortainerClient(creds=_extract_creds(module))
    state_fns[module.params["state"]](client, module)


def main():
    run_module()


if __name__ == '__main__':
    main()
