#!/bin/sh
# original source: https://github.com/jkpl/dotfiles/

DOTFILES="
bashrc
inputrc
tmux.conf
vimrc
"

BASEDIR="$(dirname "$0")"

log() {
    echo "$@" 1>&2
}

install_dotfile() {
    local dotfile="$1"
    local src="$(realpath "$BASEDIR/$dotfile")"
    local target="$HOME/.$dotfile"
    local backupfile="$HOME/.$dotfile.old"
    local target_realpath="$(readlink -f "$target")"

    if [ "$target_realpath" = "$src" ]; then
        log "Link is already in place. Skipping $dotfile."
    else
        if [ -L "$target" ]; then
            log "Removing old symlink for $dotfile."
            rm "$target"
        elif [ -e "$target" ]; then
            log "Moving old config for $dotfile to $backupfile"
            mv "$target" "$backupfile"
        fi
        log "Adding symlink for $dotfile."
        ln -s "$src" "$target"
    fi
}

install_gitconfig() {
    local src_gitconfig="$(realpath "$BASEDIR/gitconfig")"
    local current_include="$(git config --global include.path)"
    if [ "$src_gitconfig" = "$current_include" ]; then
        log "Git config include already in place. Skipping."
    else
        log "Installing git config include."
        git config --global include.path "$src_gitconfig"
    fi
}

log "Installing dotfiles to $HOME"

# install dotfiles
for dotfile in $DOTFILES; do
    install_dotfile "$dotfile"
done

# install gitconfig
install_gitconfig
