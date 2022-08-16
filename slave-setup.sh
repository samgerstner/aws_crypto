#!/bin/bash

# Global Variables
XMRIG_VERSION="6.18.0"
DOWNLOAD_URL="https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/xmrig-$XMRIG_VERSION-linux-x64.tar.gz"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Setup variables for required packages
REQUIRED_PKG="wget"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")

# Check if required packages are installed
if [ "" = "$PKG_OK" ]; then
  sudo yum install -y $REQUIRED_PKG
fi

# Add XMRig User
sudo adduser xmrig --gecos "xmrig" --password "AWSCrypto2022!"
su xmrig
sudo cp /home/ec2-user/.ssh/authorized_keys /home/xmrig/.ssh/authorized_keys

# Download XMRig
wget $DOWNLOAD_URL

# Extract XMRig
tar -xvf xmrig-$XMRIG_VERSION-linux-x64.tar.gz
mv xmrig-$XMRIG_VERSION xmrig
cd xmrig

# Remove default XMRig config
rm -f config.json

# Copy custom XMRig config
cp $SCRIPT_DIR/config.json .

# Create Monero script
touch mine_monero.sh
echo "" > mine_monero.sh
sudo chmod +x mine_monero.sh

# Start XMRig
./mine_monero.sh