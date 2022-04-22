# System Mindset

This repository stores and manages personal Linux configuration files. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM).

## Setup

```bash
# change to home directory
cd $HOME
# create directory for system_mindset
sm_dir=$HOME/.config/sm/
mkdir -p $sm_dir
# create alias for system mindset
alias sm='/usr/bin/git --git-dir=${sm_dir}system_mindset/ --work-tree=$HOME'
# add Repository to .gitignore to prevent recursion problems and delete 
# previous added lines
sed -i '/system_mindset/d' .gitignore
echo ".config/sm # inserted by system_mindset" >> .gitignore
# clone system_mindset
git clone --bare git@github.com:dpelkmann/system_mindset.git ${sm_dir}system_mindset
# checkout bare repository. It would overwrite existing config files, therefore
# they will be backuped.
backup_dir=backup_$(date +%F_%T)
for file2backup in $(sm checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
do
    echo "$file2backup"
    dest=$(dirname $file2backup)
    mkdir -p ${sm_dir}backup_${sm_dir}${backup_dir}/$dest/
    mv $file2backup ${sm_dir}backup/$dest
done
# finally checkout
sm checkout
# untracked files should not be shown
sm config --local status.showUntrackedFiles no
# download indexed submodules
sm submodule update --init --recursive
# update downloaded submodules
sm submodule update --recursive --remote
```
## Software the Configurations of this Repository are intended for

### lsd

```bash
sudo dnf install lsd
```

### bat

```bash
sudo dnf install bat
```

### htop

```bash
sudo dnf install htop
```

### tmux

```bash
sudo dnf install tmux
```

### kitty

```bash
sudo dnf install kitty
```

JetBrainsMono (https://github.com/JetBrains/JetBrainsMono) in kitty config required:

```bash
sudo dnf install jetbrains-mono-fonts-all
```

To be able to display the appropriate icons in the terminal, the package nerd-fonts is necessary.

```bash
# change to home directory
cd $HOME
# create directory for system_mindset
sm_dir=$HOME/.config/sm/
mkdir -p $sm_dir
# clone nerd-fonts repository
git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git ${sm_dir}nerd-fonts/
# install nerd-fonts
bash ${sm_dir}nerd-fonts/install.sh
```

### neofetch

```bash
sudo dnf install neofetch
```

### nodejs

```bash
sudo dnf install nodejs
```

### yarn

```bash
npm install yarn
```

### neovim

```bash
sudo dnf install neovim
```

For the plugin Conquer of Completion (coc.nvim) several extensions need to be installed. To list, search und manage them, coc-marketplace can be used.

```vim
" install coc-marketplace
:CocInstall coc-marketplace
" list all available extensions
:CocInstall marketplace
" search all fitting extensions
:CocInstall marketplace <pattern>
```

personal collection

```vim
" Bash, C/C++/Objective-C, Markdown, LaTeX, Json, Javascript/Typescript, HTML, Python
:CocInstall coc-sh coc-clangd coc-markdownlint coc-texlab coc-json coc-tsserver coc-html coc-pyright
```

### ranger

```bash
sudo dnf install ranger
```

### starship prompt

```bash
sudo dnf install starship
```

### powerline prompt

```bash
sudo dnf install powerline tmux-powerline powerline-fonts
```

## Additional Helpful Software for Fedora (Gnome Edition)

### Gnome Extensions App

```bash
sudo dnf install gnome-extensions-app
```

#### Extensions

* https://extensions.gnome.org/extension/615/appindicator-support/
* https://extensions.gnome.org/extension/4000/babar/
* https://extensions.gnome.org/extension/1262/bing-wallpaper-changer/
* https://extensions.gnome.org/extension/4135/espresso/
* https://extensions.gnome.org/extension/1732/gtk-title-bar/
* https://extensions.gnome.org/extension/3737/hue-lights/
* https://extensions.gnome.org/extension/7/removable-drive-menu/
* https://extensions.gnome.org/extension/906/sound-output-device-chooser/
* https://extensions.gnome.org/extension/3933/toggle-night-light/
* https://extensions.gnome.org/extension/4472/spotify-tray/
* https://extensions.gnome.org/extension/2890/tray-icons-reloaded/

### Gnome Tweaks

```bash
sudo dnf install gnome-tweaks
```

### Cryptomator

https://github.com/cryptomator/cryptomator/releases

### OneDrive Client for Linux

https://github.com/abraunegg/onedrive/

### Microsoft Edge

https://www.microsoftedgeinsider.com/en-us/download?platform=linux-rpm

### Antidote

https://www.antidote.info/en/

### keepassxc

```bash
sudo dnf install keepassxc
```

### menulibre

```bash
sudo dnf install menulibre
```

### dconf-editor

```bash
sudo dnf install dconf-editor
```

### DDC Control
```bash
sudo dnf install ccdcontrol-gtk
```

### solaar

```bash
sudo dnf install solaar
```

### inkscape

```bash
sudo dnf install inkscape
```

### trash-cli

```bash
sudo dnf install trash-cli
```

### zathura

```bash
sudo dnf install zathura zathura-plugins-all 
```

### flathub

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

### cherrytree

```bash
flatpak install flathub com.giuspen.cherrytree
```

### Spotify

```bash
flatpak install flathub com.spotify.Client
```
