#!/bin/bash

SCRIPT_PATH=`pwd`

install_script() {
    { [ ! -e "$2" ] && ln -s "$SCRIPT_PATH/$1" "$2" && echo "$2 installed"; } || echo "$2 NOT installed"
}

install_script emacs.el ~/.emacs
install_script emacs.d ~/.emacs.d
mkdir -p ~/.backup
