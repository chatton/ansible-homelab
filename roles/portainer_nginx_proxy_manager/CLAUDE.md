# portainer_nginx_proxy_manager

## Purpose

Deploys Nginx Proxy Manager, the reverse proxy + Let's Encrypt certificate manager that fronts other services in this repo. TLS certs for other services generally flow through here.

## Managed image(s)

- `jlesage/nginx-proxy-manager` via `nginx_proxy_manager_tag` (currently `v24.12.1`) - https://github.com/jlesage/docker-nginx-proxy-manager/releases

## Known upgrade constraints

None documented yet. Release notes from v23→v24→v25→v26 show incremental updates (Nginx Proxy Manager version bumps, base image updates) without documented breaking changes, but given this service's critical role as the TLS terminator for all other services, upgrades should be applied incrementally and validated carefully.

## Other notes

Other services' TLS/routing depends on this one being correctly configured - treat config-changing upgrades cautiously and call out any proxy-host reconfiguration needed as a manual step.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-24: v23.04.1 → v24.12.1 (step 1 of 3 to reach v26.08.2) - PR TBD

