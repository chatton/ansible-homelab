# portainer_nginx_proxy_manager

## Purpose

Deploys Nginx Proxy Manager, the reverse proxy + Let's Encrypt certificate manager that fronts other services in this repo. TLS certs for other services generally flow through here.

## Managed image(s)

- `jlesage/nginx-proxy-manager` via `nginx_proxy_manager_tag` (bumped to `v26.08.2`, was `v23.04.1`, not yet deployed) - https://github.com/jlesage/docker-nginx-proxy-manager/releases

## Known upgrade constraints

`v23.04.1` bundles NPM core `2.9.22`. `v26.08.2` bundles NPM core `2.15.1` - this jump crosses
several NPM core version boundaries, each with its own DB migration (NPM uses knex.js migrations
against the sqlite DB in the `data` volume, applied automatically on container start):

- NPM `2.10.0` (image `v23.08.1`): refactored config handling - moved off the `config` npm
  package to env vars / files under `/data`, and added running services as a specific
  PUID/PGID user instead of root. jlesage's base image already manages its own PUID/GID scheme
  independently, so this is *believed* low-risk here, but hasn't been verified against this repo's setup.
- NPM `2.11.x` (image `v24.07.1`): upstream release notes explicitly warn of possible breaking
  changes and recommend a backup before upgrading, without enumerating specifics.
  This is the same NPM API response format still returning booleans as `0`/`1` integers
  (confirmed against this instance at `2.9.22`) - unclear from changelogs alone which version
  in this range switches to real JSON booleans; worth re-checking the API after upgrading if
  that matters again (e.g. for the nginxproxymanager Terraform provider).
- NPM `2.14.0` (image `v26.03.1`): certbot DNS plugins are now pre-installed in virtualenvs -
  only matters if any proxy host here uses a DNS-01 challenge (checked: none currently do).
- Starting at image `v26.03.2`, jlesage's wrapper began taking its own DB backup before running
  NPM's internal upgrade/migration step - an implicit signal upstream considers these migrations
  risky enough to want a rollback path.

The DB migration is one-way: redeploying the old image tag after a failed migration will not
revert the sqlite schema. The volume-level backup (see below) is the actual rollback path.

## Other notes

Other services' TLS/routing depends on this one being correctly configured - treat config-changing upgrades cautiously and call out any proxy-host reconfiguration needed as a manual step.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

- Take a fresh backup of the `nginx-proxy-manager_data` volume before deploying (e.g.
  `ansible-playbook playbooks/backup-docker-volumes.yml --limit qnap -e schedule=weekly`, which
  backs up everything on qnap labeled for weekly backup, including this stack) - the sqlite DB
  migration NPM runs on first start of the new version cannot be reverted by just rolling the
  image tag back.
- After deploying, verify every existing proxy host still resolves and its certificate is still
  valid/auto-renewing (`GET /api/nginx/certificates` and `/api/nginx/proxy-hosts` via the API, or
  just check the UI) before considering the upgrade done.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

