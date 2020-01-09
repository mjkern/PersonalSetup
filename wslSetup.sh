#!/bin/bash

# this is a setup script for all of my WSL preferences
echo ~~~~~~~ Setting up WSL ~~~~~~~~

### first, helper funtions ###

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

### software instalation ###
echo ~~~~~ Installing Software ~~~~~

echo ~~ updating and upgrading packages
sudo apt update && sudo apt upgrade
reportAndContinue $?

echo ~~ installing tree...
sudo apt install tree
reportAndContinue $?

echo ~~ Done Installing Software
