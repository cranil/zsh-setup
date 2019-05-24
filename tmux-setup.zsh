#!/usr/bin/zsh

function default_windows() {
    tmux send-keys 'watch -n 1 sensors'
    tmux split-window -h 'htop'
}

function new_tmux_session() {
    tmux new-session -s $1
}
