#!/bin/bash

# Script Variables
XMRIG_VERSION="6.18.0"
DOWNLOAD_LINK="https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/xmrig-$XMRIG_VERSION-linux-x64.tar.gz"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Create xmrig User
sudo adduser --gecos --password "CryptoSlave2022!" --quiet
sudo usermod -aG sudo xmrig
su xmrig

# Download XMRig
wget $DOWNLOAD_LINK

# Extract XMRig
tar -xvf xmrig-$XMRIG_VERSION-linux-x64.tar.gz
rm -f xmrig-$XMRIG_VERSION-linux-x64.tar.gz
mv xmrig-$XMRIG_VERSION xmrig
cd xmrig

# Remove default XMRig config
rm -f config.json

# Copy custom XMRig config
cp $SCRIPT_DIR/monero_config.json ./config.json

# Start XMRig
sudo ./xmrig