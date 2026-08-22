# docker_restore_container

## Purpose

Restores a Docker volume/container from an S3 backup, via the `chatton.docker_backup` collection.

## Managed image(s)

None - this role has no container image tag to track.

## Known upgrade constraints

None documented yet.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

- 2026-08-22: Updated all module calls to use FQCN format (ansible.builtin.*, community.docker.*) to address deprecation warnings - PR TBD

