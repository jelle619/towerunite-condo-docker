# Tower Unite Dedicated Condo - Docker Container
This is a Docker container that allows you to host a condo in Tower Unite. The official documentation can be found [here[(https://www.towerunite.com/guides/condo_dedicated_linux.html).

## Getting started
Assuming [Docker](https://docs.docker.com/engine/install/) and Docker Compose have already been installed, create a folder that will house your Docker Compose file, TowerServer.ini file and data folder and go into that directory.
```bash
mkdir towerunite && cd towerunite
```

Then, create a `docker-compose.yml` file as follows. You may use a text editor such as `nano` to accomplish this.

```yaml
services:
  towerunite:
    image: ghcr.io/jelle619/towerunite-condo-docker:master
    container_name: towerunite
    environment:
      - MAP_NAME=/Game/Maps/C_Condo
    ports:
      # Game port for Tower Unite clients
      - "7777:7777/udp"
      # Query port used by Steam and server browsers
      - "27015:27015/udp"
    volumes:
      # Persistent storage for game files and runtime data
      - ./data:/data
      # Read-only mount for the game server configuration file
      - ./TowerServer.ini:/data/Tower/Saved/Config/LinuxServer/TowerServer.ini
```

The `MAP_NAME` environment variable allows you to select A list of condo maps can be found in the [official documentation](https://www.towerunite.com/guides/condo_dedicated_linux.html#condo-map-list).

Make sure to port forward all ports under the `ports` section in the Docker Compose file in your router.

Now also creater a `TowerServer.ini` file using the template below. To get a Steam Login Token, complete [this form](https://steamcommunity.com/dev/managegameservers) using 394690 as the App ID. To get a Tower Login Token, complete [this form](https://moderation.towerunite.com/manage_game_servers.php). For the admin Steam ID, [look for your Steam account's ID in steamID64 (Dec) format](https://www.steamidfinder.com/).

```
[/Script/TowerNetworking.DedicatedServerOptions]
ServerTitle=My Dedicated Condo
MaxPlayers=32
SteamLoginToken=00000000000000000000000000000000
TowerLoginToken=00000000000000000000000000000000

[Administration]
AdminSteamID=00000000000000000

[DedicatedCondoOptions]
CondoAutoSave=True
CondoBackupsEnabled=True
#CondoFile=
```

Run `docker compose up -d` to run your Tower Unite Dedicated Condo!

## Using an already existing Condo save
Make sure you have ran the Docker at leats once such that the game files were able to download into the data folder. If it is currently running, stop the container. Then, use the in-game Export feature in the Condo scoreboard under Saves > Export Condo. This will export the condo to a .map format in your Tower Unite/Workshop/Condo Exports/ folder.

Now, upload this file to your server. You will need to place it inside the data folder under Tower/Condos/. You need to create a folder for each Condo (i.e. C_Condo) inside Tower/Condos/ folder. The .map must be named the same as the condo map you will be loading (i.e. C_Condo.map or C_Studio.map). The full path should look as follows: `YOUR_DATA_FOLDER/Tower/Condos/C_Condo/C_Condo.map` or `YOUR_DATA_FOLDER/Tower/Condos/C_Studio/C_Studio.map`.

After the operation has been completed, start your Docker Container. The new file will automatically be used (unless otherwise stated in the `TowerServer.ini` file).

## Updating Tower Unite
To update the version of Tower Unite, simply restart the container. Every time the container is started, the installation files in the data folder are checked.
1. If the files are out of date, the game update is installed.
2. If some of the files are corrupted, the corruption will be automatically fixed.
3. If the game files are not present, the latest version will be installed.
