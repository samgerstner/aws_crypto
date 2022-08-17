#!/bin/bash

# Script Variables
XMRIG_VERSION="6.18.0"
DOWNLOAD_LINK="https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/xmrig-$XMRIG_VERSION-linux-x64.tar.gz"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Verify that coin name was passed to script
if [ -n "$1"]
then
    COIN_NAME="$1"
else
    echo "Error: You must supply a coin name."
    echo "Usage: ./slave-setup <coin-name>"
    exit 1
fi

# Create xmrig user
sudo su
adduser --gecos --disabled-password xmrig
usermod -aG sudo xmrig

# Download XMRig
cd /home/xmrig
wget $DOWNLOAD_LINK
tar -xvf xmrig-$XMRIG_VERSION-linux-x64.tar.gz
rm xmrig-$XMRIG_VERSION-linux-x64.tar.gz
mv xmrig-$XMRIG_VERSION xmrig

# Copy XMRig config files for mining
cp $SCRIPT_DIR/*_config.json /home/xmrig/xmrig

# Set XMRig application folder permissions
chown -R xmrig /home/xmrig/xmrig
chmod -R 744 /home/xmrig/xmrig

# Call slave initialize endpoint
curl https://reqbin.com/echo/post/json 
   -H "Content-Type: application/json"
   -d '{"hostname": "test.test.com"}' 

# Start XMRig
su xmrig
cd ~/xmrig
sudo ./xmrig --config=$COIN_NAME_config.json