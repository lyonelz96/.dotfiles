# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

alias ls="lsd"
alias la="ls -a"
alias ll="lsd -l"
alias lla="lsd -la"

alias wineaudio="WINEPREFIX=$HOME/Audio/WineAudio wine"

alias phoneaudio="pacmd load-module module-alsa-source device=hw:0,1,0"

PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

export DOTBARE_DIR="$HOME/.dotfiles"
export EDITOR="nvim"

export SOUND_CARD_IRQ=17

export WINEFSYNC=1
export WINEDLLOVERRIDES=winemenubuilder.exe=d
