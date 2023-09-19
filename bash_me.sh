#!/bin/bash

# Function to collect installed packages and sources.list files
collect_info() {
    # Collect installed packages using apt and snap
    apt_packages=$(dpkg --get-selections | awk '{print $1}')
    snap_packages=$(snap list | awk '{print $1}')

    # Collect sources.list files
    apt_sources_list="/etc/apt/sources.list /etc/apt/sources.list.d/*"
}

# Function to generate a script to install packages and add sources
generate_install_script() {
    echo "#!/bin/bash"
    echo "echo 'Updating package information...'"
    echo "sudo apt update"

    # Install apt packages
    for package in $apt_packages; do
        echo "sudo apt install -y $package"
    done

    # Install snap packages
    for package in $snap_packages; do
        echo "sudo snap install $package"
    done

    # Add sources.list entries
    for file in $apt_sources_list; do
        echo "sudo cp $file /etc/apt/sources.list.d/"
    done

    echo "echo 'Updating package information...'"
    echo "sudo apt update"
    echo "echo 'All packages and sources have been updated and installed.'"
}

# Main script

# Check if user is an administrator
if [ $(id -u) -ne 0 ]; then
    echo "This script requires administrator privileges. Please enter your password."
    sudo "$0" "$@"
    exit $?
fi

# Collect information
collect_info

# Generate the installation script
generate_install_script > install_packages.sh

echo "Script to install packages and update sources has been generated as 'install_packages.sh'."
chmod +x install_packages.sh
