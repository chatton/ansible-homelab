#!/bin/sh
# Reports (does not delete) items under the completed-downloads tree older
# than DAYS (default 14) - stuff that finished downloading but was never
# picked up/imported by Radarr/Sonarr/Lidarr, or was left behind. Review the
# list and delete manually; this is a report-only tool.
set -eu
DAYS="${1:-14}"
BASE="/mnt/ssd0/downloads/completed"

for dir in "$BASE"/Movies "$BASE"/Music "$BASE"/Series; do
  [ -d "$dir" ] || continue
  find "$dir" -mindepth 1 -maxdepth 1 -mtime "+${DAYS}" -printf '%TY-%Tm-%Td\t%p\n'
done | sort |
  while IFS="$(printf '\t')" read -r mtime path; do
    size=$(du -sh "$path" 2>/dev/null | cut -f1)
    printf '%s\t%s\t%s\n' "$mtime" "$size" "$path"
  done
