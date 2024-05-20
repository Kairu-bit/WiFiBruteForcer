#!/bin/bash

installr(){
  pkg update -y
  pkg upgrade -y
  pkg install nodejs
  node wlanbrute.js
}

userHavePermission(){
  directory_path="/sdcard/"
  if [ -r $directory_path ] && [ -w $directory_path ]; then
    return 0
  else 
    return 1
  fi
}

directory_path="/sdcard/"

if userHavePermission; then
  installr
else
  echo -e "\033[1;33mWiFiBrute: \033[1;32mInstalling Requirments Please Allow The Permission\033[0m";

  sleep 6

  case "${TERMUX__USER_ID:-}" in ''|*[!0-9]*|0[0-9]*) TERMUX__USER_ID=0;; esac

  am broadcast --user "$TERMUX__USER_ID" \
       --es com.termux.app.reload_style storage \
       -a com.termux.app.reload_style com.termux > /dev/null
  ./setup.sh
fi

