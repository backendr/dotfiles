#!/bin/bash

# Setup script for new install on OSX
# iTerm2 with Tmux and Fish

# install brew
echo "Installing Brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install default formulae
echo "Installing Brew scripts"
brew install git
brew install awscli exa fish git nmap openssl tree wget whois 

# tap the versions cask for miniconda2 and istat-menus5
echo "Tapping cask-versions"
brew tap homebrew/cask-versions

# install brew casks
echo "Installing brew casks"
brew cask install 1password6 atom bettertouchtool caffeine docker-edge drawio dropbox firefox github istat-menus5 keepassx mailspring miniconda2 nordvpn pycharm slack spotify typora

# Make firefox default browser
/Applications/Firefox.app/Contents/MacOS/firefox -setDefaultBrowser &

# make projects dir
echo "Creating projects dir"
mkdir ~/projects

# clone maximum-awesome
echo "Installing Maximum-Awesome"
cd ~/projects
git clone https://github.com/square/maximum-awesome.git
cd maximum-awesome
rake

# clone gruvbox
echo "Installing gruvbox"
cd ~/projects
git clone https://github.com/morhetz/gruvbox-contrib.git

# install powerline fonts
echo "Installing powerline fonts"
cd ~/projects
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

# install aws-tools
cd ~/projects
git clone https://github.com/backendr/aws-tools.git

# create .bash_profile and .bashrc
cd ~
echo "source .bashrc" > .bash_profile
echo "if command -v tmux>/dev/null; then\n  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux\nfi" > .bashrc

# install oh-my-fish
echo "Installing oh-my-fish"
curl -L https://get.oh-my.fish | fish
omf install bobthefish

# create fish config dir
midir -p ~/.config/fish/functions
# replace ls with exa for pretty `ls`
echo "function ls\n  clear\n  exa -lahg --git \$argv\nend" > ls.fish
cd ~/.config/fish
echo "set -x PATH $PATH /usr/local/bin\n set -x PATH $PATH /usr/local/miniconda2/bin" > config.fish

# create miniconda2 python 3 environment
/usr/local/miniconda2/bin/conda create -n p3 python=3 -y
# add fish source to fish.config
echo "source /usr/local/miniconda2/etc/fish/conf.d/conda.fish" >> config.fish
echo "conda activate p3" >> config.fish
source /usr/local/miniconda2/etc/fish/conf.d/conda.fish


# todo:
# [] get the gruvbox iterm color scheme and setup
# https://raw.githubusercontent.com/morhetz/gruvbox-contrib/master/iterm2/gruvbox-dark.itermcolors
# [] run vim :PluginInstall with the new dot files
# vim +PluginInstall +qall
# [] convert to makefile with sections

echo "Done. You can now configure any dot files that you need!"
echo "Dont forget to set iTerm color scheme to gruvbox, import firefox bookmarks"
