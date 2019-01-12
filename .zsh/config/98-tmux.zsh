if [[ ! $TERM =~ screen ]]; then
    exec tmux new-session -A -s main
fi
