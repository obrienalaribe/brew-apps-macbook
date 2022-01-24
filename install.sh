#!/bin/bash
set -e

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi


brew_packages=$(cat ./brew-packages.txt)
cask_packages=$(cat ./cask-packages.txt)

for package in $brew_packages
do
  if [ ! -d /usr/local/Cellar/$package ]; then
    echo "$package is not installed, installing ..."
    brew install $package || true
  fi
done

echo "------------"

for package in $cask_packages
do
  if [ ! -d /usr/local/Caskroom/$package ]; then
    echo "$package is not installed"
    brew install --cask $package || true
  fi
done

# For M1 macbooks
softwareupdate --install-rosetta


# Configure Rust & Cargo 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

rustup default stable
rustup update
rustup update nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup show
