#!/bin/sh

movePathAndLink() {
    mv ~/.config/$1 ~/.config/$1.bckp
    ln -s $(pwd)/$1 ~/.config/$1
}

moveShell() {
    mv ~/.zshrc ~/.zshrc.bckp
    ln -s $(pwd)/zsh/.zshrc ~/.zshrc

    mv ~/.profile ~/.profile.bckp
    ln -s $(pwd)/zsh/.profile ~/.profile
}


if pwd | grep -q "dotfiles"; then
    echo "You are in dotfiles directory"
else
    echo "You are not in dotfiles directory"
    exit 1
fi

echo "This will move your current dotfiles to .bckp and create a symlink to the dotfiles in this directory"


shopt -s nocasematch
status=true
while $status; do
    echo -n "Do you want to install the dotfiles? (y/n) "
    read -r answer
    if [[ "$answer" == "y" ]]; then
        echo "Installing dotfiles"
        status=false
    elif [[ "$answer" == "n" ]]; then
        echo "Aborting"
        exit 1
    else
        echo "Please answer with y or n"
    fi
done

movePathAndLink nvim
movePathAndLink hypr
movePathAndLink waybar
movePathAndLink kitty


moveShell

echo "Done"

