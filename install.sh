#!/bin/sh

CFG=settings.json
CODE_OSS=~/.config/Code\ -\ OSS/User

err() { echo $1; exit 1; }

[ -L "$CODE_OSS/$CFG" ] && err "You have already installed the configuration!"
[ ! -e $CFG ] && err "Couldn't find the settings.json file, make sure you cd into the repo"

if [ -d "$CODE_OSS" ]; then
	echo "Backing up old configuration to $CODE_OSS/$CFG.bac"
	cp -v "$CODE_OSS/$CFG" "$CODE_OSS/$CFG.bac"
	[ $? == 0 ] || err "Couldn't back up the old configuration, quitting..."
	echo "Linking new configuration"
	ln -sfv $(realpath $CFG) "$CODE_OSS/$CFG"
fi
