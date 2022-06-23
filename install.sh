#!/bin/bash

##########################################################################
### Install script for https://github.com/fredtux/ubuntu-optimizations ###
##########################################################################

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}UPDATE${NC}"
sudo apt-get update -y

echo -e "${RED}INSTALL REQUIRED PROGRAMS${NC}"
sudo apt-get install wget curl git flatpak python3-pip -y
sudo snap install node --classic

pip install pynvim

if ! command -v google-chrome &>/dev/null
then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
fi

# Scripts
echo -e "${RED}SCRIPTS${NC}"
sudo cp -r scripts/* /usr/bin

sudo chown root:root /usr/bin/check-space
sudo chmod 755 /usr/bin/check-space

sudo chown root:root /usr/bin/delete-errors
sudo chmod 755 /usr/bin/delete-errors

sudo chown root:root /usr/bin/fix-focus
sudo chmod 755 /usr/bin/fix-focus

sudo chown root:root /usr/bin/record-dslr
sudo chmod 755 /usr/bin/record-dslr

sudo chown root:root /usr/bin/search
sudo chmod 755 /usr/bin/search

sudo chown root:root /usr/bin/update
sudo chmod 755 /usr/bin/update

sudo chown root:root /usr/bin/text-search
sudo chmod 755 /usr/bin/text-search

sudo chown root:root /usr/bin/go-install-tar
sudo chmod 755 /usr/bin/go-install-tar

# Configs
echo -e "${RED}CONFIGS${NC}"

if ! command -v vim &>/dev/null
then
	sudo apt-get install vim -y
fi
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp configs/.vimrc ~/.vimrc
vim +PlugInstall +qall

if ! command -v zsh &>/dev/null
then
	sudo apt-get install zsh -y
fi
sudo apt-get install zsh-autosuggestions -y
sudo apt-get install zsh-syntax-highlighting -y
cp configs/.zshrc ~/.zshrc
chsh -s $(which zsh)
sudo cp configs/.zshrc /root/.zshrc
sudo chsh -s $(which zsh)

if ! command -v nvim &>/dev/null
then
	sudo snap install nvim --classic
fi
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim

# Stage 1 - only plugins
cp configs/init_onlyplugins.vim ~/.config/nvim/init.vim
nvim +PlugInstall +qall

# Stage 2 - full config
cp configs/init.vim ~/.config/nvim/init.vim
nvim +PlugInstall +qall

if ! command -v kitty &>/dev/null
then
	sudo apt-get install kitty -y
fi
mkdir -p ~/.config/kitty
cp configs/kitty.conf ~/.config/kitty/kitty.conf

if ! command -v terminator &>/dev/null
then
	sudo apt-get install terminator -y
fi
mkdir -p ~/.config/terminator
cp configs/terminator_config ~/.config/terminator/config

if ! command -v zathura &>/dev/null
then
	sudo apt-get install zathura -y
fi
mkdir -p ~/.config/zathura
cp configs/zathurarc ~/.config/zathura/zathurarc

# Gnome Apps
echo -e "${RED}GNOME APPS${NC}"
sudo cp -r gnome-apps/* /usr/share/applications/

sudo chown root:root /usr/share/applications/messenger.desktop
sudo chmod 644 /usr/share/applications/messenger.desktop
sudo chown root:root /usr/share/applications/messenger.svg
sudo chmod 644 /usr/share/applications/messenger.svg

sudo chown root:root /usr/share/applications/office365.desktop
sudo chmod 644 /usr/share/applications/office365.desktop
sudo chown root:root /usr/share/applications/office365.png
sudo chmod 644 /usr/share/applications/office365.png

sudo chown root:root /usr/share/applications/proton-calendar.desktop
sudo chmod 644 /usr/share/applications/proton-calendar.desktop
sudo chown root:root /usr/share/applications/protoncalendar.jpg
sudo chmod 644 /usr/share/applications/protoncalendar.jpg

sudo chown root:root /usr/share/applications/proton-mail.desktop
sudo chmod 644 /usr/share/applications/proton-mail.desktop
sudo chown root:root /usr/share/applications/protonmail.png
sudo chmod 644 /usr/share/applications/protonmail.png

sudo chown root:root /usr/share/applications/whatsapp-webapp.desktop
sudo chmod 644 /usr/share/applications/whatsapp-webapp.desktop
sudo chown root:root /usr/share/applications/whatsapp.png
sudo chmod 644 /usr/share/applications/whatsapp.png

sudo chown root:root /usr/share/applications/outlook.desktop
sudo chmod 644 /usr/share/applications/outlook.desktop
sudo chown root:root /usr/share/applications/outlook.svg
sudo chmod 644 /usr/share/applications/outlook.svg

echo -e "${RED}FONTS${NC}"
mkdir -p ~/.local/share/fonts 

rm -fr Hack
git clone https://github.com/source-foundry/Hack.git
cp -r Hack/build/ttf/* ~/.local/share/fonts/

rm -fr fonts
git clone https://github.com/powerline/fonts.git
cp -r fonts/FiraMono/*.otf ~/.local/share/fonts/

fc-cache -f -v

echo -e "${RED}DONE !!!${NC}"
