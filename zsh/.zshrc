autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ls='exa --icons -l'
alias la='exa --icons -la'
alias lst='exa --icons -l --tree'
alias lat='exa --icons -la --tree'

alias nt='open . -a iterm'

eval "$(starship init zsh)"
