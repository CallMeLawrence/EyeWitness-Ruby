#!/bin/bash

# Global Variables
userid=`id -u`
osinfo=`cat /etc/issue|cut -d" " -f1|head -n1`
eplpkg='http://linux.mirrors.es.net/fedora-epel/6/i386/epel-release-6-8.noarch.rpm'

# Clear Terminal (For Prettyness)
clear

# Print Title
echo '#######################################################################'
echo '#                          EyeWitness Setup                           #'
echo '#######################################################################'
echo

# Check to make sure you are root!
# Thanks to @themightyshiv for helping to get a decent setup script out
if [ "${userid}" != '0' ]; then
  echo '[Error]: You must run this setup script with root privileges.'
  echo
  exit 1
fi

# OS Specific Installation Statement
case ${osinfo} in
  # Kali Dependency Installation
  Kali)
    echo '[*] Installing Kali Dependencies'
    apt-get install ruby-dev
    bundle install
  ;;
  # Debian 7+ Dependency Installation
  Debian)
	echo '[*] Bundle Installing'
	bundle install
    echo '[*] Checking Ruby Environment'
    rvmhere=`which rvm | wc -l`
    rubyhere=`which ruby | wc -l`
    if [[ $rvmhere -eq 0  && $rubyhere -eq 0 ]]
    then
        echo
        echo "[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"
    	echo "[*]    To use the ruby version of EyeWitness please install Ruby.    [*]"
    	echo "[*]                     Then run \"bundle install\"                    [*]"
    	echo "[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"
    	echo
    fi
  ;;
  # Ubuntu (tested in 13.10) Dependency Installation
  Ubuntu)
    echo '[*] Installing Ubuntu Dependencies'
    apt-get install rubygems
    bundle install
    echo
    echo '[*] Checking Ruby Environment'
    rvmhere=`which rvm | wc -l`
    rubyhere=`which ruby | wc -l`
    if [[ $rvmhere -eq 0  && $rubyhere -eq 0 ]]
    then
        echo
        echo "[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"
    	echo "[*]    To use the ruby version of EyeWitness please install Ruby.    [*]"
    	echo "[*]                     Then run \"bundle install\"                    [*]"
    	echo "[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"
    	echo
    fi
  ;;
  # CentOS 6.5+ Dependency Installation
  CentOS)
    echo '[Warning]: EyeWitness on CentOS Requires EPEL Repository!'
    read -p '[?] Install and Enable EPEL Repository? (y/n): ' epel
    if [ "${epel}" == 'y' ]; then
      rpm -ivh ${eplpkg}
    else
      echo '[!] User Aborted EyeWitness Installation.'
      exit 1
    fi
    echo
    echo '[*] Checking Ruby Environment'
    bundle install
    rvmhere=`which rvm | wc -l`
    rubyhere=`which ruby | wc -l`
    if [[ $rvmhere -eq 0  && $rubyhere -eq 0 ]]
    then
        echo
        echo "[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"
    	echo "[*]    To use the ruby version of EyeWitness please install Ruby.    [*]"
    	echo "[*]                     Then run \"bundle install\"                    [*]"
    	echo "[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"
    	echo
    fi
  ;;
  # Notify Manual Installation Requirement And Exit
  *)
    echo "[Error]: ${OS} is not supported by this setup script."
    echo '[Error]: To use EyeWitness, manually install python, PyQt4.'
    echo '[Error]: Install ghost.py from https://github.com/ChrisTruncer/Ghost.py.git'
    echo
    exit 1
esac

# Finish Message
echo '[*] Setup script completed successfully, enjoy EyeWitness! :)'
echo