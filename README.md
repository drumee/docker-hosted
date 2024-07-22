# drumee-docker-compose
 Docker compose file for Drumee Installation

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
- For if you expect high rate of read/write operations, database base partition (/srv/db) should be installed on a high speed disk or partition.

### Caution
- The provided domain name can noyt be shared with existing or futur application

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
Wait the change to take effects. Meanwhile :

```console
git clone https://github.com/somanos/drumee-docker-compose.git
```
```console
sudo apt install docker-compose
```
```console
cd drumee-docker-compose
```
```console
cp docker-compose-template.yml docker-compose.yml
```
- open docker-compose and changes values accordingly to you configuration
- save the changes. Check that GLUE records has been updated.

**Ensure changes on your Internet Access Provider has been updated.**

```console
sudo docker compose -f docker-compose.yml up -d
```

You can follow the installation progress with 
```console
sudo docker logs --follow drumee
```