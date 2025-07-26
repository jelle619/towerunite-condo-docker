FROM steamcmd/steamcmd:latest

# Create non-root user "tower"
RUN useradd -m -d /home/tower tower \
    && mkdir -p /data \
    && chown -R tower:tower /home/tower /data

ENV MAP_NAME="/Game/Maps/C_Condo"

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
