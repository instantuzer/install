#!/bin/bash
set -euo pipefail

# --- Prompt for user info ---
read -rp "Enter your desired username: " USERNAME

# Prompt for password securely (input hidden)
while true; do
    read -rsp "Enter password for $USERNAME: " PASSWORD
    echo
    read -rsp "Confirm password: " PASSWORD_CONFIRM
    echo
    if [ "$PASSWORD" == "$PASSWORD_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Please try again."
    fi
done

# --- Disk selection (default to /dev/sda) ---
DISK="/dev/nvme0n1"
echo "Installing to $DISK (all data on this disk will be erased!)"
read -rp "Are you sure? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "Installation aborted."
    exit 1
fi

# --- Partitioning (Wipes Disk!) ---
echo "Partitioning $DISK..."
sgdisk -Z $DISK
sgdisk -n 1::+3G -t 1:EF00 -c 1:"EFI" $DISK
sgdisk -n 2::+275G -t 2:8300 -c 2:"ROOT" $DISK

# --- Formatting ---
mkfs.fat ${DISK}p1
mkfs.ext4 ${DISK}p2

# --- Mounting ---
mount ${DISK}p2 /mnt
mount -m ${DISK}p1 /mnt/boot

# --- Install base system ---
pacstrap /mnt base linux-zen linux-firmware-intel intel-ucode vim nvim sudo git networkmanager grub efibootmgr xorg xorg-xinit xf86-video-intel libva-intel-driver i3 alacritty rofi firefox noto-fonts exa jq bc zip unzip lolcat xcolor pipewire pipewire-pulse brightnessctl playerctl mtpfs

# --- Fstab ---
genfstab -U /mnt >> /mnt/etc/fstab

# --- Chroot and setup ---
arch-chroot /mnt /bin/bash <<EOF
set -e

# Hostname
echo "staticlol" > /etc/hostname

# Timezone and localization
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Root password
echo "root:$PASSWORD" | chpasswd

# User creation
useradd -mG wheel -s /bin/bash $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

EOF

#!/bin/bash

# Prompt user for password (won't echo)
read -s -p "Enter GPG password: " GPG_PASS
echo

URL="https://tinyurl.com/instantdot"

# File to decrypt (edit as needed)
GPG_FILE="instantdot.gpg"
OUTPUT_FILE="instantdot.zip"

echo "Downloading $URL..."
if curl -f -L -o "$GPG_FILE" "$URL"; then
    echo "Download finished successfully!"
else
    echo "Download failed! Exiting."
    exit 1
fi

# Decrypt using password from variable
echo "$GPG_PASS" | gpg --batch --yes --passphrase-fd 0 -o "$OUTPUT_FILE" -d "$GPG_FILE"

# Check if decryption succeeded
if [ $? -eq 0 ]; then
    echo "Decryption successful. Unzipping..."
    unzip -o "$OUTPUT_FILE" -d "/mnt"
else
    echo "Decryption failed!"
    exit 1
fi

echo "Installation complete! Reboot now."

