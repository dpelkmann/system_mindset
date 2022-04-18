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

### .bashrc adjustments by David Pelkmann ###

# dotfile management via git bare
# source 1: https://www.youtube.com/watch?v=tBoLDpTWVOM
# source 2: https://www.atlassian.com/git/tutorials/dotfiles
alias system_mindset='/usr/bin/git --git-dir=$HOME/Repositories/system_mindset/ --work-tree=$HOME'
# after that in bash: system_mindset --local status.showUntrackedFiles no

# system command aliases
alias ls='ls -l --color'
alias nv='nvim'

# python environment program aliases
alias pymux='/home/dpelkmann/anaconda3/envs/pymux/bin/pymux'
alias ptpython='/home/dpelkmann/anaconda3/envs/ptpython/bin/ptpython'
alias pyvim='/home/dpelkmann/anaconda3/envs/pyvim/bin/pyvim'

# individual exports
export EDITOR=nvim

unset rc

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

