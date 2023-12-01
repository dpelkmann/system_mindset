# System Mindset

This repository stores and manages personal Linux configuration files for Fedora 39. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM).

## Setup

```bash
# change to home directory
cd $HOME
# create (temporary) directory for system_mindset
sm_dir=$HOME/.config/sm/
mkdir -p $sm_dir
# create (temporary) alias for system mindset
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
    mkdir -p ${sm_dir}${backup_dir}/$dest/
    mv $file2backup ${sm_dir}${backup_dir}/$dest/
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

## Usage
Keep in mind that your .bashrc need this sm entry:
```bash
###############################################################################
# + system_mindset - Dotfile Management via git bare
# | 1. source: https://www.youtube.com/watch?v=tBoLDpTWVOM
# | 2. source: https://www.atlassian.com/git/tutorials/dotfiles
sm_dir=$HOME/.config/sm/
alias sm='/usr/bin/git --git-dir=${sm_dir}system_mindset/ --work-tree=$HOME'
# +--+ manually managed, so not show other files in $HOME 
sm config --local status.showUntrackedFiles no
# +--+ update modified, deleted and new files to commit
alias sm_stage-changes='sm add $(sm status | grep "modified\|deleted\|new file" | sed "s/.*://")'
# +--+ remove updated files 
alias sm_unstage-changes='sm reset --mixed'
# +--+ add tig support
sm config tig.status-show-untracked-files false
alias sm_tig='GIT_DIR=${sm_dir}system_mindset/ GIT_WORK_TREE=$HOME tig'
```
So with `sm <cmd>` you can work as with `git <cmd>`. For example to pull use `sm pull` or to push use `sm push`. Add aliases witch fit you the best. I like the command line tool tig, so I use the `sm_tig` alias to use it for adding, staging and commiting my changes.

## Software the Configurations of this Repository are intended for

### system fonts

```bash
sudo dnf install rsms-inter-fonts
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

### btop

```bash
sudo dnf install btop
```

### tig

```bash
sudo dnf install tig
```

### tmux

```bash
sudo dnf install tmux
```

### glances

```bash
sudo dnf install glances
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

### fastfetch or neofetch

```bash
sudo dnf install fastfetch (prefered)
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
:CocList marketplace
" search all fitting extensions
:CocList marketplace <pattern>
```

personal collection

```vim
" Bash, C/C++/Objective-C, Markdown, LaTeX, Json, Javascript/Typescript, HTML, Python
:CocInstall coc-sh coc-clangd coc-markdownlint coc-texlab coc-json coc-tsserver coc-html coc-pyright
```
For the plugin __Markdown Preview for (Neo)vim__ additional steps need to be done after installation:

```vim
:source %
:PluginInstall
:call mkdp#util#install()
```

if this is not working, try this:

```bash
cd ~/.local/share/nvim/site/plugins/markdown-preview.nvim/app/
./install.sh
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

### AusweisApp2

eID client of the Federal Republic of Germany

```bash
sudo dnf install AusweisApp2
```

## Additional Helpful Software for Fedora (Gnome Edition)

### Gnome Extensions App

```bash
sudo dnf install gnome-extensions-app
```

### Gnome Extension Manager

```bash
flatpak install flathub com.mattjakeman.ExtensionManager
```

#### Extensions

* https://extensions.gnome.org/extension/615/appindicator-support/
* https://github.com/fthx/babar
    * Original babar extension from fthx is only functional maintained and not officially available in the gnome extension shop. Git-Repository code is woking (Gnome 45 / Fedora 39). To add the extension clone the repository to *~/.local/share/gnome-shell/extensions/* and change the folder name to *uuid* attribute of the *metadata.json* file. Finally, you can activate (after a reboot) the extension via the gnome extension manager.
* https://extensions.gnome.org/extension/1262/bing-wallpaper-changer/
* https://extensions.gnome.org/extension/1460/vitals/
* https://extensions.gnome.org/extension/4135/espresso/
* https://extensions.gnome.org/extension/3737/hue-lights/
* https://extensions.gnome.org/extension/906/sound-output-device-chooser/

### Gnome Tweaks

```bash
sudo dnf install gnome-tweaks
```

### Cryptomator

[Manual Installation](https://github.com/cryptomator/cryptomator/releases)

### OneDrive Client for Linux

* CLI-Tool
```bash
sudo dnf install onedrive
```
* [GUI-Tool](https://github.com/bpozdena/OneDriveGUI)
* [Manual Installation](https://github.com/abraunegg/onedrive/)

### Microsoft Edge

* [Manual Installation (Stable)](https://www.microsoft.com/de-de/edge/download)
* [Manual Installation (Beta)](https://www.microsoftedgeinsider.com/en-us/download?platform=linux-rpm)

### Antidote

[Manual Installation](https://www.antidote.info/en/)

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

inside dconf:

```bash
/org/gnome/settings-daemon/plugins/media-keys/volume-step => 1
```

### Color Picker

```bash
sudo dnf install gcolor3
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

### OpenRGB

```bash
flatpak install flathub org.openrgb.OpenRGB
# install udev (https://openrgb.org/udev)
```

## DNF Tuning

The standard dnf settings can be improved to make it faster. Add to your /etc/dnf/dnf.conf:

```conf
fastestmirror=true
deltarpm=true
max_parallel_downloads=5
```

