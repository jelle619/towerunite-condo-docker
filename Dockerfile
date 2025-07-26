FROM steamcmd/steamcmd:latest

# Create non-root user 'tower'
RUN useradd -m -d /home/tower tower \
    && mkdir -p /data \
    && chown -R tower:tower /home/tower /data

# Install su-exec (lightweight privilege dropper, like gosu)
RUN apt-get update && apt-get install -y su-exec && apt-get clean

# Set environment
ENV MAP_NAME="/Game/Maps/C_Condo"

# Copy launch script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Remain as root; script will drop to 'tower' before launching the game
ENTRYPOINT ["/start.sh"]
