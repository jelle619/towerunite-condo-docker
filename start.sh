#!/bin/bash
set -e

# Run SteamCMD to install/update Tower Unite
/bin/steamcmd +force_install_dir /data +login anonymous +app_update 439660 validate +quit

# Copy the steamclient.so file (if it exists)
cp /data/linux64/steamclient.so /data/Tower/Binaries/Linux/ || echo "steamclient.so not found, skipping copy"

# Change to game directory
cd /data

# Run the game server
exec ./Tower/Binaries/Linux/TowerServer-Linux-Shipping "$MAP_NAME" -log -Port=7777 -QueryPort=27015 -nosteamclient
