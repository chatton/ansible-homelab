# portainer_arr Role

This role manages the arr stack (media acquisition and management) including:
- ProtonWire VPN (container networking via ProtonVPN)
- qBittorrent (torrent client)
- Radarr (movie management)
- Sonarr (TV show management)
- Lidarr (music management)
- Jackett (indexer proxy)

## Managed Images

### ProtonWire VPN
- **Image**: `ghcr.io/tprasadtp/protonwire`
- **Current version**: 7.5.3
- **Source**: https://github.com/tprasadtp/protonvpn-docker/releases
- **Upgrade constraints**: Patch versions (7.5.x) are generally safe. Review release notes for minor/major version changes.

### qBittorrent
- **Image**: `lscr.io/linuxserver/qbittorrent`
- **Current version**: 4.6.3
- **Source**: https://github.com/linuxserver/docker-qbittorrent/releases
- **Upgrade constraints**: Major version upgrades may require configuration migration.

### Radarr
- **Image**: `lscr.io/linuxserver/radarr`
- **Current version**: 5.26.2.10099-ls281
- **Source**: https://github.com/linuxserver/docker-radarr/releases
- **Upgrade constraints**: Major version upgrades may change database schema.

### Sonarr
- **Image**: `lscr.io/linuxserver/sonarr`
- **Current version**: 4.0.15.2941-ls290
- **Source**: https://github.com/linuxserver/docker-sonarr/releases
- **Upgrade constraints**: Stay within v4 branch for now.

### Lidarr
- **Image**: `blampe/lidarr`
- **Current version**: latest (FLOATING TAG - should be pinned)
- **Source**: https://github.com/lidarr/Lidarr
- **Upgrade constraints**: Unknown - using third-party image.
- **Note**: Currently using floating 'latest' tag - see issue #60 for pinning this.

### Jackett
- **Image**: `lscr.io/linuxserver/jackett`
- **Current version**: 0.21.2354
- **Source**: https://github.com/linuxserver/docker-jackett/releases
- **Upgrade constraints**: Generally safe to upgrade within minor versions.

## Upgrade History

### 2026-08-16: ProtonWire 7.5.0 → 7.5.3
- **PR**: TBD
- **Type**: Patch upgrade (non-breaking)
- **Changes**: Bug fixes for kill switch stability and custom entrypoint handling
- **Release notes**: https://github.com/tprasadtp/protonvpn-docker/releases/tag/7.5.3
