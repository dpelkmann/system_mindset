# System Mindset

This repository stores and manages personal Linux configuration files. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM).

## Software the Configurations of this Repository are intended for

### Installation

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
for file2backup in $(sm checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
do
    echo "$file2backup"
    dest=$(dirname $file2backup)
    mkdir -p ${sm_dir}backup_${sm_dir}backup-$(date +%F_%T)/$dest/$dest
    mv $file2backup ${sm_dir}backup/$dest
done
sm checkout
sm config --local status.showUntrackedFiles no
```

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

### ranger

```bash
sudo dnf install ranger
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
