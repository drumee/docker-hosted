# Drumee — Docker install

Run your own Drumee: files, folder-native chat, video meetings and fine-grained
permissions, on a server you control.

This repository holds the Docker Compose templates for a self-hosted Drumee
instance. Everything runs in a single container.

- **Website:** [drumee.com](https://drumee.com)
- **Documentation:** [docs.drumee.com](https://docs.drumee.com/introduction/)
- **Image:** [`drumee/stable`](https://hub.docker.com/r/drumee/stable) on Docker Hub

---

## Requirements

| | Minimum |
|---|---|
| OS | Debian family |
| RAM | 8 GB |
| CPU | 2 GHz, 2 cores |
| Disk | 100 GB for the database volume, plus whatever you plan to store |
| Docker | Engine 20 or newer |

A few constraints that are easy to miss:

- The domain name you give Drumee **cannot be shared** with another application.
- Drumee runs its own DNS and MTA, so ports `53`, `80`, `443`, `5222` and
  `10000/udp` must be free on the host.
- Put `/srv/db` (database) and `/data` (content) on **separate** volumes, and
  give the database volume the faster disk.

## Install

### 1. Install Docker

Follow [the official documentation](https://docs.docker.com/engine/install/debian/),
or:

```console
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### 2. Point your domain at the server

Drumee acts as the authoritative DNS server for its own domain, so it needs both
the records and the glue records in place before it starts.

In your DNS zone, replacing `example.org` with your domain — if you have no IPv6
address, fill in the IPv4 rows only:

| Name | Type | Target |
|---|---|---|
| `example.org` | A | your IPv4 address |
| `example.org` | AAAA | your IPv6 address |
| `ns1.example.org` | A | your IPv4 address |
| `ns1.example.org` | AAAA | your IPv6 address |
| `ns2.example.org` | A | your IPv4 address |
| `ns2.example.org` | AAAA | your IPv6 address |

Then, at your registrar, set the domain's name servers to `ns1.example.org` and
`ns2.example.org`, and add both as **glue records**. Propagation can take a while.

Check it before continuing:

```console
nslookup example.org
```

### 3. Configure the container

```console
git clone https://github.com/drumee/docker-hosted
cd docker-hosted
cp public-public.yml drumee.yml
```

Edit `drumee.yml` and set, at minimum:

| Variable | What it is |
|---|---|
| `DRUMEE_DOMAIN_NAME` | Your domain — must match the DNS records above |
| `hostname` | The same domain |
| `PUBLIC_IP4` / `PUBLIC_IP6` | The public addresses bound to that domain |
| `ADMIN_EMAIL` | Becomes the admin account, and receives the setup link |
| `ACME_EMAIL_ACCOUNT` | Used for the ZeroSSL certificate; defaults to `ADMIN_EMAIL` |
| `DRUMEE_DESCRIPTION` | Free text shown on the login page |
| `volumes` | Host paths for `/srv/db`, `/data` and `/exchangearea` |

Leave `DRUMEE_REPO` and `INFRA_COMPONENTS` alone, and do not change the
right-hand side of any port or volume mapping.

### 4. Start it

```console
sudo docker compose -f drumee.yml up -d
sudo docker logs --follow drumee
```

First boot provisions the database, requests certificates and brings up the
services, so give it time. When it finishes, a setup link is emailed to
`ADMIN_EMAIL` — open it, set the admin password, and you are running Drumee.

## Volumes

| Mount | Purpose |
|---|---|
| `/srv/db` | Database. Dedicated volume, 100 GB or more, fastest disk you have. |
| `/data` | Content storage — the data lake. Size it to your needs. |
| `/exchangearea` | Exchange area between the Drumee filesystem and the host. |
| `/var/mail` | Postfix data, if you mount it. |

Set `STORAGE_BACKUP` and `DB_BACKUP` to enable the rsync backup daemon. Both take
the form `[user@host:]/path/to/backup`; for a remote destination, set up the SSH
keys first.

## Troubleshooting

Ports already in use is the most common failure — Drumee needs `53`, `80`, `443`,
`5222` and `10000/udp`, and a host running `systemd-resolved` or an existing web
server will be holding some of them.

To inspect the container instead of booting the stack, comment the `entrypoint`
line in `drumee.yml` and uncomment the `/bin/bash` one below it.

## Other ways to install

| Path | Repository |
|---|---|
| Bare-metal Debian | [drumee/debian-hosted](https://github.com/drumee/debian-hosted) |
| Synology NAS | [drumee/synology-hosted](https://github.com/drumee/synology-hosted) |
| Local development environment | [drumee/starter-kit](https://github.com/drumee/starter-kit) |

## Contributing

See the org [CONTRIBUTING guide](https://github.com/drumee/.github/blob/main/CONTRIBUTING.md).
Questions and self-hosting help: [Discussions](https://github.com/orgs/drumee/discussions).
