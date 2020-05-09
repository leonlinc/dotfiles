# alias
alias e=emacs
alias ec='emacsclient -nw'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
if [ "$(uname -n)" == "Lap1077" ]; then
  alias open=explorer.exe
fi

# export
EDITOR=vim; export EDITOR;

# ssh
SSH_ENV="$HOME/.ssh/env"
[ -f $SSH_ENV ] && . $SSH_ENV
start_ssh_agent () {
  echo "Starting new SSH agent..."
  ssh-agent | sed '/^echo/d' > $SSH_ENV
  . $SSH_ENV
  ssh-add ~/.ssh/*_rsa
}
