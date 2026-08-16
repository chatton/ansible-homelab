# portainer_nginx_proxy_manager

## Purpose

Deploys Nginx Proxy Manager, the reverse proxy + Let's Encrypt certificate manager that fronts other services in this repo. TLS certs for other services generally flow through here.

## Managed image(s)

- `jlesage/nginx-proxy-manager` via `nginx_proxy_manager_tag` (currently `v23.04.1`) - https://github.com/jlesage/docker-nginx-proxy-manager/releases

## Known upgrade constraints

None documented yet.

## Other notes

Other services' TLS/routing depends on this one being correctly configured - treat config-changing upgrades cautiously and call out any proxy-host reconfiguration needed as a manual step.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

