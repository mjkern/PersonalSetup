#!/bin/bash

# this is a setup script for all of my WSL preferences
echo ~~~~~~~ Setting up WSL ~~~~~~~~

### define a few constants ###
ADDITION_FLAG="#~~~~~~~ added by personal setup script on $( date -I ) ~~~~~~~#"
ADDITION_END_FLAG="#~~~~~~~ end of personal setup script additions ~~~~~~~#"
BASH_PROFILE=~/.bash_profile # it is important that the ~ is interpreted and not in quotes
VIMRC_URL='https://raw.githubusercontent.com/mjkern/PersonalSetup/master/.vimrc'

### and helper funtions ###

# given the status of a command, prints "complete" if status is 0 and prints
# an error message otherwise
function reportAndContinue () {
  if [ $1 -eq 0 ]; then
    echo ~~ complete
  else
    echo ~~ something went wrong:
    echo $1
    echo ~~ continuing anyway...
  fi
}

### software installation ###
function installSoftware () {
  echo ~~~~~ Installing Software ~~~~~

  echo ~~ updating and upgrading packages
  sudo apt update && sudo apt upgrade
  reportAndContinue $?

  echo ~~ installing tree...
  sudo apt install tree
  reportAndContinue $?

  echo ~~ installing vim
  sudo apt install vim
  reportAndContinue $?

  echo ~~ installing openssh-client
  sudo apt install openssh-client
  reportAndContinue $?

  echo ~~ Done Installing Software
}

### bash shortcuts ###
function createBashShortcuts () {
  echo ~~~~~ Creating Bash Shortcuts ~~~~~

  # possible point of improvement - only add the shortcuts that don't yet work

  echo >> $BASH_PROFILE
  echo $ADDITION_FLAG >> $BASH_PROFILE
  echo '### here are my custom shortcuts ###' >> $BASH_PROFILE
  echo ~~ cdd
  echo 'alias cdd="cd /mnt/c/Users/mjker/Documents"' >> $BASH_PROFILE
  reportAndContinue $?
  echo '### this is the end of my custom shortcuts ###' >> $BASH_PROFILE
  echo $ADDITION_END_FLAG >> $BASH_PROFILE

  echo ~~ Done Creating Bash Shortcuts
}

### setup vim ###
function setupVim () {
  echo ~~~~~ Configuring vim ~~~~~~~

  ## download vimrc
  # notice that vimrc make sure that vimplug is installed so we don't need to
  # worry about that here
  # possible point of improvement - simply backup the old .vimrc if it exists
  echo ~~ downloading .vimrc

  # be careful about overwriting the old .vimrc
  CONFIRMATION=y
  if [ -e ~/.vimrc ]; then
    read -p '~/.vimrc already exists. would you like to overwrite it? (y/n) ' CONFIRMATION
  fi

  if [ $CONFIRMATION = y ]; then
    cd ~
    if [ $? = 0 ]; then
      curl -O $VIMRC_URL
      reportAndContinue $?
      cd -
      if [ ! $? = 0 ]; then
        echo ~~ fatal error going back to directory
        exit 1
      fi
    fi
  elif [ $CONFIRMATION = n ]; then
    echo okay, skipping
  else
    echo unknown response, skipping
  fi

  ## ensure vim pluggins are installed
  echo ~~ installing vimplug pluggins
  vim -c "source ~/.vimrc" -c PlugInstall +qall
  echo '~~ (hopefully that worked...)'

  echo ~~ Done with vim
}

### run all steps ###
installSoftware
createBashShortcuts
setupVim
