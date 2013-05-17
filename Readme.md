# Chromium Updater Script
Since Chromium does not come with an updater, this script provides a simple command line option to update the browser. It checks the chromium repository for the last build, downloads it and sets it up.

# Setup
* Have a look at the `base_path` variable. You might have to adjust the path to have it reflect where your Chromium is installed
* Other than that, just run `./chromium_update`

# Nice to know
During the update process, the script backs up the current version of the browser to the trash. This means that it can be put back if something goes wrong. Otherwise, the old data will be thrown out the next time you empty the trash.
