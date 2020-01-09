#!/bin/bash

# this is a setup script for all of my WSL preferences
echo ~~~~~~~ Setting up WSL ~~~~~~~~

### first, helper funtions ###

#function reportAndContinue () {

### software instalation ###
echo ~~~~~ Installing Software ~~~~~

echo updating and upgrading packages
sudo apt update && sudo apt upgrade
if [ $? -eq 0 ]; then
  echo complete
else
  echo something went wrong... continuing anyway...
fi

echo installing tree...
sudo apt install tree
if [ $? -eq 0 ]; then
  echo complete
else
  echo something went wrong... continuing anyway...
fi

echo Done Installing Software
