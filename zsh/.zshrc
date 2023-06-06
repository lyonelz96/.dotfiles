# helpers
check_command(){ command -v $1 &> /dev/null }
check_dir(){ [ -d $1 ] }

# exports
if check_command "nvim" ; then
    export EDITOR="nvim"
    export VISUAL="nvim"
fi

if check_dir "/opt/homebrew/opt/nvm" ; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

if check_command "go" ; then
   export GOPATH="$HOME/.go"
fi

# evals
if check_command "rbenv" ; then
    eval "$(rbenv init - zsh)"
fi

if check_command "starship" ; then
    eval "$(starship init zsh)"
fi

# completion menu
autoload -Uz compinit && compinit
zstyle ":completion:*" menu select

zmodload zsh/complist

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history

# zplug
if check_dir "/opt/homebrew/opt/zplug" ; then
    export ZPLUG_HOME=/opt/homebrew/opt/zplug
    source $ZPLUG_HOME/init.zsh

    zplug "zdharma-continuum/fast-syntax-highlighting"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "jeffreytse/zsh-vi-mode"

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    zplug load
fi

# aliases
if check_command "exa" ; then
    alias ls="exa --icons -l --group-directories-first"
    alias la="exa --icons -la --group-directories-first"
    alias lst="exa --icons -l --tree --group-directories-first"
    alias lat="exa --icons -la --tree --group-directories-first"
fi

if open -Ra "iterm" ; then
    alias nt="open . -a iterm"
fi

if check_command "git" ; then
    alias gg="git log --oneline --abbrev-commit --all --graph --decorate --color"
    alias gs="git status"
    alias gc="git commit"
    alias ga="git add"
    alias gall="git add ."
    alias gch="git checkout"
    alias gpsh="git push"
    alias gpll="git pull"
    alias gf="git fetch"
    alias gr="git rebase"
    alias gri="git rebase -i"
fi

if check_command "brew" ; then
    alias bu="brew update && brew upgrade && brew autoremove && brew cleanup"
fi

if check_command "nvim" ; then
    alias dot="cd ~/.dotfiles && nvim ."
fi
