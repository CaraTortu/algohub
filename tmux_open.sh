#!/bin/bash

# Start docker
sudo systemctl start docker

# Start a new session named algohub and open neovim
tmux new -s algohub -d 
tmux rename-window -t algohub 'EDIT'
tmux send-keys -t algohub 'nvim .' C-m 

tmux new-window -t algohub
tmux rename-window -t algohub 'RUN'
tmux send-keys -t algohub 'make db-setup' C-m
tmux send-keys -t algohub 'make go-run-dev' C-m

tmux split-window -v -t algohub
tmux send-keys -t algohub 'make next-run' C-m

tmux select-window -t algohub:1
tmux switch -t algohub

