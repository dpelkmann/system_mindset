# System Mindset

This repository stores and manages personal and system configurations for Fedora 40. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM). Some system configurations are inspired by [devangshekhawat](https://github.com/devangshekhawat/Fedora-40-Post-Install-Guide).


<!-- vim-markdown-toc GitLab -->

* [Setup](#setup)
* [Usage](#usage)
* [Software the Configurations of this Repository are intended for](#software-the-configurations-of-this-repository-are-intended-for)
    * [system fonts](#system-fonts)
    * [lsd](#lsd)
    * [bat](#bat)
    * [htop](#htop)
    * [nvtop](#nvtop)
    * [btop](#btop)
    * [tig](#tig)
    * [tmux](#tmux)
    * [glances](#glances)
    * [kitty](#kitty)
    * [fastfetch or neofetch](#fastfetch-or-neofetch)
    * [nodejs](#nodejs)
    * [yarn](#yarn)
    * [neovim](#neovim)
    * [ranger](#ranger)
    * [starship prompt](#starship-prompt)
    * [powerline prompt](#powerline-prompt)
    * [AusweisApp2](#ausweisapp2)
* [Additional Helpful Software for Fedora (Gnome Edition)](#additional-helpful-software-for-fedora-gnome-edition)
    * [Gnome Extensions App](#gnome-extensions-app)
    * [Gnome Extension Manager](#gnome-extension-manager)
        * [Extensions](#extensions)
    * [Gnome Tweaks](#gnome-tweaks)
    * [Cryptomator](#cryptomator)
    * [OneDrive Client for Linux](#onedrive-client-for-linux)
    * [Microsoft Edge](#microsoft-edge)
    * [Antidote](#antidote)
    * [keepassxc](#keepassxc)
    * [menulibre](#menulibre)
    * [dconf-editor](#dconf-editor)
    * [Color Picker](#color-picker)
    * [DDC Control](#ddc-control)
    * [solaar](#solaar)
    * [inkscape](#inkscape)
    * [trash-cli](#trash-cli)
    * [zathura](#zathura)
    * [flathub](#flathub)
    * [cherrytree](#cherrytree)
    * [Spotify](#spotify)
    * [OpenRGB](#openrgb)
* [DNF Tuning / Faster Updated](#dnf-tuning-faster-updated)
* [Firmware Update](#firmware-update)
* [Media Codecs](#media-codecs)
* [H/W Video Acceleration](#hw-video-acceleration)

<!-- vim-markdown-toc -->

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

### nvtop

```bash
sudo dnf install nvtop
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
    * alternative (rewrite of babar): https://extensions.gnome.org/extension/6556/task-up/
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

## DNF Tuning / Faster Updated

The standard dnf settings can be improved to make it faster (inspired by [devangshekhawat](https://github.com/devangshekhawat/Fedora-40-Post-Install-Guide)). Add to your /etc/dnf/dnf.conf:

```conf
[main]
gpgcheck=1
installonly_limit=3
clean_requirements_on_remove=True
best=False
fastestmirror=true
deltarpm=true
max_parallel_downloads=10
```

## Firmware Update

If your system supports firware update through lvfs, update it.

```bash
fwupdmgr get-devices 
fwupdmgr refresh --force 
fwupdmgr get-updates 
fwupdmgr update
```

## Media Codecs

``` bash
dnf groupupdate 'core' 'multimedia' 'sound-and-video' --setopt='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
dnf install lame\* --exclude=lame-devel
dnf group upgrade --with-optional Multimedia
```

## H/W Video Acceleration

```bash
dnf install ffmpeg ffmpeg-libs libva libva-utils
dnf config-manager --set-enabled fedora-cisco-openh264
# enable OpenH264 plugin in firefox (about:addons => Plugins)
```
