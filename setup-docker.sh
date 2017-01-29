#!/bin/bash

function _init() {
  DISTRO=$(lsb_release -is)
  RELEASE=$(lsb_release -rs)
  CODENAME=$(lsb_release -cs)

  echo "SwerpBox Server Bootstrap"
  echo
  echo
  echo "Checking distribution ..."
  if [ ! -x  /usr/bin/lsb_release ]; then
      echo "Detected $DISTRO, as your OS. Unfortunately it is not supported."
      echo "Exiting..."
      exit 1
    fi
  echo "$(lsb_release -a)"
  echo
}

function _permissions() {
  if [[ $EUID != 0 ]]; then
    echo "Please re-run this script as root."
    echo 'Exiting...'
    exit 1
  fi
  echo "Looks like you're the root user. Moving on..."
  echo
}

function _updates() {
  if [[ $DISTRO == Ubuntu ]]; then
    echo "Package updates started..."
    apt-get update && apt-get -qqy upgrade
  else
    echo "Detected $DISTRO, as your OS. Unfortunately it is not supported. Yet."
    echo "Exiting..."
    exit 1
  fi
  if [[ $DISTRO == Debian ]]; then
    echo "Package updates started..."
    apt-get update && apt-get -qqy upgrade
  else
    echo "Detected $DISTRO, as your OS. Unfortunately it is not supported. Yet."
    echo "Exiting..."
    exit 1
  fi
}


function _installLinux() {
  echo "Installing packages..."
  apt-get install -qqy apt-transport-https ca-certificates

  apt-key adv \
  --keyserver hkp://ha.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

  apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
}


function _installDocker() {
  echo "Installing Docker..."
  curl -sSL https://get.docker.com/ | sh
}


function _installCompose() {
  echo "Installing Docker Compose..."
  curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  docker-compose --version
}

function _done() {
  echo "All set up"
  exit 0
}

_init
_permissions
_updates
_installLinux
_installDocker
_installCompose
_done
