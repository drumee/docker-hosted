user=$(whoami)
cp local-domain.yaml my-docker.yaml

sed -i "s/BASE/$(whoami)/g" my-docker.yaml

mkdir -p $HOME/.config/local.drumee/storage/db:/srv/db
mkdir -p $HOME/.config/local.drumee/storage/data:/data
mkdir -p $HOME/.config/local.drumee/storage/exchange:/exchangearea
mkdir -p $HOME/build/local.drumee:/mnt/devel

sudo docker compose -f my-docker.yaml -d
sudo docker logs --follow drumee
