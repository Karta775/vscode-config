#!/bin/sh

CFG=settings.json
CODE_OSS=~/.config/Code\ -\ OSS/User

[ -L "$CODE_OSS/$CFG" ] && { echo "You have already installed the configuration!"; exit; }
[ ! -e $CFG ] && { echo "Couldn't find the settings.json file, make sure you cd into the repo"; exit 1; }

if [ -d "$CODE_OSS" ]; then
	echo "Backing up old configuration to $CODE_OSS/$CFG.bac"
	cp -v "$CODE_OSS/$CFG" "$CODE_OSS/$CFG.bac" || { echo "Couldn't back up the old configuration, quitting..."; exit 1; }
	echo "Linking new configuration"
	ln -sfv $(realpath $CFG) "$CODE_OSS/$CFG"
fi
