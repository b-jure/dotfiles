#!/bin/bash


# CONFIGURATION VARIABLES
#
# pm - package manager
# pm_install - package manager install package option/command
pm="pacman"
pm_install="-S"
# packages - list of packages to install using the package manager
packages="gcc git stow keychain xclip eza fzf fd xcape alacritty fish neovim polybar tmux firefox konsole otf-firamono-nerd"
# binpath - path to binaries that are not managed by package manager
binpath="/usr/local/bin"



check_install_status() {
    if [ "$?" -ne 0 ]; then
        echo "Errored while installing '$1', aborting!"
        exit 1
    fi
}

install_package() {
    package_name="$1"
    echo ""; echo ""; echo ""
    echo "Installing $package_name..."
    $pm "$pm_install" "$package_name"
    check_install_status "$package_name"
}

setup_rust() {
    echo ""; echo ""; echo ""
    echo "Installing rust toolchain..."
    if ! command -v rustup &>/dev/null; then
        if ! (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh); then exit 1; fi
        check_install_status "rustup"
    fi
}

setup_sl () {
    echo ""; echo ""; echo ""
    echo "Installin $1..."
    cd "suckless/${1}" || exit 1
    if [ -f config.h ]; then rm config.h; fi
    make clean install
    cd ..
}

setup_gf2 () {
    install_package "freetype2"
    echo ""; echo ""; echo ""
    echo "Installing gf2..."
    git clone https://github.com/nakst/gf.git
    cd gf && ./build.sh
    check_install_status gf2
    if ! cp gf2 "$binpath/gf2"; then exit 1; fi
    cd .. && rm -rf gf
}

setup_interception() {
    install_package "interception-tools"
    install_package "interception-dual-function-keys"
    echo ""; echo ""; echo ""
    echo "Enabling interception (say goodbye to caps lock)..."
    if ! cp --recursive --update interception /etc; then exit 1; fi
    systemctl enable udevmon || exit 1
    systemctl restart udevmon || exit 1
    echo "MAKE SURE 'udevmon' IS ACTUALLY RUNNING, IF NOT DO THIS TO DEBUG -> 'journalctl -u udevmon'"
}

install_ff_css () {
    echo ""; echo ""; echo "";
    echo "Copying over firefox .css files..."
    ./updatecss.sh
}


main() {
    # Check for root
    if [ "$(id -u)" -ne 0 ]; then
        echo "install.sh must be run with root privileges!" >&2
        exit 1
    fi


    # Install packages
    echo "Installing packages..."
    $pm "$pm_install" "$packages" || exit 1
    
    # setup rust
    setup_rust

    # setup gf2
    setup_gf2

    # setup suckless workflow
    install_package libxinerama
    install_package libxft
    setup_sl dwm
    setup_sl dmenu
    setup_sl slstatus

    # interception (caps lock on tap is escape, on hold is control)
    setup_interception

    # Now use stow
    cfgdirs=("nvim" "tmux" "alacritty" "fish" "polybar" "xinitrc")
    for cfg in "${cfgdirs[@]}"; do
        if ! stow "$cfg"; then exit 1; fi
    done

    # Firefox css files
    install_ff_css

    # Finished
    echo "Finished, successful instalation!"
    exit 0
}


# Run main function
main
