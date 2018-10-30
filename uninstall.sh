
brew_packages=$(cat ./brew-packages.txt)
cask_packages=$(cat ./cask-packages.txt)

for package in $brew_packages
do
  if [ -d /usr/local/Cellar/$package ]; then
    echo "$package is installed, uninstalling ..."
    brew uninstall $package
  fi
done

echo "------------"

for package in $cask_packages
do
  if [ -d /usr/local/Caskroom/$package ]; then
    echo "$package is installed, uninstalling ..."
    brew cask uninstall $package
  fi
done
