# SwerpBox Bootstrap

The SwerpBox Bootstrap contains a set of shell scripts for installing and configuring a **fresh** Ubuntu (server) operating
system.

## Table of Contents

- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)

Requirements
========

0. [Ubuntu](http://www.ubuntu.com) - 16.x

Setup
=======
Edit the config.sh file in the `lib` directory and adjust the settings as you see fit, namely the following variables:

- SERVER_IP
- SERVER_HOSTNAME
- USER_LOGIN
- USER_PASS

Usage
============

0. `ssh` to your server or VM.
0. Switch to the root user.
0. Create the a /root/.ssh/authorized_keys file with your public key.
0. `chmod -R 600 /root/.ssh`.
0. Run the `/swerpbox/bootstrap/bootstrap.sh` script.

After the scripts run, you will have created a user for SwerpBox to run as. Installed Docker and
Docker Compose. Configured the server's locales, hostname, and timezone. Ready to use SwerpBox!
