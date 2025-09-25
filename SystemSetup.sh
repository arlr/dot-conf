#!/bin/bash

# Variables
# Dest configuration folder

CONFIG="$HOME/.config"

# Updates

sudo apt update && sudo apt upgrade -y

# Handy paquet
# Set of paquet that are often used
function setup_handy {
	HANDY_PQT=" openvpn wget curl nmap htop "
	echo "Setup handy paquets:"
	echo $HANDY_PQT
	sudo apt install $HANDY_PQT -y
}

# ZSH setup
function setup_zsh {

	echo "Setup ZSH"
	echo "Install zsh paquet"
	sudo apt install zsh -y
	
	if [ ! -d "~/.oh-my-zsh" ]; then
		echo "No Oh my ZSH found"
 		
		# Skip unattended to avoid zsh to run directly
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
 		
		# Set ZSH as default shell manually
 		chsh -s $(which zsh)
	
		echo "Install spaceship"
		
		ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
		echo "ZSH CUSTOM PATH: $ZSH_CUSTOM"
		git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
		ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	
		ZSHRC_FILE="$HOME/.zshrc"
		THEME_SETTING='ZSH_THEME="spaceship"'

		# Check if ZSH_THEME is already set
		if grep -q "ZSH_THEME=" "$ZSHRC_FILE"; then
   			# If ZSH_THEME is found, replace its value with "spaceship"
    		sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="spaceship"/' "$ZSHRC_FILE"
    		echo "Updated ZSH_THEME to \"spaceship\" in $ZSHRC_FILE"
		else
    		# If ZSH_THEME is not found, append it to the file
    		echo "$THEME_SETTING" >> "$ZSHRC_FILE"
    		echo "Added ZSH_THEME=\"spaceship\" to $ZSHRC_FILE"
		fi
	fi
}

# Tmux Setup
function setup_tmux {
	echo "Setup Tmux"
	echo "Install tmux paquet"
	sudo apt install tmux -y
	cp .tmux.conf ~/.tmux.conf
	#Tmux conf file has the commands to DL and install plugins + themes.
	#tmux source ~/.tmux.conf
}

# Vim Setup
function setup_vim {
	echo "Setup Vim"
	echo "Install vim paquet"
	sudo apt install vim -y
	cp .vimrc $HOME
}

# Alacritty setup
function setup_alacritty {
	echo "Setup Alacritty"
	echo "Install alacritty paquet"
	sudo apt install alacritty -y
	cp alacritty/ $CONFIG
}	

# i3 Setup
function setup_i3 {
	echo "Setup i3 windows manager"
	echo "Install i3 paquets"
	sudo apt install i3 i3status -y
	cp i3/ $CONFIG
	cp i3status/ $CONFIG
}

# Run Everything
setup_handy
setup_zsh
setup_tmux
setup_vim
setup_alacritty
setup_i3

