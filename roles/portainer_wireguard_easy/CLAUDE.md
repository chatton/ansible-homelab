# portainer_wireguard_easy

## Purpose

Deploys wg-easy, a WireGuard VPN server with a web UI.

## Managed image(s)

- `ghcr.io/wg-easy/wg-easy` via `wireguard_easy_tag` (currently `14`) - https://github.com/wg-easy/wg-easy/releases

## Known upgrade constraints

- v13→v14: Breaking change - `PASSWORD` environment variable replaced by `PASSWORD_HASH` (bcrypt hash required)
- v14→v15: Complete rewrite with major breaking changes - see https://wg-easy.github.io/wg-easy/latest/advanced/migrate/from-14-to-15/

## Other notes

This is the VPN entrypoint into the homelab network - treat upgrades cautiously and confirm connectivity isn't broken after a bump.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

### v13→v14 upgrade
1. Generate bcrypt hash from existing plain-text password:
   ```bash
   docker run --rm ghcr.io/wg-easy/wg-easy:14 wgpw YOUR_PASSWORD
   ```
2. Update vault variable `wireguard_easy_password` → `wireguard_easy_password_hash` with the generated hash
3. Remember to escape `$` characters by doubling them (`$$`) in the vault value for Ansible/docker-compose compatibility

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-22: v13 → v14 (PR TBD) - Breaking change: PASSWORD → PASSWORD_HASH

