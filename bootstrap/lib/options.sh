#! /usr/bin/env bash

# DESCRIPTION
# Defines command line prompt options.

# Process option selection.
# Parameters:
# $1 = The option to process.
process_option() {
  case $1 in
    'd')
      scripts/apply_defaults;;
    'p')
      scripts/install_packages;;
    'u')
      scripts/configure_users;;
    'f')
      scripts/finalize_setup;;
    'r')
      shutdown -r now;;
    'i')
      scripts/apply_defaults
      scripts/install_packages
      scripts/configure_users
      scripts/finalize_setup
      shutdown -r now;;
    'q');;
    *)
      printf "ERROR: Invalid option.\n";;
  esac
}
export -f process_option
