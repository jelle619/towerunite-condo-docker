FROM steamcmd/steamcmd:latest

ENV MAP_NAME="/Game/Maps/C_Condo"

# Copy script into container
COPY start.sh /start.sh

# Make sure it’s executable
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
