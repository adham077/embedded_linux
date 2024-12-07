#!/bin/bash


if [ -f "$HOME/.bashrc" ]; then
    export HELLO=${HOSTNAME}
    LOCAL=$(whoami)
    gnome-terminal &

else
    echo ".bashrc file does not exist in your home directory."
fi
