export EDITOR="nvim"
export VISUAL="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(rbenv init - zsh)"

eval "$(starship init zsh)"

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

alias ls='exa --icons -l'
alias la='exa --icons -la'
alias lst='exa --icons -l --tree'
alias lat='exa --icons -la --tree'

alias nt='open . -a iterm'

alias gg='git log --oneline --abbrev-commit --all --graph --decorate --color'
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gall='git add .'
alias gch='git checkout'
alias gp='git push'
alias gr='git rebase'
alias gri='git rebase -i'

alias bu='brew update && brew upgrade && brew autoremove && brew cleanup'
alias bs='brew search'
alias bi='brew info'

alias dot='nvim ~/.dotfiles'
