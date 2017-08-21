.PHONY: brew npm subl git env bash ssh webstorm

all: brew-install brew npm subl git env bash ssh webstorm

brew-install:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew:
	./brew

subl:
	cp Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
	git clone https://github.com/fman7/frontend-light/ ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/frontend-light

git:
	cp git-completion.bash ~/.git-completion.bash
	cp gitconfig ~/.gitconfig
	cp gitignore ~/.gitignore

env:
	cp ondirrc ~/.ondirrc
	mkdir ~/.nvm

bash:
	cp bash_profile ~/.bash_profile

bash-osx:
	cp bash_osx ~/.bash_osx

ssh:
	[ -d ~/.ssh ] || mkdir ~/.ssh
	[ -f ~/.ssh/config ] || cp -n ssh/config ~/.ssh/config
	chmod 644 ~/.ssh/config
	ssh-keygen -t rsa -C "restrry@gmail.com" -N "" -f ~/.ssh/id_rsa
	pbcopy < ~/.ssh/id_rsa.pub
	echo -e "\033[0;32mPaste key from your clipboard to https://github.com/settings/ssh"

webstorm:
	cp settings.jar ~/settings.jar
