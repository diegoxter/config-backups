if ! tmux list-sessions
then byobu-tmux new-session -s "Bash"
else byobu-tmux attach-session -t "Bash"
fi
