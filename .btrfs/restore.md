# Btrfs Restore Guide (Root + Home) from SSD2 to SSD1

This document explains how to restore your Btrfs `root` and `home` subvolumes from your backup disk (SSD2) back onto your system disk (SSD1) using a Linux live environment.

Your setup:

- **SSD1 (system disk)**  
  - Subvolumes: `root`, `home`

- **SSD2 (backup disk)**  
  - Backup structure:  
    ```
    /mnt/backup/root/<ID>/
    /mnt/backup/home/<ID>/
    ```
  - Each `<ID>` (e.g., `5`) is already a Btrfs subvolume.

---

## 1. Boot into a Live System

Use any Linux live ISO (Ubuntu, Arch, openSUSE, etc.).  
Make sure SSD1 is **not mounted**.

---

## 2. Identify your disks

```bash
lsblk -f
```

Determine:

- SSD1 (system disk) → e.g. `/dev/sda2`
- SSD2 (backup disk) → e.g. `/dev/sdb1`

---

## 3. Mount SSD1 (target disk)

Mount the top-level Btrfs volume:

```bash
mount -o subvol=/ /dev/sdXn /mnt
```

Replace `sdXn` with your SSD1 partition.

---

## 4. Delete existing root and home subvolumes

```bash
btrfs subvolume delete /mnt/root
btrfs subvolume delete /mnt/home
```

If they don’t exist, ignore the errors.

---

## 5. Mount SSD2 (backup disk)

```bash
mkdir /mnt/backup
mount /dev/sdYn /mnt/backup
```

Replace `sdYn` with your SSD2 partition.

You should now see:

```
/mnt/backup/root/5/
/mnt/backup/home/5/
```

Each of these directories is a **Btrfs subvolume**, not a folder containing another subvolume.

---

## 6. Restore the ROOT subvolume

Choose the snapshot ID you want to restore (example: `5`).

Send from SSD2 → receive on SSD1:

```bash
btrfs send /mnt/backup/root/5 | btrfs receive /mnt
```

This creates:

```
/mnt/5
```

Rename it to `root`:

```bash
mv /mnt/5 /mnt/root
```

---

## 7. Restore the HOME subvolume

```bash
btrfs send /mnt/backup/home/5 | btrfs receive /mnt
mv /mnt/5 /mnt/home
```

---

## 8. Verify the restored structure

```bash
ls /mnt
```

Expected:

```
root
home
```

Both are Btrfs subvolumes.

---

## 9. Check your fstab

Ensure `/mnt/root/etc/fstab` contains:

```
UUID=<SSD1-UUID> /     btrfs subvol=root,defaults 0 0
UUID=<SSD1-UUID> /home btrfs subvol=home,defaults 0 0
```

Edit if needed:

```bash
nano /mnt/root/etc/fstab
```

---

## 10. (Optional) Repair GRUB

If the system does not boot:

```bash
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
chroot /mnt

grub-install /dev/sdX
update-grub
exit
```

Replace `sdX` with your system disk (e.g., `/dev/sda`).

---

## 11. Reboot

Unmount everything:

```bash
umount -R /mnt
umount /mnt/backup
```

Reboot:

```bash
reboot
```

Your system should now boot exactly as it was at snapshot **5**.


