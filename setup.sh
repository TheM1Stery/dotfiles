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

movePathAndLink nvim
movePathAndLink hypr
movePathAndLink waybar
movePathAndLink kitty


moveShell



