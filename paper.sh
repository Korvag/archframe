
#!/bin/bash

for i in $(find ~/wallpapers/active/ -type f | cut -d/ -f6);
	do
		mv ~/wallpapers/active/$i ~/wallpapers/$I
	done

entries=("$(ls -p ~/wallpapers/ | grep -v /)")

echo $entries


while true
	do
		file=$(find ~/wallpapers/active/ -type f | cut -d/ -f6)
		if [[ $file != "" ]]
			then mv ~/wallpapers/active/$file ~/wallpapers/$file
		fi

#		ls ~/wallpapers/active/

#		entries=("$(ls -p ~/wallpapers/ | grep -v /)")
#		echo $entries

		wallpaper=(${entries[0]})
		entries=${entries[@]/$wallpaper}
#		echo $entries
		entries+=" $wallpaper"
#		echo $entries

		mv ~/wallpapers/$wallpaper ~/wallpapers/active/$wallpaper
#		ls ~/wallpapers/active/

		path='$HOME/wallpapers/active/'
		wp=$wallpaper

		echo -e "preload = $path$wp\nwallpaper = eDP-1,$path$wp" > ~/.config/hypr/hyprpaper.conf

#		cat ~/.config/hypr/hyprpaper.conf

		pkill hyprpaper
		hyprpaper &

		sleep 300
	done
