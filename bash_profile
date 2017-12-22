export TERM="xterm-color"

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacdx

export EDITOR="code --wait"

export DEBFULLNAME="Mikhail Shustov"
export DEBEMAIL="restrry@gmail.com"
alias dch='dch --distributor=debian'
alias subl='sublime'

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
GRAY="\[\e[0m\]"

PS1="\$(date +%H:%M) $YELLOW\w$GREEN\$(parse_git_branch)$GRAY \$ "
source ~/.git-completion.bash

# standard
# PS1='\[\e[0;33m\]\w\[\e[0m\]\$ '

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

alias l='ls -lAhG'
alias la='ls -a'
alias py='python3'

alias edital='open -a "Sublime Text 2" ~/.bash_profile'
alias saveal='source ~/.bash_profile
echo ".bash_profile has started"'

alias netstat_osx="sudo lsof -i -P"

alias edithosts='open -a "Sublime Text 2" /private/etc/hosts'

alias showall='defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder'
alias hideall='defaults write com.apple.finder AppleShowAllFiles FALSE
killall Finder'

alias hub="git"

alias sr="ssh restrry@merzavcev.ru"

alias sizeof="stat -s $1 | awk '{ print $8 }'"
alias count="ls -f . | wc -l"

alias docker-rm="docker rm $(docker ps -a -q)"
alias docker-rmi="docker rmi $(docker ps -a -q)"


function docker-stop() {
	docker kill $(docker ps -q)
}

function mkcd() {
	mkdir -p "$*";cd "$*";
}

function gemtunnel() {
	local port="${1:-8088}"
	ssh lego-dev.dev.yandex-team.ru -R :$port:`hostname -f`:8080 -N
}

function gemake() {
	enb make tests desktop.tests/$1/gemini/
}

function gemgui() {
	local path="${1:-.}"
	gemini-gui $path --root-url=http://lego-dev.dev.yandex-team.ru:8088
}


alias gemini-tunnel='ssh lego-dev.dev.yandex-team.ru -R :8088:`localhost`:8080 -N | python -m SimpleHTTPServer 8080'
alias gemini-gather='gemini gather --root-url=http://lego-dev.dev.yandex-team.ru:8080'
alias gemini-test='gemini test --root-url=http://lego-dev.dev.yandex-team.ru:8080 --reporter html --reporter flat'

function pyserv() {
	local port="${1:-8080}"
	python -m SimpleHTTPServer $port
}

function prline() {
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function ems() {

	#if [ "$2" ];
	#	then
	#		level="$1"
	#		target="$2"
	#	else
	#		level="desktop"
	#		target="$1"
	#fi

	#enb make sets $level.sets/$target/$target.examples/
	enb make examples desktop.examples/$1/$2
}

function git-copy-branch-name {
	branch=$(git rev-parse --abbrev-ref HEAD)
	echo $branch
	echo $branch | tr -d '\n' | tr -d ' ' | pbcopy
}

function  git-delete-local-merged {
	# Delete all local branches that have been merged into HEAD. Stolen from our favorite @tekkub:
	# https://plus.google.com/115587336092124934674/posts/dXsagsvLakJ
	git branch -d `git branch --merged | grep -v '^*' | grep -v 'master' | tr -d '\n'`
}

function  git-unpushed {
	# Show the diffstat of everything you haven't pushed yet.

	branch=$(git rev-parse --abbrev-ref HEAD)
	count=$(git rev-list --count HEAD origin/$branch...HEAD)

	if [ "$count" -eq "1" ]
	then
	  s=''
	else
	  s='s'
	fi

	git diff --stat origin/$branch..HEAD
	echo " $count commit$s total"
}

function  git-up {
	# Usage: git-up
	#        git-reup
	#
	# Like git-pull but show a short and sexy log of changes
	# immediately after merging (git-up) or rebasing (git-reup).
	#
	# Inspired by Kyle Neath's `git up' alias:
	# http://gist.github.com/249223
	#
	# Stolen from Ryan Tomayko
	# http://github.com/rtomayko/dotfiles/blob/rtomayko/bin/git-up

	set -e

	PULL_ARGS="$@"

	# when invoked as git-reup, run as `git pull --rebase'
	test "$(basename $0)" = "git-reup" &&
	PULL_ARGS="--rebase $PULL_ARGS"

	git pull $PULL_ARGS

	# show diffstat of all changes if we're pulling with --rebase. not
	# sure why git-pull only does this when merging.
	test "$(basename $0)" = "git-reup" && {
	    echo "Diff:"
	    git --no-pager diff --color --stat HEAD@{1}.. |
	    sed 's/^/ /'
	}

	# show an abbreviated commit log of stuff that was just merged.
	echo "Log:"
	git log --color --pretty=oneline --abbrev-commit HEAD@{1}.. |
	sed 's/^/  /'
}

function grab {
	local rep=$1
	local dir=~/work/$2
 	git clone $rep $dir; cd $dir; npm i && npm run deps;
}

function cidate {
    # passed or the last commit
    STATE=$1 || HEAD;
    git show $STATE | grep Date | awk -F':   ' '{print $2}'
}

function gitpatch {
	curl $1.patch | git am
}

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/mikhail.shustov/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/mikhail.shustov/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/mikhail.shustov/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/mikhail.shustov/Downloads/google-cloud-sdk/completion.bash.inc'
fi
