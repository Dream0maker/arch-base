#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Paris -a 12 --sort rate --save /etc/pacman.d/mirrorlist

git clone https://aur.archlinux.org/pikaur.git
cd pikaur/
makepkg -si --noconfirm

#pikaur -S --noconfirm system76-power
#sudo systemctl enable --now system76-power
#sudo system76-power graphics integrated
#pikaur -S --noconfirm gnome-shell-extension-system76-power-git
#pikaur -S --noconfirm auto-cpufreq
#sudo systemctl enable --now auto-cpufreq

sudo pacman -S --noconfirm xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings cinnamon firefox arc-gtk-theme arc-icon-theme obs-studio vlc gnome-shell

sudo systemctl enable lightdm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot
