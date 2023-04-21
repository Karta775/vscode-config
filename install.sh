#!/bin/sh

CFG=settings.json
SNIP=snippets
CODE=""
CODE_OSS=~/.config/Code\ -\ OSS/User
CODE_MAC=~/Library/Application\ Support/Code/User

err() { echo "$1"; exit 1; }

backup() {
	echo "Backing up old configuration to $CODE/$CFG.bac"
	cp -v "$CODE/$CFG" "$CODE/$CFG.bac"
	[ -d "$CODE/$SNIP" ] && {
		echo "Backing up old snippets to $CODE/$SNIP.bac/"
		mkdir "$CODE/$SNIP.bac" && cp -v "$CODE/$SNIP/*" "$CODE/$SNIP.bac/"
	}
}

link() {
	echo "Linking new configuration"
	ln -sfv "$(realpath $CFG)" "$CODE/$CFG"
	echo "Linking new snippets"
	ln -sfv "$(realpath $SNIP)"/* "$CODE/$SNIP/"
}

# Detect installation
if [ -d "$CODE_OSS" ]; then
	CODE=$CODE_OSS
elif [ -d "$CODE_MAC" ]; then
	CODE=$CODE_MAC
else
	err "Couldn't find your Visual Studio Code installation"
fi

# Guards
[ -L "$CODE/$CFG" ] && err "You have already installed the configuration!"
[ ! -e $CFG ] && err "Couldn't find the settings.json file, make sure you cd into the repo"

# Install
backup || err "Couldn't back up the old configuration, quitting..."
link
