#!/bin/bash
set -e

# Run SteamCMD commands
/bin/steamcmd +force_install_dir /data +login anonymous +app_update 439660 validate +quit

# Copy required shared object
cp /data/linux64/steamclient.so /data/Tower/Binaries/Linux/ || echo "steamclient.so not found, skipping copy"

# Change working directory
cd /data

# Start the server with the given map
./Tower/Binaries/Linux/TowerServer-Linux-Shipping "$MAP_NAME" -log -Port=7777 -QueryPort=27015 -nosteamclient
