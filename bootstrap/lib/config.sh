#! /usr/bin/env bash

# DESCRIPTION
# Defines global settings.

# SETTINGS
# General
set -o nounset # Exit, with error message, when attempting to use an undefined variable.
set -o errexit # Abort script at first error, when a command exits with non-zero status.
set -o pipefail # Returns exit status of the last command in the pipe that returned a non-zero return value.
IFS=$'\n\t' # Defines how Bash splits words and iterates arrays. This defines newlines and tabs as delimiters.

# Globals
export SERVER_IP=127.0.1.1 # Placeholder for server IP.
export SERVER_HOSTNAME=home.example.com # Placeholder for server domain.
export USER_PASS=password # The master user password.
export INSTALL_COMMAND="apt-get -q -y"
