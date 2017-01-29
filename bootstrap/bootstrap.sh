#! /usr/bin/env bash

# DESCRIPTION
# Executes the command line interface.

# SETTINGS
source lib/config.sh

# FUNCTIONS
source lib/options.sh

# EXECUTION
while true; do
  if [[ $# == 0 ]]; then
    printf "\nUsage: run OPTION\n"
    printf "\nUbuntu Options:\n"
    printf "  d: Configure default settings.\n"
    printf "  p: Install system packages.\n"
    printf "  u: Configure users.\n"
    printf "  f: Finalize setup.\n"
    printf "  r: Reboot server.\n"
    printf "  i: Perform complete install (i.e. configure default settings, install packages, configure users, finalize, and reboot.\n"
    printf "  q: Quit/Exit.\n\n"
    read -p "Enter selection: " response
    printf "\n"
    process_option $response
  else
    process_option $1
  fi

  break
done
