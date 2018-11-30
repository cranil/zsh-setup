autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt PROMPT_SUBST

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
    zgen load zsh-users/zsh-autosuggestions
    zgen save
fi

export PROMPT='%F{green}╭╴%f $(is_git)$(lpromptf)%F{magenta}[ %~ ]%f 
%F{green}╰➤%f [%F{green}%*%f] %F{red}•%f '
export RPROMPT='$(rpromptf)'
if [[ -a /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]
then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -a /home/cranil/.zgen/zsh-users/zsh-autosuggestions-master/zsh-autosuggestions.zsh ]]
then
     source /home/cranil/.zgen/zsh-users/zsh-autosuggestions-master/zsh-autosuggestions.zsh
fi
