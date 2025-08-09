# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

###############################################################################
### Adjustments by David Pelkmann
###############################################################################

###############################################################################
# + Individual Exports
# +--+ getting proper colors
#export TERM="xterm-256color"
# +--+ neovim as standard editor
export EDITOR=nvim
# +--+ set manpager
#    | uncomment the program you want to have as manpager
#    +--+ use bat as manpager
#export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
#    +--+ use nvim as manpager
export MANPAGER="nvim +Man!"
# +--+ set qt6ct as qt platform theme
export QT_QPA_PLATFORMTHEME=qt6ct

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

###############################################################################
# + System Command Aliases
# | If the name of an alias also referes to a program name, you can access this
# | program a starting backslash.
# +--+ ls
alias ls='lsd --human-readable --long --group-dirs first'
# +--+ nvim
alias nv='nvim'
# +--+ micromamba
alias mm='micromamba'
# +--+ tmux
alias tmls='tmux list-sessions'
alias tmas='tmux attach-session -t'
alias tmks='tmux kill-session -t'
# +--+ python environment program aliases
alias pymux='/home/dpelkmann/anaconda3/envs/pymux/bin/pymux'
alias ptpython='/home/dpelkmann/anaconda3/envs/ptpython/bin/ptpython'
alias pyvim='/home/dpelkmann/anaconda3/envs/pyvim/bin/pyvim'
# +--+ ranger
rr_kitty_rename() {
  if [ "$TERM" == "xterm-kitty" ]; then
    kitty @ set-tab-title ranger
    ranger
  else
    ranger
  fi
}
alias rr=rr_kitty_rename
# +--+ kitty tab rename
alias ktr='kitty @ set-tab-title'

###############################################################################
# + Startup
# | commands to display when starting a terminal session
# + -- + fastfetch
#fastfetch
# + -- + launch ssh-agent with its own "key space" - see man page
eval "$(ssh-agent -s)" >/dev/null

###############################################################################
# + Command Line Prompt
# | uncomment the prompt you want
# +--+ starship prompt configuration
eval "$(starship init bash)"
# +--+ powerline prompt configuration
#if [ -f `which powerline-daemon` ]; then
#  powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  . /usr/share/powerline/bash/powerline.sh
#fi

###############################################################################

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
export MAMBA_EXE='/home/dpelkmann/.local/bin/micromamba'
export MAMBA_ROOT_PREFIX='/home/dpelkmann/micromamba'
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__mamba_setup"
else
  alias micromamba="$MAMBA_EXE" # Fallback on help from micromamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
