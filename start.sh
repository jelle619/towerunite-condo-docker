#!/bin/bash
set -e

echo ">> Running SteamCMD as root..."
/bin/steamcmd +force_install_dir /data +login anonymous +app_update 439660 validate +quit

echo ">> Preparing runtime..."
cp /data/linux64/steamclient.so /data/Tower/Binaries/Linux/ || echo "steamclient.so not found, skipping copy"

# Set proper ownership for runtime files
chown -R tower:tower /data

echo ">> Launching Tower Unite as 'tower'..."
cd /data
exec su-exec tower ./Tower/Binaries/Linux/TowerServer-Linux-Shipping "$MAP_NAME" -log -Port=7777 -QueryPort=27015 -nosteamclient
