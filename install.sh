#!/bin/bash

#papers=''

read -p 'Do you want to install extra wallpapers? [Y/n]: ' walls
if [ $walls == 'Y' ] || [ $walls == 'y' ] || [ $walls == '' ]
    then git clone https://github.com/D3Ext/aesthetic-wallpapers.git && papers='y'
    else papers='n'
fi

echo $papers

git clone https://github.com/Alexays/Waybar
git clone https://aur.archlinux.org/sddm-sugar-dark.git
git clone https://aur.archlinux.org/yay-bin


#installers
sudo pacman -S meson ninja cmake scdoc pkgconf --noconfirm


#dependencies
sudo pacman -S jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog libgtk-3-dev gobject-introspection libgirepository1.0-dev \
    libpulse libappindicator-gtk3 libdbusmenu-gtk3 libmpdclient libevdev upower pango cairo file libglvnd libjpeg-turbo libwebp hyprlang gcc pamixer \
    libnl libsndio xkbregistry --noconfirm


#packages
sudo pacman -S glib2-devel hyprpaper neofetch btop gtkmm3 thunar --noconfirm

sudo pacman -S python --noconfirm
sudo pacman -S python-pip --noconfirm
sudo pacman -S python-packaging --noconfirm

#build packages
cd yay-bin
makepkg -srci --noconfirm

cd ~/Waybar
sudo meson build
sudo ninja -C build
sudo ninja -C build install

cd ~/hyprpaper
make all

cd ~/sddm-sugar-dark
makepkg pkgbuild -srci --noconfirm
cd

mkdir wallpapers
mkdir wallpapers/active
#sudo mkdir /usr/local/etc/xdg/
#sudo mkdir /usr/local/etc/xdg/waybar
cd

#set up configs
sudo cp ~/archpkgs/tree.jpg /usr/share/sddm/themes/sugar-dark/Backgrounds/
sudo cp ~/archpkgs/tree.jpg ~/wallpapers/active/
sudo cp ~/archpkgs/wall2.png ~/wallpapers/
sudo cp ~/archpkgs/theme.conf /usr/share/sddm/themes/sugar-candy/
sudo cp ~/archpkgs/default.conf /usr/lib/sddm/sddm.conf.d/
sudo cp ~/archpkgs/hyprpaper.conf ~/.config/hypr/
sudo cp ~/archpkgs/hyprland.conf ~/.config/hypr/
sudo cp ~/archpkgs/btop.sh ~/.config/hypr
sudo cp ~/archpkgs/waybar.conf /usr/local/etc/xdg/waybar/waybar.conf
sudo mv /usr/local/etc/xdg/waybar/waybar.conf /usr/local/etc/xdg/waybar/config
sudo cp -f ~/archpkgs/style.css /usr/local/etc/xdg/waybar/style.css
sudo cp ~/archpkgs/.bashrc ~/
sudo cp ~/archpkgs/.nanorc ~/
sudo cp ~/archpkgs/kitty.conf ~/.config/kitty/
sudo cp ~/archpkgs/startup.sh ~/.config/hypr/
sudo cp ~/archpkgs/paper.sh ~/

if [ $papers == 'y' ]
    then sudo mv ~/aesthetic-wallpapers/images/* ~/wallpapers/
fi

#add startup script
cd
sudo chmod +x ~/.config/hypr/btop.sh

rm -rf ~/aesthetic-wallpapers
rm -rf ~/sddm-sugar-dark
rm -rf ~/yay-bin
sudo rm -rf ~/Waybar

read -p 'Reboot? [Y/N]: ' confirm
if [ $confirm == 'y' ] || [ $confirm == 'Y' ]
    then exec reboot
    else exec clear
fi

