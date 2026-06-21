#!/bin/bash

set -euo pipefail

BACKUP_MOUNT="/mnt/c1f11c8d-6f77-426c-aca6-295b08380de5"
KEEP=10
LOG="/var/log/btrfs-backup-and-retention.log"

echo "[$(date '+%F %T')] === Backup+Retention Start ===" | tee -a "$LOG"

mkdir -p "$BACKUP_MOUNT/root"
mkdir -p "$BACKUP_MOUNT/home"

get_latest_snapshot() {
  local path="$1"
  ls -1 "$path" | sort -n | tail -n 1
}

do_backup() {
  local src_snapshots="$1"
  local dst_path="$2"
  local label="$3"

  latest=$(get_latest_snapshot "$src_snapshots")
  latest_src="$src_snapshots/$latest/snapshot"

  prev=$(ls -1 "$dst_path" | sort -n | tail -n 1 || true)

  echo "[$(date '+%F %T')] $label: latest=$latest prev=$prev" | tee -a "$LOG"

  # Exit if no new snapshot
  if [ "$latest" = "$prev" ]; then
    echo "[$(date '+%F %T')] No new $label snapshot, skipping." | tee -a "$LOG"
    return
  fi

  # Build send command
  if [ -n "$prev" ]; then
    parent_src="$src_snapshots/$prev/snapshot"
    btrfs send -p "$parent_src" "$latest_src" | btrfs receive "$dst_path"
  else
    btrfs send "$latest_src" | btrfs receive "$dst_path"
  fi

  # Rename received snapshot
  if [ -d "$dst_path/snapshot" ]; then
    mv "$dst_path/snapshot" "$dst_path/$latest"
  fi
}

cleanup_subvolume() {
  local path="$1"
  local label="$2"

  snapshots=($(ls -1 "$path" | sort -n))
  count=${#snapshots[@]}

  if ((count <= KEEP)); then
    echo "[$(date '+%F %T')] Nothing to delete for $label (count=$count)" | tee -a "$LOG"
    return
  fi

  delete_count=$((count - KEEP))
  echo "[$(date '+%F %T')] Deleting $delete_count old $label backups" | tee -a "$LOG"

  for ((i = 0; i < delete_count; i++)); do
    old="${snapshots[$i]}"
    btrfs subvolume delete "$path/$old"
  done
}

do_backup "/.snapshots" "$BACKUP_MOUNT/root" "root"
do_backup "/home/.snapshots" "$BACKUP_MOUNT/home" "home"

cleanup_subvolume "$BACKUP_MOUNT/root" "root"
cleanup_subvolume "$BACKUP_MOUNT/home" "home"

echo "[$(date '+%F %T')] === Backup+Retention Finished ===" | tee -a "$LOG"
