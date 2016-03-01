#!/bin/bash

SCRIPT_PATH=`pwd`

install_script() {
    { [ ! -e "$2" ] && ln -s "$SCRIPT_PATH/$1" "$2" && echo "$2 installed"; } || echo "$2 NOT installed"
}


if [ "`uname`" = "Darwin" ] ; then
    install_script emacs/emacs.el ~/.emacs
    install_script emacs/emacs.d ~/.emacs.d
    mkdir -p ~/.backup
    install_script emacs/template ~/.template
    install_script emacs/tmthemes ~/.tmthemes
fi

if [ "`uname`" = "GNU/Linux" ] ; then
    install_script emacs/emacs.el ~/.emacs
    install_script emacs/emacs.d ~/.emacs.d
    mkdir -p ~/.backup
    install_script emacs/template ~/.template
    install_script emacs/tmthemes ~/.tmthemes
fi
