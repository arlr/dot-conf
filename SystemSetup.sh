#!/bin/bash

# Variables
# Dest configuration folder
CONFIG="$HOME/.config"

#Work arround for non interactive install
export DEBIAN_FRONTEND=noninteractive
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime


# Updates
updates () {
	sudo apt update && sudo apt upgrade -y
}

# Handy paquet
# Set of paquet that are often used
setup_handy () {
	HANDY_PQT=" openvpn wget curl nmap htop dialog "
	echo "Setup handy paquets:"
	echo $HANDY_PQT
	sudo apt install $HANDY_PQT -y
}

# FISH setup
setup_fish () {

	echo "Setup FISH"
	echo "Install fish paquet"
	sudo apt install fish -y
}

# Tmux Setup
setup_tmux () {
	echo "Setup Tmux"
	echo "Install tmux paquet"
	sudo apt install tmux -y
	cp .tmux.conf ~/.tmux.conf
	#Install tmux plugins
	tmux new-session -d "~/.tmux/plugins/tpm/bin/install_plugins; exit"
	sleep 2
	curl https://raw.githubusercontent.com/arlr/dot-conf/refs/heads/main/themes/tmux_alr.sh --create-dirs -o  ~/.tmux/plugins/tmux-powerline/themes/tmux_alr.sh
	curl https://raw.githubusercontent.com/arlr/dot-conf/refs/heads/main/tmux-powerline/config.sh --create-dirs -o  ~/.config/tmux-powerline/config.sh
}

# Vim Setup
setup_vim () {
	echo "Setup Vim"
	echo "Install vim paquet"
	sudo apt install vim -y
	cp .vimrc $HOME
}

# Alacritty setup
setup_alacritty () {
	echo "Setup Alacritty"
	echo "Install alacritty paquet"
	sudo apt install alacritty -y
	cp alacritty/ $CONFIG
}	

# i3 Setup
setup_i3 () {
	echo "Setup i3 windows manager"
	echo "Install i3 paquets"
	sudo apt install i3 i3status feh -y
	cp -r i3/ $CONFIG
	cp -r i3status/ $CONFIG
}

# Installation of everything
install_full () {
	updates
	setup_handy
	setup_fish
	setup_tmux
	setup_vim
	setup_alacritty
	setup_i3
}

# Installation for a head less system
install_headless () {
	updates
	setup_handy
	setup_fish
	setup_tmux
	setup_vim
}

# Print help
print_help () {
	echo -e "-h: Print this help\n-a: install everything\n-l: install head less\n"
}

# Read parameter
if [[ ! -n $1 ]];
then 
    echo "No parameter passed."
	print_help
else 
	case "$1" in
		-h)
			echo "Help:"
			print_help
			;;
		-a)
			echo "Full installation"
			install_full
			;;
		-l)
			echo "Head less install"
			install_headless
			;;
		*)
			print_help
			;;
	esac
fi
