#!/bin/bash

# Read the list of installed packages from the file
while IFS= read -r package; do
    sudo apt-get install -y "$package"
done < installed_packages.txt

echo "All packages installed successfully."



#!/bin/bash

# Read the list of installed Snap packages from the file
while IFS= read -r snap; do
    sudo snap install "$snap"
done < installed_snaps.txt

echo "All Snap packages installed successfully."
