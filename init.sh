#!/bin/bash

SWERP_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="${SWERP_DIR}/.env"

function _permissions() {
  if [[ $EUID != 0 ]]; then
    echo "Please re-run this script as root."
    echo 'Exiting...'
    exit 1
  fi
  echo "Looks like you're the root user. Moving on..."
  echo
}

function _createUser() {
    SWERP_USER=$(grep swerp /etc/passwd)

    if [[ -z ${SWERP_USER} ]]; then
        echo "Creating user: swerp"
        useradd -u 1000 -U -m swerp
        echo "Adding user to Docker group..."
        usermod -a -G docker swerp
    fi

    SWERP_UID=$(id -u swerp)
    SWERP_GID=$(id -g swerp)

    if [[ ! -f ${ENV_FILE} ]]; then
        touch "${ENV_FILE}"
    else
        echo '' > "${ENV_FILE}"
    fi
    echo "Creating your .env file..."
    echo ""
    echo ""
    echo "PUID=${SWERP_UID}" >> .env
    echo "PGID=${SWERP_GID}" >> .env
    echo "PLEX_UID=${SWERP_UID}" >> .env
    echo "PLEX_GID=${SWERP_GID}" >> .env
    echo "USERNAME=swerp" >> .env
    echo "PASSWORD=swerp" >> .env
    echo "TZ=America/Denver" >> .env
    echo "PLEX_CLAIM=" >> .env
    echo "ADVERTISE_IP=" >> .env
    echo "CHANGE_CONFIG_DIR_OWNERSHIP=false" >> .env

    echo "Done creating .env file. Please fill in the blank entries."
}

_permissions
_createUser
