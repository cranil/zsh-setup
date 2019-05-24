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
  zgen oh-my-zsh plugins/suse
  zgen oh-my-zsh plugins/virtualenv
  zgen load zsh-users/zsh-autosuggestions
  zgen save
  # generate the init script from plugins above
fi

if [ -n "$PRINT_DIR" ]; then    
  PRMPT='%F{green}╭╴%f $(lpromptf)%F{magenta}[ %F{blue}$HSTNAME%F{magenta}%~ ]%f $(is_git)
%F{green}╰➤%f [%F{green}%*%f] %F{red}•%f '
else
  PRMPT='%F{green}╭╴%f $(lpromptf)%F{magenta}[ $(is_git) ]%f
%F{green}╰➤%f [%F{green}%*%f] %F{red}•%f '
fi
export PROMPT=$PRMPT
export RPROMPT='$(rpromptf)'
