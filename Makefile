CURDIR := $(shell pwd)

.DEFAULT_GOAL := help

.PHONY: help update install dotfiles configs bash vim git tmux config_folder \
	i3 redshift

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'

update: ## Update from git repo
	git pull --rebase --quiet

install: dotfiles configs ## Symlink dotfiles and configs

dotfiles: bash vim git tmux ## Symlink only dotfiles

configs: config_folder i3 redshift ## Symlink only configs


bash:
	@test -s ~/.bashrc  || ln -sv $(CURDIR)/bashrc  ~/.bashrc
	@test -s ~/.inputrc || ln -sv $(CURDIR)/inputrc ~/.inputrc

vim:
	@test -s ~/.vimrc || ln -sv $(CURDIR)/vimrc ~/.vimrc
	@test -d ~/.vim   || ln -sv $(CURDIR)/vim   ~/.vim

git:
	@test -s ~/.gitconfig || ln -sv $(CURDIR)/gitconfig ~/.gitconfig

tmux:
	@test -s ~/.tmux.conf || ln -sv $(CURDIR)/tmux.conf ~/.tmux.conf


config_folder:
	@mkdir -p ~/.config

i3:
	@test -d ~/.config/i3 || ln -sv $(CURDIR)/config/i3 ~/.config/i3

redshift:
	@test -s ~/.config/redshift.conf || \
	ln -sv $(CURDIR)/config/redshift.conf ~/.config/redshift.conf
