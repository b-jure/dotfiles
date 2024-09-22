#!/bin/bash
notify-send --app-name="mbsync" "Synchronizing mail" --icon=/home/dlroweht/pics/email.svg
mbsync -Va&
