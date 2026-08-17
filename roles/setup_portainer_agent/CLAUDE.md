# setup_portainer_agent

## Purpose

Installs the Portainer agent on `dell`, which connects it to the Portainer server running on `qnap`.

## Managed image(s)

- `portainer/agent` via `portainer_agent_version` (currently `2.44.0`) - https://github.com/portainer/portainer/releases

## Known upgrade constraints

Keep this version in sync with (or compatible with) `setup_portainer`'s `portainer_version` - the agent and server versions aren't always forward/backward compatible.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-17: 2.20.3 → 2.44.0, PR TBD

