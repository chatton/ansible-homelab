# portainer_gitea

## Purpose

Deploys Gitea, self-hosted git hosting.

## Managed image(s)

- `gitea/gitea` via `gitea_tag` (currently `1.19.0`) - https://github.com/go-gitea/gitea/releases

## Known upgrade constraints

Back up the Gitea data volume + DB before upgrading. Gitea's release notes call out required manual migration steps on some major bumps - read them before proposing a jump across a major version.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

