if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# See ~/.ssh/rc
if [ -f ~/.ssh/sock ]; then
	export SSH_AUTH_SOCK=~/.ssh/sock
fi

PATH="$HOME/.local/bin:$PATH"
if [[ $(uname -a) =~ "Darwin" ]]; then
	# brew install coreutils
	PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

export EDITOR=nvim
export LANG=en_US.UTF-8

alias e='emacs -nw'
alias ec='emacsclient -nw'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias vi=nvim
