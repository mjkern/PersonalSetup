#!/bin/bash

# this is a setup script for all of my WSL preferences
echo ~~~~~~~ Setting up WSL ~~~~~~~~

### define a few constants ###
ADDITION_FLAG="#~~~~~~~ added by personal setup script on $( date -I ) ~~~~~~~#"
ADDITION_END_FLAG="#~~~~~~~ end of personal setup script additions ~~~~~~~#"
#BASH_PROFILE='~/.bash_profile'
BASH_PROFILE='testBashProfile.sh' # for testing

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
echo ~~~~~ Installing Software ~~~~~

echo ~~ updating and upgrading packages
sudo apt update && sudo apt upgrade
reportAndContinue $?

echo ~~ installing tree...
sudo apt install tree
reportAndContinue $?

echo ~~ Done Installing Software

### bash shortcuts ###

echo ~~~~~ Creating Bash Shortcuts ~~~~~

echo >> $BASH_PROFILE
echo $ADDITION_FLAG >> $BASH_PROFILE
echo '### here are my custom shortcuts ###' >> $BASH_PROFILE
echo ~~ cdd
echo 'alias cdd="cd /mnt/c/Users/mjker/Documents"' >> $BASH_PROFILE
echo '### this is the end of my custom shortcuts ###' >> $BASH_PROFILE
echo $ADDITION_END_FLAG >> $BASH_PROFILE

echo ~~ Done Creating Bash Shortcuts
