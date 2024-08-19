# Docker Compose File Template
 Docker Compose File to run Drumee in a Container

## Dependencies
- nginx
- mariadb
- nodejs
- bind9
- graphicsmagick
- ffmpeg
- redis
- libreoffice
- postfix
- opendkim

## Prerequisite
### Settings
- A maiden Internet domain name
- Control Access to GLU DNS of the Internet domain
- At least one Public IP addresses, IPV4 and/or IPV6
- Docker Engine version 20 or higher

### Hardware
- RAM at least 8Go
- CPU at leat 2 GHz
- Enough space to host what you need

### Recommandations
- Drumee should be installed on a dedicated disks or partitions
- MFS (/data) should be not installed on the same partition as server (/srv)
- If you expect high rate of read/write operations, database base partition (/srv/db) should be installed on a high speed disk or partition.

### Caution
- The provided domain name can not be shared with existing or futur application
- It is recommanded not to share DB server with any other application

## Installation 
- Install Docker Engine as per [the offical documentation](https://docs.docker.com/engine/install/debian/)

Open your provider's DNS manager.
- In th DNS zone, remove all existing DNS records
- Add records A and AAAA (if any) to your domain name
- Add records A and AAAA to ns1.your.domain and ns2.your.domain 
- Change the GLUE records of your DNS registry as follows: 
* ns1.your.domain <---> IP4,IP6
* ns2.your.domain <---> IP4,IP6
- Change to name servers fo your domain to ns1.your.domain and ns2.your.domain
Wait the change to take effects.

Meanwhile, you can preapre the installation envirnoment.

```console
git clone https://github.com/drumee/docker-hosted
```

```console
cd docker-hosted
```

```console
cp template.yml my-drumee.yml
```

- Use your favorite IDE to change values in *install-docker.yml* accordingly to your setup. 
- Save the changes. 
- Check that GLUE records has been updated.

**Ensure changes on your Internet Access Provider has been updated.**

```console
sudo docker compose -f my-drumee.yml up -d
```
You may need to stop some exissting service on your server, as their ports are conflicting with the ones required by Docker.

You can follow the installation progress with 
```console
sudo docker logs --follow drumee
```
