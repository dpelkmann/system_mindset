# System Mindset

This repository stores and manages personal and system configurations for Fedora 42. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM). Some system configurations are inspired by [devangshekhawat](https://github.com/devangshekhawat/Fedora-40-Post-Install-Guide).

<!-- vim-markdown-toc GitLab -->

  * [Setup](#setup)
  * [Usage](#usage)
  * [Software](#software)
    * [Terminals, Fonts and Tools](#terminals-fonts-and-tools)
* [+ MenuLibre (advanced menu editor: https://github.com/bluesabre/menulibre)](#-menulibre-advanced-menu-editor-httpsgithubcombluesabremenulibre)
* [+ dconf-editor (A GSettings editor for GNOME: https://gitlab.gnome.org/GNOME/dconf-editor)](#-dconf-editor-a-gsettings-editor-for-gnome-httpsgitlabgnomeorggnomedconf-editor)
* [| 1. /org/gnome/settings-daemon/plugins/media-keys/volume-step => 1](#-1-orggnomesettings-daemonpluginsmedia-keysvolume-step-1)
* [+ Gnome Tweaks (https://gitlab.gnome.org/GNOME/gnome-tweaks)](#-gnome-tweaks-httpsgitlabgnomeorggnomegnome-tweaks)
* [+ Gnome Extension Manager (https://github.com/mjakeman/extension-manager)](#-gnome-extension-manager-httpsgithubcommjakemanextension-manager)
* [+ Gnome Extensions](#-gnome-extensions)
* [+--+ AppIndicator and KStatusNotifierItem Support](#-appindicator-and-kstatusnotifieritem-support)
* [+--+ Bing Wallpaper](#-bing-wallpaper)
* [+--+ Hue Lights](#-hue-lights)
* [+--+ Espresso](#-espresso)
* [+--+ Vitals](#-vitals)
* [+--+ Brightness control using ddcutil](#-brightness-control-using-ddcutil)
* [+--+ No overview at start-up](#-no-overview-at-start-up)
* [+--+ Tiling Shell](#-tiling-shell)
* [+ Application Programs](#-application-programs)
* [+--+ Krusader](#-krusader)
* [+--+ qt6ct color theme](#-qt6ct-color-theme)
* [+--+ Steam](#-steam)
* [+--+ ProtonVPN](#-protonvpn)
* [+--+ AusweisApp2 (eID client of the Federal Republic of Germany)](#-ausweisapp2-eid-client-of-the-federal-republic-of-germany)
* [+--+ Cryptomator (https://github.com/cryptomator)](#-cryptomator-httpsgithubcomcryptomator)
* [+--+ OneDrive CLI-Tool (https://github.com/abraunegg/onedrive)](#-onedrive-cli-tool-httpsgithubcomabrauneggonedrive)
* [|  +--+ OneDrive GUI (https://github.com/bpozdena/OneDriveGUI/releases/latest/)](#-onedrive-gui-httpsgithubcombpozdenaonedriveguireleaseslatest)
* [|     | 1. Download newest AppImage](#-1-download-newest-appimage)
* [|     | 2. Create or update OneDriveGUI Application entry in Menu Editor with AppImage](#-2-create-or-update-onedrivegui-application-entry-in-menu-editor-with-appimage)
* [|     | 3. Add image to startup application in Gnome Tweaks](#-3-add-image-to-startup-application-in-gnome-tweaks)
* [+--+ LibreWolf](#-librewolf)
* [|  +--+ add the repo](#-add-the-repo)
* [|  +--+ install the package](#-install-the-package)
* [|  | * disable tabs: https://superuser.com/a/1619663](#-disable-tabs-httpssuperusercoma1619663)
* [+--+ Microsoft Edge Browser](#-microsoft-edge-browser)
* [+--+ KeePassXC (https://github.com/keepassxreboot/keepassxc)](#-keepassxc-httpsgithubcomkeepassxrebootkeepassxc)
* [+ Color Picker](#-color-picker)
* [+ DDC Control](#-ddc-control)
* [+ solaar (Linux device manager for Logitech devices: https://github.com/pwr-Solaar/Solaar)](#-solaar-linux-device-manager-for-logitech-devices-httpsgithubcompwr-solaarsolaar)
* [| 1. Add to startup applications in Gnome Tweaks](#-1-add-to-startup-applications-in-gnome-tweaks)
* [+ inkscape](#-inkscape)
* [+ cherrytree](#-cherrytree)
* [+ Spotify](#-spotify)
* [+ OpenRGB](#-openrgb)
* [| install udev (https://openrgb.org/udev)](#-install-udev-httpsopenrgborgudev)
* [+ MQTT Explorer (https://github.com/thomasnordquist/MQTT-Explorer)](#-mqtt-explorer-httpsgithubcomthomasnordquistmqtt-explorer)
* [| 1. Download newest AppImage (https://github.com/thomasnordquist/MQTT-Explorer/releases/latest/)](#-1-download-newest-appimage-httpsgithubcomthomasnordquistmqtt-explorerreleaseslatest)
* [| 2. Create or update MQTT-Explorer Application entry in Menu Editor with AppImage](#-2-create-or-update-mqtt-explorer-application-entry-in-menu-editor-with-appimage)
* [| 3. Add image to startup application in Gnome Tweaks](#-3-add-image-to-startup-application-in-gnome-tweaks-1)
* [+ system](#-system)
* [enable OpenH264 plugin in firefox (about:addons => Plugins)](#enable-openh264-plugin-in-firefox-aboutaddons-plugins)

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

You can therefore work with `sm <cmd>` in the same way as with `git <cmd>`. For example, use `sm pull` to pull or `sm push` to push. Add aliases that suit you best. I like the command line tool tig, so I use the alias `sm_tig` to use it for adding, deploying and committing my changes.

## Software

### Terminals, Fonts and Tools

```bash
# + Kitty
dnf install kitty
# + lsd
dnf install lsd
# + htop
dnf install htop
# + tig
dnf install tig
# + bat
dnf install bat
# + fastfetch
dnf install fastfetch
# + Starship (https://starship.rs/)
sudo curl -sS https://starship.rs/install.sh | sh
# + Nerdfont (https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script)
mkdir -p ~/Repositories/00_system/
git clone --depth 1 git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts
bash ./install.sh
# + Numix Icon Theme
# | change icons in Gnome Tewaks
sudo dnf install numix*
# + NeoVim
sudo dnf install neovim
# +--+ lazyvim
#    +--+ backup
ts=$(date +'%d.%m.%Y_%H-%M-%S')
mv ~/.config/nvim ~/.config/nvim.bak-$ts
mv ~/.local/share/nvim ~/.local/share/nvim.bak-$ts
mv ~/.local/state/nvim ~/.local/state/nvim.bak-$ts
mv ~/.cache/nvim ~/.cache/nvim.bak-$ts
#    +--+ Installation
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
´´´

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
sudo dnf install gnome-shell-extension-appindicator
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
# +--+ Krusader
dnf install krusader konsole qt6ct papirus-icon-theme kde-cli-tools
#    +--+ qt6ct color theme
wget -P ~/.config/qt6ct/colors/ https://raw.githubusercontent.com/catppuccin/qt5ct/refs/heads/main/themes/catppuccin-mocha-green.conf
# +--+ Steam
sudo dnf install steam
# +--+ ProtonVPN
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm"
sudo dnf install ./protonvpn-stable-release-1.0.3-1.noarch.rpm && sudo dnf check-update --refresh
sudo dnf install proton-vpn-gnome-desktop
sudo dnf install libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app
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
wget https://github.com/bpozdena/OneDriveGUI/releases/download/v1.1.1a/OneDriveGUI-1.1.1-x86_64.AppImage
chmod +x ./OneDriveGUI*
cd
# +--+ LibreWolf
# |  +--+ add the repo
curl -fsSL https://rpm.librewolf.net/librewolf-repo.repo | pkexec tee /etc/yum.repos.d/librewolf.repo
# |  +--+ install the package
sudo dnf install librewolf
# |  | * disable tabs: https://superuser.com/a/1619663
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
