# drumee-docker-compose
 Docker compose file for Drumee Installation

## Prerequisite
### Settings
- A maiden Internet domain name
- Control Access to GLU DNS of the Internet domain
- At least one Public IP addresses, IPV4 and/or IPV6

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
Go to you domain provider manager and change the Glu DNS of your domain.

git clone https://github.com/somanos/drumee-docker-compose.git
cd drumee-docker-compose
cp docker-compose-template.yml docker-compose.yml
open docker-compose and changes values accordingly to you configuration
save the save then
% sudo docker-compose -f docker-compose.yml up -d

You can follow the installation progress with 

% sudo docker logs --follow <docker-name-or-id>