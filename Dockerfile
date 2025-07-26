FROM steamcmd/steamcmd:latest

# Create non-root user and set permissions
RUN useradd -m -d /home/steam steam \
    && mkdir -p /data \
    && chown -R steam:steam /home/steam /data

ENV MAP_NAME="/Game/Maps/C_Condo"

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Use steam user
USER steam

# Set working directory
WORKDIR /home/steam

ENTRYPOINT ["/start.sh"]
