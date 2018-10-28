autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt PROMPT_SUBST

function git_dirty() {
    if [[ $(git diff --stat) == '' ]]; then
	print -P "%F{green}✓%f"
    else
	print "%F{red}✗%f"
    fi
}

function is_git() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
	branch=$(git rev-parse --abbrev-ref HEAD)
	print "%F{yellow}( ${branch} )%f $(git_dirty) "
    else
	print ''
    fi
}

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
  # generate the init script from plugins above
  zgen save
fi

export PROMPT='%F{green}╭╴%f $(is_git)$(lpromptf)%F{magenta}[ %~ ]%f 
%F{green}╰➤%f [%F{green}%*%f] %F{red}•%f '
export RPROMPT='$(rpromptf)'
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
