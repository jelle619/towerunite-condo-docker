# Dockerfile
FROM steamcmd/steamcmd:latest

# Set default environment variable
ENV MAP_NAME="/Game/Maps/C_Condo"

# Working directory (arbitrary, as runtime script controls the flow)
WORKDIR /root

# Create runtime script
RUN echo '#!/bin/bash\n\
set -e\n\
/bin/steamcmd +force_install_dir /data +login anonymous +app_update 439660 validate +quit\n\
cp /data/linux64/steamclient.so /data/Tower/Binaries/Linux/ || echo "steamclient.so not found, skipping copy"\n\
cd /data\n\
./Tower/Binaries/Linux/TowerServer-Linux-Shipping "$MAP_NAME" -log -Port=7777 -QueryPort=27015 -nosteamclient\n' > /start.sh \
    && chmod +x /start.sh

# Entrypoint runs everything at container start
ENTRYPOINT ["/start.sh"]
