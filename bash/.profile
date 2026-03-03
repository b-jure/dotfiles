#
# ~/.profile
#

EDITOR="nvim"

GAMES_DIR="${HOME}/games"
VIDEOS_DIR="${HOME}/videos"
MUSIC_DIR="${HOME}/music"

if command -v steam &>/dev/null; then
  steampath="${HOME}/.local/share/Steam"
  STEAM_COMPAT_CLIENT_INSTALL_PATH="${steampath}"
  STEAM_COMPAT_DATA_PATH="${steampath}/steamapps/compatdata"
  PROTON_PATH="${steampath}/steamapps/common/Proton 9.0 (Beta)/proton"

  proton() {
    "${PROTON_PATH}" "$@"
  }
  export -f proton
fi
