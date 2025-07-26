FROM steamcmd/steamcmd:latest

# Create non-root user "tower"
RUN useradd -m -d /home/tower tower \
    && mkdir -p /data \
    && chown -R tower:tower /data /home/tower

# Install su-exec to drop privileges before running Tower Unite
RUN apt-get update && apt-get install -y su-exec && apt-get clean

ENV MAP_NAME="/Game/Maps/C_Condo"

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
