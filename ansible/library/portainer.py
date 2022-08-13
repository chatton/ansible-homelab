#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
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

class PortainerClient:
    def __init__(self, creds):
        self.base_url = creds["base_url"]
        self.token = _get_jwt_token(creds)
        self.headers = {
            "Authorization": f"Bearer {self.token}"
        }

    def get(self, endpoint):
        url = f"{self.base_url}/api/{endpoint}"
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


def _create_stack(client, module):
    target_stack_name = module.params["stack_name"]
    with open(module.params["docker_compose_file_path"]) as f:
        file_contents = f.read()
    body = {
        "env": [],
        "name": target_stack_name,
        "stackFileContent": file_contents,
    }

    query_params = {
        "type": COMPOSE_STACK,
        "method": STRING_METHOD,
        "endpointId": 2,
    }
    return client.post("stacks", body=body, query_params=query_params)


def _update_stack(client, module, stack_id):
    target_stack_name = module.params["stack_name"]
    with open(module.params["docker_compose_file_path"]) as f:
        file_contents = f.read()
    return client.put(f"stacks/{stack_id}?&endpointId=2", body={
        "env": [],
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

    target_stack_name = module.params["stack_name"]
    for stack in stacks:
        if stack["Name"] == target_stack_name:
            already_exists = True
            result["stack_id"] = stack["Id"]
            break

    if not already_exists:
        stack = _create_stack(client, module)
        result["changed"] = True
        result["stack_id"] = stack["Id"]
        module.exit_json(**result)
        return

    # TODO: is it possible to know if we've changed the stack?
    # the stack exists, we just want to update it.
    _update_stack(client, module, result["stack_id"])
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
        env_file_path=dict(type='str', required=False),
        username=dict(type='str', default='admin'),
        password=dict(type='str', required=True),
        base_url=dict(type='str', default="http://localhost:9000"),
        state=dict(type='str', default="present")
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
        supports_check_mode=True
    )

    client = PortainerClient(creds=_extract_creds(module))
    state_fns[module.params["state"]](client, module)

    # # if the user is working with this module in only check mode we do not
    # # want to make any changes to the environment, just return the current
    # # state with no modifications
    # if module.check_mode:
    #     module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
