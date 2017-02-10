#!/bin/sh
# Install dotfiles and configurations using symlinks.
# Based on https://github.com/jkpl/dotfiles

MULTIPLATFORM="
bashrc
inputrc
tmux.conf
vimrc
"

LINUX_ONLY="
config/i3
config/redshift.conf
"

BASEDIR="$(dirname "$0")"

log() {
    echo "$@" 1>&2
}

symlink() {
    local file="$1"
    local src="$(realpath "$BASEDIR/$file")"
    local target="$HOME/.$file"
    local backupfile="$HOME/.$file.old"
    local target_realpath="$(readlink -f "$target")"

    if [ "$target_realpath" = "$src" ]; then
        log "Link is already in place. Skipping $file."
    else
        if [ -L "$target" ]; then
            log "Removing old symlink for $file."
            rm "$target"
        elif [ -e "$target" ]; then
            log "Moving old config for $file to $backupfile"
            mv "$target" "$backupfile"
        fi
        log "Adding symlink for $file."
        ln -sv "$src" "$target"
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

install_multiplatform() {
    for file in $MULTIPLATFORM; do
        symlink "$file"
    done
}

install_linux_only() {
    mkdir -p "$HOME/.config"
    for file in $LINUX_ONLY; do
        symlink "$file"
    done
}

print_help() {
    cat << EOF

Usage:
    $0 all        Install all dotfiles
    $0 multi      Install only multiplatform dotfiles

EOF
}


case "$1" in
    "all")
      install_multiplatform
      install_gitconfig
      install_linux_only
      ;; 
    "multi")
      install_multiplatform
      install_gitconfig
      ;; 
   *)
      print_help
      ;; 
esac 
