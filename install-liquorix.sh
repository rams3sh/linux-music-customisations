#!/bin/bash


GRUB_SCRIPT_DIRECTORY="/etc/grub.d"
GRUB_FILE="/etc/default/grub"

# Remove ubuntu studio restrictions from displaying of unofficial linux kernels
sudo sed -i "s/^/#/g" $GRUB_SCRIPT_DIRECTORY/9_lowlatency 
sudo chmod -x $GRUB_SCRIPT_DIRECTORY/09_lowlatency

# Making the custom boot script (where non official linux kernel source makes entries / changes) executable so that it gets recognized during grub update
sudo chmod +x $GRUB_SCRIPT_DIRECTORY/10_linux


# Ensuring that grub menu appears during every boot to help in choosing respective kernel (helpful while debugging, incase anything goes wrong)
sed -i "s/^GRUB_TIMEOUT_STYLE=hidden/#GRUB_TIMEOUT_STYLE=hidden/g" $GRUB_FILE
sed -i "s/^GRUB_TIMEOUT=0/GRUB_TIMEOUT=10/g" $GRUB_FILE # Setting the timeout to 10 seconds to give sufficient time for user to select an option


# Update the grub once
sudo update-grub


# Install liquorix kernel
sudo apt install curl -y 
curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

# The above liquorix script will update the grub and set the default option in grub for liquorix kernel. 

# NOTE:- 
# In case of any error, try disabling secure boot in your UEFI Firmware settings (that appears in grub menu during boot) and reboot again. 
# Every laptop has its own way of disabling secure boot. Please refer your laptop's official documentation for the steps in case browsing the UEFI firmware menu
# is not clear. It should be very trivial in most of the cases.
