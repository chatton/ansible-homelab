# proxmox_bootstrap

## Purpose

Bootstraps and reconciles the `pve` Proxmox VE host (a System76 Serval WS
repurposed for server duty): creates the standard `homelab_user`
(cianhatton) admin user, installs the existing shared SSH public key for
that user (and root), grants passwordless sudo, disables SSH password
authentication (and, optionally, direct root login), creates a matching
Proxmox VE user (`{{ homelab_user }}@pam`) with admin access, disables
lid-switch suspend/sleep behavior, and (if the kernel exposes the sysfs
interface) sets battery charge thresholds for longevity.

Every task is idempotent and runs every time - the very first run
(`playbooks/bootstrap-proxmox.yml`, connecting as root with `--ask-pass`,
since `homelab_user` doesn't exist yet) and every regular/reconciliation
run afterwards (`playbooks/setup-homelab.yml`, `hosts: proxmox`, connecting
as `homelab_user`) execute the exact same task list. There is no separate
"only run after verifying key access" hardening phase: the same SSH key is
installed for both `homelab_user` and root before SSH is hardened in the
same run, so key-based access survives even on the very first pass. Full
root SSH lockout is opt-in only, via `-e proxmox_ssh_harden_disable_root_login=true`.

## Managed image(s)

None - this role has no container image tag to track.

## Known upgrade constraints

- The SSH public key is the same one used elsewhere in the repo, read via
  `lookup('file', '~/.ssh/id_rsa_personal.pub')` from the control machine -
  no key is generated or stored in this repo.
- `pveum`/`pvesh` are called directly on the node as root (no API
  token/credentials needed) - this only works when run against the actual
  Proxmox VE host.
- Stock Proxmox VE installs enable the enterprise apt repos
  (`pve-enterprise.sources`, and a `ceph.sources` one on some installs),
  which 401 without a paid subscription and break every apt task. The role
  disables those (if present) and adds the free no-subscription
  equivalents - written for the PVE 9/trixie deb822 `.sources` format. If
  a host uses the older `.list` format, or a valid subscription key is
  meant to be used instead, these tasks will need adjusting.

## Manual steps required for an upgrade

_(Filled in by the maintenance agent, or by hand, as they're discovered - e.g. vault vars to add, TLS certs to (re)generate, DB migrations to run.)_

None documented yet.

## Upgrade history

_(The maintenance agent should append an entry here whenever it opens a version-bump PR for this role: date, old version, new version, PR link.)_

None yet.
