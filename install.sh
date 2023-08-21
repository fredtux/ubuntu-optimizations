#!/bin/bash

##########################################################################
### Install script for https://github.com/fredtux/ubuntu-optimizations ###
##########################################################################

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}UPDATE${NC}"
sudo apt-get update -y

echo -e "${RED}INSTALL REQUIRED PROGRAMS${NC}"
sudo apt-get install wget curl git flatpak python3-pip gnome-screenshot tmux -y
sudo snap install node --classic

pip install pynvim

if ! command -v google-chrome &>/dev/null
then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb
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

sudo chown root:root /usr/bin/i3l
sudo chmod 755 /usr/bin/i3l

sudo chown root:root /usr/bin/monsetup
sudo chmod 755 /usr/bin/monsetup

# Configs
echo -e "${RED}CONFIGS${NC}"

cp configs/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/scripts/install_plugins.sh

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

# ROOT - Stage 1 - only plugins
sudo mkdir -p /root/.config/nvim
sudo cp configs/init_onlyplugins.vim /root/.config/nvim/init.vim
sudo nvim +PlugInstall +qall

# ROOT - Stage 2 - full config
sudo cp configs/init.vim /root/.config/nvim/init.vim
sudo nvim +PlugInstall +qall

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

flatpak install md.obsidian.Obsidian -y

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


sudo chown root:root /usr/share/applications/chatgpt-webapp.desktop
sudo chmod 644 /usr/share/applications/chatgpt-webapp.desktop
sudo chown root:root /usr/share/applications/chatgpt.png
sudo chmod 644 /usr/share/applications/chatgpt.png

sudo chown root:root /usr/share/applications/outlook.desktop
sudo chmod 644 /usr/share/applications/outlook.desktop
sudo chown root:root /usr/share/applications/outlook.svg
sudo chmod 644 /usr/share/applications/outlook.svg

sudo chown root:root /usr/share/applications/android-studio.desktop
sudo chmod 644 /usr/share/applications/android-studio.desktop
sudo chown root:root /usr/share/applications/android-studio.svg
sudo chmod 644 /usr/share/applications/android-studio.svg

sudo chown root:root /usr/share/applications/anaconda-navigator.desktop
sudo chmod 644 /usr/share/applications/anaconda-navigator.desktop
sudo chown root:root /usr/share/applications/anaconda-navigator.png
sudo chmod 644 /usr/share/applications/anaconda-navigator.png

sudo chown root:root /usr/share/applications/keepassxc.desktop
sudo chmod 644 /usr/share/applications/keepassxc.desktop
sudo chown root:root /usr/share/applications/keepassxc.svg
sudo chmod 644 /usr/share/applications/keepassxc.svg

echo -e "${RED}FONTS${NC}"
mkdir -p ~/.local/share/fonts 

rm -fr Hack
git clone https://github.com/source-foundry/Hack.git
cp -r Hack/build/ttf/* ~/.local/share/fonts/
rm -fr Hack

rm -fr fonts
git clone https://github.com/powerline/fonts.git
cp -r fonts/FiraMono/*.otf ~/.local/share/fonts/
rm -fr fonts

fc-cache -f -v

# PEDA
rm -fr peda
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit
rm -fr peda

# i3wm
echo -e "${RED}i3wm${NC}"
rm -f keyring.deb
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt-get update
sudo apt-get -y install i3 polybar feh numlockx picom rofi
rm -f keyring.deb

mkdir -p ~/.config/i3/
cp configs/i3config ~/.config/i3/config

# Polybar
cp -r configs/polybar ~/.config

# Picom
mkdir -p ~/.config/picom
cp -r configs/picom.conf ~/.config/picom/picom.conf

# Rofi
rm -fr rofi
git clone --depth=1 https://github.com/adi1090x/rofi.git
chmod +x rofi/setup.sh
cd rofi
./setup.sh
cd ..
rm -fr rofi
cp -r configs/rofi ~/.config

# Alacritty
echo -e "${RED}Alacritty${NC}"
sudo add-apt-repository -y ppa:aslatter/ppa
sudo apt-get -y install alacritty
mkdir -p ~/.config/alacritty
cp -r configs/alacritty ~/.config/

echo -e "${RED}DONE !!!${NC}"
