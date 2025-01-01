#!/bin/bash


git clone https://github.com/Alexays/Waybar
git clone https://aur.archlinux.org/sddm-sugar-dark.git
git clone https://aur.archlinux.org/yay-bin


#installers
sudo pacman -S meson ninja cmake scdoc pkgconf --noconfirm


#dependencies
sudo pacman -S jsoncpp libsigc++ fmt wayland wayland-protocols chrono-date spdlog gtk3 gobject-introspection libgirepository \
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
sudo mkdir /usr/share/sddm/themes/sugar-dark/Backgrounds
cd

yay -S uwsm --noconfirm

#set up configs
sudo cp ~/archframe/lotusflower.png /usr/share/sddm/themes/sugar-dark/Backgrounds/
sudo cp ~/archframe/lotusflower.png ~/wallpapers/
sudo cp ~/archframe/theme.conf /usr/share/sddm/themes/sugar-dark/
sudo cp ~/archframe/default.conf /usr/lib/sddm/sddm.conf.d/
sudo cp ~/archframe/hyprpaper.conf ~/.config/hypr/
sudo cp ~/archframe/hyprland.conf ~/.config/hypr/
sudo cp ~/archframe/btop.sh ~/.config/hypr/
sudo cp ~/archframe/waybar.conf /usr/local/etc/xdg/waybar/waybar.conf
sudo mv /usr/local/etc/xdg/waybar/waybar.conf /usr/local/etc/xdg/waybar/config
sudo cp -f ~/archframe/style.css /usr/local/etc/xdg/waybar/style.css
sudo cp ~/archframe/.bashrc ~/
sudo cp ~/archframe/.nanorc ~/
sudo cp ~/archframe/kitty.conf ~/.config/kitty/
sudo cp ~/archframe/startup.sh ~/.config/hypr/
sudo cp ~/archframe/paper.sh ~/


#add startup script
cd
sudo chmod +x ~/.config/hypr/btop.sh

rm -rf ~/sddm-sugar-dark
rm -rf ~/yay-bin
sudo rm -rf ~/Waybar

read -p 'Reboot? [Y/N]: ' confirm
if [ $confirm == 'y' ] || [ $confirm == 'Y' ]
    then exec reboot
    else exec clear
fi

