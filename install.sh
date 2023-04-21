#!/bin/sh

CFG=settings.json
SNIP=snippets
CODE_OSS=~/.config/Code\ -\ OSS/User
CODE_MAC=~/Library/Application\ Support/Code/User

err() { echo "$1"; exit 1; }

backup() {
	echo "Backing up old configuration to $1/$CFG.bac"
	cp -v "$1/$CFG" "$1/$CFG.bac"
	[ -d "$1/$SNIP" ] && {
		echo "Backing up old snippets to $1/$SNIP.bac/"
		mkdir "$1/$SNIP.bac" && cp -v "$1/$SNIP/*" "$1/$SNIP.bac/"
	}
}

link() {
	echo "Linking new configuration"
	ln -sfv "$(realpath $CFG)" "$CODE_OSS/$CFG"
	echo "Linking new snippets"
	ln -sfv "$(realpath $SNIP)"/* "$CODE_OSS/$SNIP/"
}

[ -L "$CODE_OSS/$CFG" ] && err "You have already installed the configuration!"
[ ! -e $CFG ] && err "Couldn't find the settings.json file, make sure you cd into the repo"

if [ -d "$CODE_OSS" ]; then
	backup "$CODE_OSS" || err "Couldn't back up the old configuration, quitting..."
	link "$CODE_OSS"
fi
