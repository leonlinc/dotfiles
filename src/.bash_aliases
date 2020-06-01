alias e=emacs
alias ec='emacsclient -t'
alias grep='grep --color=auto'
alias ls='ls --color=auto'

if [[ "$(uname -r)" =~ "microsoft" ]]; then
	alias open=explorer.exe
fi

if [ -S ~/.ssh/sock ]; then
	SSH_AUTH_SOCK=~/.ssh/sock; export SSH_AUTH_SOCK;
fi