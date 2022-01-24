#!/bin/bash
set -e

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew_packages=$(cat ./brew-packages.txt)
cask_packages=$(cat ./cask-packages.txt)

for package in $brew_packages
do
  if [ ! -d /usr/local/Cellar/$package ]; then
    echo "$package is not installed, installing ..."
    brew install $package
  fi
done

echo "------------"

for package in $cask_packages
do
  if [ ! -d /usr/local/Caskroom/$package ]; then
    echo "$package is not installed"
    brew install --cask $package
  fi
done

# launchctl load -w /Library/LaunchDaemons/setenv.TNS_ADMIN.plist
