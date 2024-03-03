#!/bin/bash


# CONFIGURATION VARIABLES
#
# pm - package manager
# pm_install - package manager install package option/command
pm="pacman"
pm_install="-S"
# packages - list of packages to install using the package manager
packages=(
    "gcc" "git" "stow" "keychain" "xclip" "eza"
    "fzf" "fd" "xcape" "alacritty" "fish" "neovim"
    "polybar" "tmux" "firefox"
)
# binpath - path to binaries that are not managed by package manager
binpath="/usr/local/bin"



check_install_status() {
    if [ "$?" -ne 0 ]; then
        echo "Errored while installing '$1', aborting!"
        exit 1
    else 
        echo "Successfully installed '$1'."
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



main() {
    # Check for root
    if [ "$(id -u)" -ne 0 ]; then
        echo "install.sh must be run with root privileges!" >&2
        exit 1
    fi


    # Install packages
    len=${#packages[@]}
    for (( i=0; i<len; i++ )); do
        if ! install_package "${packages[$i]}"; then exit 1; fi
    done
    # Install rust and gf2
    setup_rust
    setup_gf2


    # Now use stow
    cfgdirs=("nvim" "tmux" "alacritty" "fish" "formatting" "polybar")
    for cfg in "${cfgdirs[@]}"; do
        if ! stow "$cfg"; then exit 1; fi
    done
    # Additionally copy over the .css files for firefox
    echo ""; echo ""; echo "";
    echo "Copying over firefox .css files..."
    ./updatecss.sh

    # Finished
    echo "Finished, successful instalation!"
    exit 0
}


# Run main function
main
