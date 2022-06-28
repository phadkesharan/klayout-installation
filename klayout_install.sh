# This file automates the build and install instructions for klayout (http://www.klayout.de) on Ubuntu.

# run this file as follows:
# source klayout.sh

# go to home folder
cd ~

# install dependencies
sudo apt-get --yes --force-yes install build-essential
sudo apt-get --yes --force-yes install ruby ruby-dev
sudo apt-get --yes --force-yes install python3 python3-dev
sudo apt-get --yes --force-yes install libz-dev
sudo apt-get --yes --force-yes update
sudo apt-get --yes --force-yes install libqt4-dev-bin libqt4-dev

# clone klayout repository
sudo apt-get --yes --force-yes install git
git clone https://github.com/klayoutmatthias/klayout .klayout
cd .klayout
git checkout 0.26

# Build klayout
clear # clear the terminal
echo "Building klayout... this will take about an hour."
sleep 10 # Sleep for 10 seconds so people see the warning above
chmod u+x build.sh # make build script executable
./build.sh # run build script
chmod u+x bin-release/klayout # make resulting binary executable
echo
echo
echo
echo "Finished building klayout."

# Create custom klayout editor executable shell script
cd ~/.klayout
touch klayout
chmod u+x klayout
echo export PATH='"'$(readlink -f ~)/.klayout/bin-release:'$PATH''"' >> klayout
echo export LD_LIBRARY_PATH='"'$(readlink -f ~)/.klayout/bin-release:'$LD_LIBRARY_PATH''"' >> klayout
echo klayout -e >> klayout

# Add klayout to PATH
cd ~ # go back to home folder
echo '# KLayout Settings' >> .bashrc
echo export PATH='"'$(readlink -f ~)/.klayout:'$PATH''"' >> .bashrc

echo "KLayout binaries and libraries added to path"
source .bashrc

# Installation is finished
echo "Finished installation"

# Run klayout a first time
klayout
