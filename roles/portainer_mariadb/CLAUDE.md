# portainer_mariadb

## Purpose

Deploys a shared MariaDB instance plus Adminer (DB admin UI) on the `mariadb_net` network, used as the backing database for other services in this repo (e.g. BookStack).

## Managed image(s)

- `mariadb` via `mariadb_tag` (currently `10.8.3`) - https://mariadb.com/kb/en/release-notes/
- `adminer` via `adminer_tag` (currently `6.0.1`) - https://hub.docker.com/_/adminer

## Known upgrade constraints

MariaDB major version upgrades need `mariadb-upgrade` run against existing data (or a dump/restore) - never just bump the tag and restart. Take a DB backup before proposing or applying any MariaDB version change, and check which other roles depend on `mariadb_net` before touching this.

## Other notes

None.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.

