#!/usr/bin/python

from __future__ import absolute_import, division, print_function

__metaclass__ = type

from ansible.module_utils.basic import AnsibleModule

try:
    # FIXME: Hack to make imports work with IDE. The ansible import path is not valid for a regular python
    # project.
    from plugins.module_utils.portainer import *
except ImportError:
    from ansible_collections.chatton.portainer.plugins.module_utils.portainer import (
        PortainerClient,
        _query_params_to_string,
    )

DOCUMENTATION = r"""
---
module: portainer_stack

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
"""

EXAMPLES = r"""
# Deploy Gitea, Plex and Mealie stacks to portainer provided the files exist.
- name: Portainer | Update Stack
  chatton.portainer.portainer_stack:
    username: admin
    password: "{{portainer.password}}"
    docker_compose_file_path: "/etc/docker-compose/{{ item.name }}/docker-compose.yml"
    stack_name: "{{ item.name }}"
    endpoint_id: "{{ item.endpoint_id }}"
    state: present
  with_items:
    - name: gitea
      endpoint_id: 1
    - name: plex
      endpoint_id: 2
    - name: mealie
      endpoint_id: 3

# Delete plex stack
- name: Portainer | Delete Plex Stack
  chatton.portainer.portainer_stack:
    username: admin
    password: "{{portainer.password}}"
    stack_name: "plex"
    endpoint_id: "2"
    state: absent
"""

RETURN = r"""
# These are examples of possible return values, and in general should use other names for return values.
username:
    description: The Portainer username.
    type: str
    returned: always
    sample: 'admin'
password:
    description: The provided user's password.
    type: str
    returned: never
    sample: 'MyS00p3rS3cretPassw0rd'
docker_compose_file_path:
    description: The path to a docker compose file which will be used to create the Portainer stack.
    type: str
    returned: never
    sample: ''
"""


COMPOSE_STACK = 2
STRING_METHOD = "string"


def _create_stack(client, module, file_contents):
    target_stack_name = module.params["stack_name"]
    body = {
        "name": target_stack_name,
        "stackFileContent": file_contents,
    }

    query_params = {
        "type": COMPOSE_STACK,
        "method": STRING_METHOD,
        "endpointId": client.endpoint,
    }
    return client.post("stacks", body=body, query_params=query_params)


def _update_stack(client, module, stack_id):
    target_stack_name = module.params["stack_name"]
    with open(module.params["docker_compose_file_path"]) as f:
        file_contents = f.read()
    return client.put(
        f"stacks/{stack_id}?&endpointId={client.endpoint}",
        body={
            "name": target_stack_name,
            "stackFileContent": file_contents,
        },
    )


def handle_state_present(client, module):
    result = dict(changed=False, stack_name=module.params["stack_name"])

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
    current_file_contents_resp = client.get(
        f"stacks/{stack_id}/file", query_params={"endpointId": client.endpoint}
    )

    result["are_equal"] = (
        current_file_contents_resp["StackFileContent"] == file_contents
    )
    if result["are_equal"]:
        module.exit_json(**result)
        return

    # the stack exists and we have a new config.
    _update_stack(client, module, stack_id)
    result["changed"] = True
    module.exit_json(**result)


def handle_state_absent(client, module):
    result = dict(changed=False, stack_name=module.params["stack_name"])
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

    stack_id = result["stack_id"]
    client.delete(
        f"stacks/{stack_id}" + _query_params_to_string({"endpointId": client.endpoint})
    )
    result["changed"] = True
    module.exit_json(**result)


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        stack_name=dict(type="str", required=True),
        docker_compose_file_path=dict(type="str"),
        username=dict(type="str", default="admin"),
        password=dict(type="str", required=True, no_log=True),
        endpoint_id=dict(type="int", required=True),
        base_url=dict(type="str", default="http://localhost:9000"),
        state=dict(type="str", default="present", choices=["present", "absent"]),
    )

    required_if = [
        # docker compose file is only required if we are ensuring the stack is present.
        ["state", "present", ("docker_compose_file_path",)],
    ]

    state_fns = {"present": handle_state_present, "absent": handle_state_absent}

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        required_if=required_if,
        # TODO: support check mode
        supports_check_mode=False,
    )

    client = PortainerClient(
        base_url=module.params["base_url"], endpoint=module.params["endpoint_id"]
    )
    client.login(module.params["username"], module.params["password"])

    state_fns[module.params["state"]](client, module)


def main():
    run_module()


if __name__ == "__main__":
    main()
