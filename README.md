# System Mindset

This repository stores and manages personal and system configurations for Fedora 44. It is based on a bare repository and inspired by Atlassian's [article](https://www.atlassian.com/git/tutorials/dotfiles) and DT's [video](https://www.youtube.com/watch?v=tBoLDpTWVOM). Some system configurations are inspired by [devangshekhawat](https://github.com/devangshekhawat/Fedora-40-Post-Install-Guide).

<!-- mtoc-start -->

* [Setup](#setup)
* [Usage](#usage)
* [Software](#software)
  * [Terminals, Fonts and Tools](#terminals-fonts-and-tools)
  * [Gnome related Software](#gnome-related-software)
  * [Application Programs](#application-programs)
  * [Updates](#updates)
* [Firmware Update](#firmware-update)
* [Media Codecs](#media-codecs)
* [H/W Video Acceleration](#hw-video-acceleration)
* [udev Rules](#udev-rules)
  * [Keychron K2 HE](#keychron-k2-he)

<!-- mtoc-end -->

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
# + btop
dnf install btop
# + nethogs (bandwidth per process)
dnf install nethogs
# + iftop (traffic per connection)
dnf install iftop
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
cd ~/Repositories/00_system/
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
bash ./install.sh
# + MicroMamba
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
# + Fuse Libs
sudo dnf install fuse-libs
# + Numix Icon Theme
# | change icons in Gnome Tewaks
sudo dnf install numix*
# + NeoVim
sudo dnf install neovim
# +--+ lazyvim
#    | note: for user and root
#    +--+ backup
ts=$(date +'%d.%m.%Y_%H-%M-%S')
mv ~/.config/nvim ~/.config/nvim.bak-$ts
mv ~/.local/share/nvim ~/.local/share/nvim.bak-$ts
mv ~/.local/state/nvim ~/.local/state/nvim.bak-$ts
mv ~/.cache/nvim ~/.cache/nvim.bak-$ts
#    +--+ Installation
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
# +--+ configure btrfs-backup
#    +--+ get hash of file
sha256sum ~/.btrfs/btrfs-backup-and-retention.sh
#    +--+ make it executeable
chmod +x ~/.btrfs/btrfs-backup-and-retention.sh
#    +--+ allow sudo for script (hash-pinned)
(root) NOPASSWD: sha256:<HASH> /home/dpelkmann/.btrfs/btrfs-backup-and-retention.sh
#    +--+ configure systemd
systemctl --user daemon-reload
systemctl --user enable --now btrfs-backup.timer
```

### Gnome related Software

```bash
# + Alacarte (Alacarte is a menu editor for GNOME: https://gitlab.gnome.org/GNOME/alacarte)
sudo dnf install alacarte
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
# +--+ Caffeine
firefox https://extensions.gnome.org/extension/517/caffeine/
# +--+ Vitals
firefox https://extensions.gnome.org/extension/1460/vitals/
# +--+ Tiling Shell
firefox https://extensions.gnome.org/extension/7065/tiling-shell/
```

### Application Programs

```bash
# + Application Programs
# +--+ Krusader
dnf install krusader konsole qt6ct papirus-icon-theme kget kdiff3 thunderbird krename kate lzma lha unarj unrar kget
#    +--+ qt6ct color theme
wget -P ~/.config/qt6ct/colors/ https://raw.githubusercontent.com/catppuccin/qt5ct/refs/heads/main/themes/catppuccin-mocha-green.conf
# +--+ Steam
sudo dnf install steam
# +--+ ProtonVPN
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.4-1.noarch.rpm"
sudo dnf install ./protonvpn-stable-release-1.0.4-1.noarch.rpm && sudo dnf check-update --refresh
sudo dnf install proton-vpn-gnome-desktop
sudo dnf install libappindicator-gtk3 gnome-shell-extension-appindicator
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
wget https://github.com/bpozdena/OneDriveGUI/releases/download/v1.3.1/OneDriveGUI-1.3.1-x86_64.AppImage 
chmod +x ./OneDriveGUI*
cd
# +--+ LibreWolf
# |  +--+ add the repo
sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
sudo dnf install librewolf
# |  +--+ install the package
sudo dnf install librewolf
# |  | * disable tabs: https://superuser.com/a/1619663
# +--+ BTRFS Assistant
sudo dnf install btrfs-assistant
# +--+ Microsoft Edge Browser
flatpak install flathub com.microsoft.Edge
# +--+ KeePassXC (https://github.com/keepassxreboot/keepassxc)
sudo dnf install keepassxc
# + Color Picker
sudo dnf install gcolor3
# + solaar (Linux device manager for Logitech devices: https://github.com/pwr-Solaar/Solaar)
# | 1. Add to startup applications in Gnome Tweaks
sudo dnf install solaar
# + inkscape
sudo dnf install inkscape
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
sudo dnf4 group install multimedia
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing # Switch to full FFMPEG.
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin # Installs gstreamer components. Required if you use Gnome Videos and other dependent applications.
sudo dnf group install -y sound-and-video # Installs useful Sound and Video complementary packages.
sudo dnf install ffmpeg-libs libva libva-utils
```

## H/W Video Acceleration

```bash
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
# after this enable the OpenH264 Plugin in Firefox's settings.
```

## udev Rules

### Keychron K2 HE

Some Keychron keyboards do not register as standard HID keyboards. Instead, they identify themselves as vendor‑specific HID devices.

On Fedora, such devices are handled with restricted default permissions. This means applications running as a normal user — including the Keychron Launcher — cannot access the device via /dev/hidraw*.

As a result, the Launcher cannot communicate with the keyboard unless you adjust the udev permissions. To verify that Chrome can now access the device, open `chrome://device-log` and look for new hid entries appearing when you plug in or interact with your Keychron keyboard.

The following Bash snippet demonstrates a temporary workaround.

```bash
# + Keychron K2 HE
echo 'KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0666"' | sudo tee /etc/udev/rules.d/99-keychron-hid.rules > /dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger
chromium-browser --user-data-dir=/tmp/chromium-su --no-sandbox "https://launcher.keychron.com/"
echo 'KERNEL=="hidraw*", ATTRS{idVendor}=="3434", MODE="0600"' | sudo tee /etc/udev/rules.d/99-keychron-hid.rules > /dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger

```

