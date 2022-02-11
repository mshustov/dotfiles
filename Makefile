.PHONY: brew-install brew zsh-install git env bash ssh

all: brew-install brew zsh-install git env bash ssh

brew-install:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

zsh-install:
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cp zshrc ~/.zshrc

brew:
	./brew

git:
	cp git-completion.bash ~/.git-completion.bash
	cp gitconfig ~/.gitconfig
	cp gitignore ~/.gitignore

env:
	mkdir ~/.nvm

shell:
	cp bash_profile ~/.bash_profile

ssh:
	[ -d ~/.ssh ] || mkdir ~/.ssh
	[ -f ~/.ssh/config ] || cp -n ssh/config ~/.ssh/config
	chmod 644 ~/.ssh/config
	ssh-keygen -t rsa -C "restrry@gmail.com" -N "" -f ~/.ssh/id_rsa
	pbcopy < ~/.ssh/id_rsa.pub
	echo -e "\033[0;32mPaste key from your clipboard to https://github.com/settings/ssh"

