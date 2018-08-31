#!bin/bash
# this script is a test for user prompting

echo "	"
echo "This is a script to make your Arch necessities easier to configure."
echo "Throughout this script, [ENTER] will be YES, and CTRL-C will exit."
read -p "Press ENTER to continue..."
echo "	"

# Time Zone Select
echo "Time Zone setup"
#tzselect
#hwclock --systohc

# Hostname
echo "Set hostname."
read set_hostname
echo $set_hostname > /etc/hostname

# init /etc/hosts
echo 127.0.0.1	localhost > /etc/hosts
echo ::1		localhost > /etc/hosts
echo 127.0.0.1	$set_hostname.localdomain	$set_hostname

# Networking
echo "What type of networking will we be using?"
echo "1) Wireless"
echo "2) Wired"
read option_networking
	if [ $option_networking == 1 ]
	then
		wifi-menu -o
		echo "Wireless Networking Configured."
	else [ $option_networking == 2 ]
	for interface in $(ip link | grep ': ' | cut -d':' -f2)
		do
			echo "$interface"
		done 
		echo "Select your interface. Usually starts with enp."
		read option_interface
		systemctl start dhcpcd@$option_interface.service
		systemctl enable dhcpcd@$option_interface.service
		ping -c 3 www.google.com
		echo "Wired Networking Configured."
	fi 

# Update pacman
echo "Updatating pacman..."
pacman -Syuu

# GRUB download and install
echo "Are you dual-booting with another operating system?"
echo "1) Yes"
echo "2) No"
read option_dualboot
	if [ $option_dualboot == 1 ]
	then 
		pacman -S grub os-prober
	elif [ $option_dualboot == 2 ]
	then
		pacman -S grub	
	else 
		echo "You didn't select the right option."	
	fi 

# Set root password
echo "Set root password"
passwd




