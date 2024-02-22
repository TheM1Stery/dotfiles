# Sample .profile for SUSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi


# Added by Toolbox App
export PATH="$PATH:/home/themystery/.local/share/JetBrains/Toolbox/scripts"

. "$HOME/.cargo/env"
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -s ~/.alias && . ~/.alias || true

# test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
# test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
# echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

# load bash_completion from brew if exists
# if [ -d "/home/linuxbrew/.linuxbrew/etc/bash_completion.d" ]; then
#     # loop through all files in bash_completion.d and source them
#     for f in /home/linuxbrew/.linuxbrew/etc/bash_completion.d/*; do
#         . $f
#     done
# fi


alias vim="nvim"
export DOTFILES="$HOME/Documents/dotfiles"
alias overwatch='lutris lutris:rungame/overwatch-2'

alias nuget='mono ~/nuget.exe'

# alias rm = "rm -i"

# opensuse zypper aliases
alias zrmu="zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | rg -v Name | sudo xargs -r zypper remove --clean-deps"
alias zin="sudo zypper in"
alias zse="zypper se"
alias zrm="sudo zypper rm"
alias zre="sudo zypper ref"
alias zup="sudo zypper up"
alias zdup="sudo zypper dup"
alias zrn="sudo zypper ps -s"
alias zve="sudo zypper ve"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export SUDO_EDITOR="nvim"
export EDITOR="nvim"
mkcdir ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

# fzf + fd
export FZF_DEFAULT_COMMAND="fd . $HOME"

_check_hidden_arg(){
    if [[ "$1" = "--hidden" ]]; then
        return 0
    fi
    return 1
}

# need to clean this up(TODO)
cdf(){
    arg=$1
    hidden=false
    if _check_hidden_arg "$arg"; then
        hidden=true
        arg=$2
    fi
    if [ -z "$arg" ]; then
        if $hidden; then
            result="$($FZF_DEFAULT_COMMAND --hidden | fzf)"
            if [ -d "$result" ]; then
                cd "$result"
            fi
            return 0
        fi
        result="$(fzf $arg)"
        if [ -d "$result" ]; then
            cd "$result"
            return 0
        fi
        echo "Not a directory or empty"
        return 1
    fi
    fd_command="fd . $arg --type d --max-depth 1"
    if $hidden; then
        fd_command="$fd_command --hidden"
    fi
    cd "$($fd_command | fzf)"
}

# need to clean up this function(TODO)
vimf(){
    arg=$1
    hidden=false
    if _check_hidden_arg "$arg"; then
        hidden=true
        arg=$2
    fi
    if [ -z "$arg" ]; then
        if $hidden; then
            result="$($FZF_DEFAULT_COMMAND --hidden | fzf)"
            vim "$result"
            if [ -d "$result" ]; then
                cd "$result"
            fi
            return 0
        fi
        result="$(fzf $arg)"
        if [ -z "$result" ]; then
            echo "Not a file/directory or empty"
            return 1
        fi
        vim "$result"
        if [ -d "$result" ]; then
            cd "$result"
        fi
        return 0
    fi
    fd_command="fd . $arg --max-depth 1"
    if $hidden; then
        fd_command="$fd_command --hidden"
    fi
    result=$($fd_command | fzf)
    if [ -d "$result" ]; then
        cd "$result"
    fi

    vim "$result"
}


alias clear="clear && fastfetch"
alias gitstat='git log --format="%aN" | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | awk '\''{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }'\'' -; done'
alias clearhm="clear && cd ~"
alias rm="rm -i"
alias hyprexec="hyprctl dispatch exec"
alias tgwaybar="killall -SIGUSR1 waybar"
alias rwaybar="killall -SIGUSR2 waybar"
alias ls="lsd"
alias sl="sl -e -d"
