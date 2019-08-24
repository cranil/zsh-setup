autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt PROMPT_SUBST

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  if (( ${+HOSTNAME} )); then
  else
    HOSTNAME=$(hostname)
  fi
  HSTNAME="🖥  ssh://$HOSTNAME/"
  # many other tests omitted
else
  case $(ps -o comm= -p $PPID) in
    
    sshd|*/sshd) "🖥  ssh://$HOSTNAME/";;
  esac
  HSTNAME=""
fi

function rpromptf(){
  if [[ $(print -P '%?') == "0" ]]; then
    print " 😺 "
  else
    print " 😾 "
  fi
}

function lpromptf(){
  if [[ $? == "0" ]]; then
    print -P ""
  else
    print -P "\n"
  fi
}

source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
    # specify plugins here
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/virtualenv
    zgen oh-my-zsh plugins/cargo
    # generate the init script from plugins above
    zgen load zsh-users/zsh-autosuggestions
    zgen save
fi

export PROMPT='%F{green}╭╴%f $(lpromptf)%F{green}[%F{blue}$HSTNAME%f %F{red}|%f%F{green} %~ ]%f $(is_git)
%F{green}╰➤%f [%F{green}%*%f] %F{red}•%f '
export RPROMPT='$(rpromptf)'

bindkey -r "^[^["
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word
