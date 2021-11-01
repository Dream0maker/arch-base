#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "maanvir" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 maanvir.localdomain maanvir" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr libvirt networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers bluez bluez-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack os-prober ntfs-3g

# pacman -S --noconfirm xf86-video-amdgpu
pacman -S --noconfirm nvidia-dkms 

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch_linux
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable fstrim.timer
systemctl enable libvirtd

useradd -m maanvir
echo maanvir:password | chpasswd
usermod -aG libvirt maanvir

echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/maanvir


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




