#
# ~/.bash_profile
#

[ -e ~/.bash_functions ] && . ~/.bash_functions
[ -e ~/.profile ] && . ~/.profile
[ -e ~/.bashrc ] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec startx
fi
