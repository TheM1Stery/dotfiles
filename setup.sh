#!/bin/sh

removePathAndLink() {
    rm -rf ~/.config/$1
    ln -s $(pwd)/$1 ~/.config/$1
}

moveShell() {
    rm -rf ~/.zshrc
    ln -s $(pwd)/zsh/.zshrc ~/.zshrc

    rm -rf ~/.profile
    ln -s $(pwd)/zsh/.profile ~/.profile
}


if pwd | grep -q "dotfiles"; then
    echo "You are in dotfiles directory"
else
    echo "You are not in dotfiles directory"
    exit 1
fi

removePathAndLink nvim
removePathAndLink hypr
removePathAndLink waybar
removePathAndLink kitty


moveShell



