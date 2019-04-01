ydt() {
  if (( $# == 0 )); then
    exec tmux new-session -A -s main
  else
    exec tmux new-session -A -s $1
  fi
}
