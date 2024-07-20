# System Mindset

This repository stores and manages personal and system configurations for Fedora 40. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM). Some system configurations are inspired by [devangshekhawat](https://github.com/devangshekhawat/Fedora-40-Post-Install-Guide).


<!-- vim-markdown-toc GitLab -->

* [Setup](#setup)
* [Usage](#usage)
* [Software](#software)
    * [Terminals, Fonts and Tools](#terminals-fonts-and-tools)
    * [Flathub](#flathub)
    * [Gnome related Software](#gnome-related-software)
    * [Application Programs](#application-programs)
    * [Updates](#updates)
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

## Software

### Terminals, Fonts and Tools

```bash
# + Terminal
# +--+ kitty (gpu based terminal: https://github.com/kovidgoyal/kitty)
sudo dnf install kitty
# + Fonts
# +--+ rsms inter font (for system)
sudo dnf install rsms-inter-fonts
# +--+ jetbriansmono font for kitty (font for developers: https://github.com/JetBrains/JetBrainsMono)
sudo dnf dnf install jetbrains-mono-fonts-all
# +--+ nerd fonts for icons in terminal (https://github.com/ryanoasis/nerd-fonts)
# |  +--+ change to home directory
cd $HOME
# |  +--+ create directory for system_mindset
sm_dir=$HOME/.config/sm/
mkdir -p $sm_dir
# |  +--+ clone nerd-fonts repository
git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git ${sm_dir}nerd-fonts/
# |  +--+ install nerd-fonts
bash ${sm_dir}nerd-fonts/install.sh
# + Tools
# +--+ lsd (LSDeluxe: https://github.com/lsd-rs/lsd)
sudo dnf install lsd
# +--+ bat (a cat clone with wings: https://github.com/sharkdp/bat)
sudo dnf install bat
# +--+ htop (interactive process viewer: https://github.com/htop-dev/htop)
sudo dnf install htop
# +--+ btop (resource monitor: https://github.com/aristocratos/btop)
sudo dnf install btop
# +--+ glances (A top/htop alternative: https://github.com/nicolargo/glances)
sudo dnf install glances
# +--+ nvtop (Neat Videocard TOP: https://github.com/Syllo/nvtop)
sudo dnf install nvtop
# +--+ tig (Text-mode interface for git: https://github.com/jonas/tig)
sudo dnf install tig
# +--+ tmux (terminal multiplexer: https://github.com/tmux/tmux)
sudo dnf install tmux
# +--+ fastfetch (fast system information tool: https://github.com/fastfetch-cli/fastfetch)
sudo dnf install fastfetch
# +--+ neovim (Vim-fork focused on extensibility and usability: https://github.com/neovim/neovim)
sudo dnf install neovim
# |  +--+ nodejs for neovim plugins (needs regular update!)
sudo dnf install nodejs
# |  |  +--+ yarn for noevim plugins
npm install yarn
# |  +--+ install plugins
nvim --headless +PlugInstall +qa
# |  +--+ install coc-marketplace plugin (to get languages)
nvim --headless +CocInstall coc-marketplace +qa
# |  |  +--+ install languages
nvim +CocInstall coc-sh coc-clangd coc-markdownlint coc-texlab coc-json coc-tsserver coc-html coc-pyright
# |  |  +--+ search for language
nvim +CocList marketplace <pattern>
# |  +--+ markdown preview for neovim needs manual installation
$HOME/.local/share/nvim/site/plugins/markdown-preview.nvim/app/install.sh
# +--+ ranger (terminal filemanager: https://github.com/ranger/ranger)
sudo dnf install ranger
# +--+ starship (terminal prompt)
sudo dnf install starship
# +--+ powerline (terminal prompt)
sudo dnf install powerline tmux-powerline powerline-fonts
```

### Flathub

```bash
# + activate flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

### Gnome related Software

```bash
# + MenuLibre (advanced menu editor: https://github.com/bluesabre/menulibre)
sudo dnf install menulibre
# + dconf-editor (A GSettings editor for GNOME: https://gitlab.gnome.org/GNOME/dconf-editor)
# | 1. /org/gnome/settings-daemon/plugins/media-keys/volume-step => 1
sudo dnf install dconf-editor
# + Gnome Tweaks (https://gitlab.gnome.org/GNOME/gnome-tweaks)
sudo dnf install gnome-tweaks
# + Gnome Extension Manager (https://github.com/mjakeman/extension-manager)
flatpak install flathub com.mattjakeman.ExtensionManager
# + Gnome Extensions
# +--+ AppIndicator and KStatusNotifierItem Support
firefox https://extensions.gnome.org/extension/615/appindicator-support/
# +--+ Bing Wallpaper
firefox https://extensions.gnome.org/extension/1262/bing-wallpaper-changer/
# +--+ Hue Lights
firefox https://extensions.gnome.org/extension/3737/hue-lights/
# +--+ Espresso
firefox https://extensions.gnome.org/extension/4135/espresso/
# +--+ Vitals
firefox https://extensions.gnome.org/extension/1460/vitals/
# +--+ Brightness control using ddcutil
firefox https://extensions.gnome.org/extension/2645/brightness-control-using-ddcutil/
# +--+ No overview at start-up
firefox https://extensions.gnome.org/extension/4099/no-overview/
# +--+ Tiling Shell
firefox https://extensions.gnome.org/extension/7065/tiling-shell/
```

### Application Programs

```bash
# + Application Programs
# +--+ AusweisApp2 (eID client of the Federal Republic of Germany)
sudo dnf install AusweisApp2
# +--+ Cryptomator (https://github.com/cryptomator)
flatpak install flathub org.cryptomator.Cryptomator
# +--+ OneDrive CLI-Tool (https://github.com/abraunegg/onedrive)
sudo dnf install onedrive
# |  +--+ OneDrive GUI (https://github.com/bpozdena/OneDriveGUI/releases/latest/)
# |     | 1. Download newest AppImage
# |     | 2. Create or update OneDriveGUI Application entry in Menu Editor with AppImage
# |     | 3. Add image to startup application in Gnome Tweaks
mkdir -p $HOME/Software/OneDriveGUI/
cd $HOME/Software/OneDriveGUI/
wget https://github.com/bpozdena/OneDriveGUI/releases/download/v1.0.3/OneDriveGUI-1.0.3-x86_64.AppImage
chmod +x ./OneDriveGUI*
cd
# +--+ Microsoft Edge Browser
flatpak install flathub com.microsoft.Edge
# +--+ KeePassXC (https://github.com/keepassxreboot/keepassxc)
sudo dnf install keepassxc
# + Color Picker
sudo dnf install gcolor3
# + DDC Control
sudo dnf install ccdcontrol-gtk
# + solaar (Linux device manager for Logitech devices: https://github.com/pwr-Solaar/Solaar)
# | 1. Add to startup applications in Gnome Tweaks
sudo dnf install solaar
# + inkscape
sudo dnf install inkscape
# + cherrytree
flatpak install flathub com.giuspen.cherrytree
# + Spotify
flatpak install flathub com.spotify.Client
# + OpenRGB
# | install udev (https://openrgb.org/udev)
flatpak install flathub org.openrgb.OpenRGB
# + MQTT Explorer (https://github.com/thomasnordquist/MQTT-Explorer)
# | 1. Download newest AppImage (https://github.com/thomasnordquist/MQTT-Explorer/releases/latest/)
# | 2. Create or update MQTT-Explorer Application entry in Menu Editor with AppImage
# | 3. Add image to startup application in Gnome Tweaks
mkdir -p $HOME/Software/mqtt-explorer/
cd $HOME/Software/mqtt-explorer/
wget https://github.com/thomasnordquist/MQTT-Explorer/releases/download/v0.4.0-beta.6/MQTT-Explorer-0.4.0-beta.6.AppImage
chmod +x ./MQTT-Explorer*
cd
```

### Updates

```bash
# + system
dnf update --refresh
# +--+ nodejs
npm update -g npm
npn update
npm audit
# +--+ neovim
# |  +--+ update Plug
nvim --headless +PlugUpgrade +qa
# |  +--+ update plugins
nvim --headless +PlugUpdate +qa
# |  +--+ update coc-modules
nvim +CocUpdate
```

## DNF Tuning / Faster Updated

The standard dnf settings can be improved to make it faster (inspired by [devangshekhawat](https://github.com/devangshekhawat/Fedora-40-Post-Install-Guide)). Add to your /etc/dnf/dnf.conf:

```conf
[main]
gpgcheck=1
installonly_limit=3
clean_requirements_on_remove=True
skip_if_unavailable=True
best=False
fastestmirror=0
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
