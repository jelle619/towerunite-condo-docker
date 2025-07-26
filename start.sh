#!/bin/bash
set -e

# Run SteamCMD as root (writes to /root/.local/share/Steam)
echo ">> Running SteamCMD as root..."
/bin/steamcmd +force_install_dir /data +login anonymous +app_update 439660 validate +quit

# Set ownership of game files to 'tower' so it can launch the game
chown -R tower:tower /data

# Copy steamclient.so if available
cp /data/linux64/steamclient.so /data/Tower/Binaries/Linux/ || echo "steamclient.so not found, skipping copy"

# Drop privileges and run the game as 'tower'
echo ">> Launching Tower Unite server as user 'tower'..."
exec su-exec tower /data/Tower/Binaries/Linux/TowerServer-Linux-Shipping "$MAP_NAME" -log -Port=7777 -QueryPort=27015 -nosteamclient
