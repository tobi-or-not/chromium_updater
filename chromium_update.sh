#!/usr/bin/env bash

# Script Paths
base_url="http://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac"
version_url=$base_url"/LAST_CHANGE"

base_path="/Applications/Chromium.app"
version_file=$base_path"/Contents/info.plist"

runtimestamp=`date "+%Y%m%d_%H%M%S"`

source_file="chrome-mac.zip"
target_file=$runtimestamp-$source_file

#================================

function log () {
	message=$1;
	echo "LOGGER: "$1;
}


# Check if update is available
	latest_version=`curl $version_url`
	local_version=`cat $version_file | grep -A1 SCMRevision | grep -oE '[0-9]+'`

	echo "Local version" $local_version
	echo "Latest version:" $latest_version

	if [ $local_version -lt $latest_version ]
	then
		echo "UPDATES ARE AVAILABLE"
	else
		echo "Chromium is up to date"
		exit 0
	fi

# Check if Chromium is running
	if [ `ps aux | grep -c Chromium.app` -gt 1 ]
	then 
		echo "Chromium appears to be running."
		echo "Quit the browser and start the updater again"
		exit 0
	fi

# Make backup (in trashes so it gets thrown out at some point)
	echo "Backing up current Chromium package to ~/.Trash/"$backup_directory
	backup_directory=Chromium_$runtimestamp
	mkdir  ~/.Trash/$backup_directory
	cp -r $base_path ~/.Trash/$backup_directory

	log $target_file;

# get current version of Chromium
	cd ~/Downloads
	#wget $base_url/$latest_version/$source_file
	curl $base_url/$latest_version/$source_file > ./$target_file
echo "Unzipping downloaded file"
	unzip $target_file -d ./`basename $target_file .zip`

echo "Moving new version to /Applications"
	tmp_dir=`basename $target_file .zip`
	cp -r $tmp_dir/chrome-mac/Chromium.app /Applications/
