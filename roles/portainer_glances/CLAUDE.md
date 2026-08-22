# portainer_glances

## Purpose

Deploys Glances, a system monitoring dashboard.

## Managed image(s)

- `nicolargo/glances` via `glances_tag` (currently `alpine-3.3.0.2`) - https://github.com/nicolargo/glances/releases

## Known upgrade constraints

- Alpine images appear discontinued after v3.3.0.2; later versions (4.x+) use ubuntu-based images
- v4.5.2 introduced breaking CORS/security changes requiring configuration updates

## Other notes

Now pinned to `alpine-3.3.0.2`. Future upgrades to v4.x will require switching to ubuntu-based images (e.g., `ubuntu-4.5.6` or just `4.5.6`).

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

- Upgrading to v4.x: change image tag format from `alpine-X.X.X` to `ubuntu-X.X.X` or just `X.X.X`
- v4.5.2+: configure CORS allowed_origins and allowed_hosts if running in web server mode

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-22: latest-alpine → alpine-3.3.0.2 (pinning floating tag) - PR #101

