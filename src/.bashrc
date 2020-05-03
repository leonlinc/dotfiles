# base16-shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -e $BASE16_SHELL ] && . $BASE16_SHELL/scripts/base16-ocean.sh
base16_clone () {
  git clone https://github.com/chriskempson/base16-shell $BASE16_SHELL
}

# ssh
SSH_ENV="$HOME/.ssh/env"
[ -f $SSH_ENV ] && . $SSH_ENV
ssh_agent_start () {
  echo "Starting new SSH agent..."
  ssh-agent | sed '/^echo/d' > $SSH_ENV
  . $SSH_ENV
  ssh-add
}

dot=$HOME/proj/dotfiles/src
dot_install () {
  if [ ! -e $HOME/$1 ]; then
    cp -v $dot/$1 $HOME/$1
  fi
}
dot_install .gitconfig
dot_install .inputrc
dot_install .tmux.conf
dot_install .vimrc

# alias
alias e='emacsclient -nw'
if [ "$(uname)" == "Darwin" ]; then
  alias grep='grep --color=auto'
  alias ls='ls -G'
fi
if [ "$(uname -n)" == "Lap1077" ]; then
  alias open=explorer.exe
fi

EDITOR=vim; export EDITOR;
