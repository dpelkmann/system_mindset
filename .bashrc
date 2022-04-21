# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
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

# + individual exports
export TERM="xterm-256color"                      # getting proper colors
export EDITOR=nvim

# + system_mindset - Dotfile Management via git bare
# | 1. source: https://www.youtube.com/watch?v=tBoLDpTWVOM
# | 2. source: https://www.atlassian.com/git/tutorials/dotfiles
sm_dir=$HOME/.config/sm/
alias sm='/usr/bin/git --git-dir=${sm_dir}system_mindset/ --work-tree=$HOME'
# | manually managed, so not show other files in $HOME 
sm config --local status.showUntrackedFiles no
# | update modified, deleted and new files to commit
alias sm_stage-changes='sm add $(sm status | grep "modified\|deleted\|new file" | sed "s/.*://")'
# | remove updated files 
alias sm_unstage-changes='sm reset --mixed'

# + set manpager
# | use bat as manpager
#export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
# | use nvim as manpager
export MANPAGER="nvim +Man!"

# + System Command Aliases
# | note:   If the name of an alias also referes to a program name, you can
# |         access this program a starting backslash.
alias ls='lsd --almost-all --human-readable --long --group-dirs first'
alias nv='nvim'

# + python environment program aliases
alias pymux='/home/dpelkmann/anaconda3/envs/pymux/bin/pymux'
alias ptpython='/home/dpelkmann/anaconda3/envs/ptpython/bin/ptpython'
alias pyvim='/home/dpelkmann/anaconda3/envs/pyvim/bin/pyvim'

# + starship prompt configuration
eval "$(starship init bash)"

# + powerline prompt configuration
#if [ -f `which powerline-daemon` ]; then
#  powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  . /usr/share/powerline/bash/powerline.sh
#fi

###############################################################################

unset rc

### conda adjustments ###

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dpelkmann/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dpelkmann/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dpelkmann/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dpelkmann/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

