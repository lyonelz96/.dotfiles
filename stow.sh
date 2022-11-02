targets=("nvim" "zsh" "tmux" )

for target in "${targets[@]}"
do
    echo "Stowing $target"
    stow -R $target
done
