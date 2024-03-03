#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
fi

firefox_path="${HOME}/.mozilla/firefox"
profiles="${firefox_path}/profiles.ini"
grepstring=$(grep "Default=.*\.default*" "${profiles}")
default_profile=$(cut -d "=" -f2 <<< "${grepstring}")

# Copy over '.css' files
cp firefox/.mozilla/firefox/chrome/*.css "${firefox_path}/${default_profile}/chrome"
