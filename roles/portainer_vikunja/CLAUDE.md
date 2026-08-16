# portainer_vikunja

## Purpose

Deploys Vikunja, a task/project management app, as separate API and frontend containers.

## Managed image(s)

- `vikunja/api` via `vikunja_api_tag` (currently `0.21.0`) - https://github.com/go-vikunja/vikunja/releases
- `vikunja/frontend` via `vikunja_frontend_tag` (currently `0.21.0`) - https://github.com/go-vikunja/vikunja/releases

## Known upgrade constraints

`vikunja_api_tag` and `vikunja_frontend_tag` must always be bumped together to the same version - never propose a PR that changes only one of them.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

