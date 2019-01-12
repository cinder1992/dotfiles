tmux attach &> /dev/null

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi
