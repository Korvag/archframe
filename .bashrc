#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


alias wayconfig='cd /usr/local/etc/xdg/waybar'
alias logout='loginctl kill-session $XDG_SESSION_ID'

wifi() {
	net=$1
	pass=$2
	sudo nmcli dev wifi connect $net password $pass
}

# change terminal colorscheme
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
