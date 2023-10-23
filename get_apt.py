import subprocess

# Get a list of installed APT packages
apt_process = subprocess.Popen(['dpkg', '--get-selections'], stdout=subprocess.PIPE)
output, _ = apt_process.communicate()
installed_packages = [line.split()[0] for line in output.decode('utf-8').split('\n') if line]

# Save the list to a file
with open('installed_packages.txt', 'w') as file:
    file.write('\n'.join(installed_packages))

print("List of installed packages saved to 'installed_packages.txt'")


import subprocess

# Get a list of installed Snap packages
snap_process = subprocess.Popen(['snap', 'list'], stdout=subprocess.PIPE)
output, _ = snap_process.communicate()
installed_snaps = [line.split()[0] for line in output.decode('utf-8').split('\n')[1:] if line]

# Save the list to a file
with open('installed_snaps.txt', 'w') as file:
    file.write('\n'.join(installed_snaps))

print("List of installed Snap packages saved to 'installed_snaps.txt'")
