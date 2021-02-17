# docker-rainloop
[![Build Status](https://ci.quacker.org/api/badges/d/docker-rainloop/status.svg)](https://ci.quacker.org/d/docker-rainloop)

## What is this?
Rainloop webmail + Nginx in Docker

## Supports
- Nginx configured at port 80
- PHP max upload size 100MB

## Usage
### Volumes
The rainloop data volume is `/var/www/rainloop/data`

The log volume is `/logs`

### Docker cli:
`sudo docker run -d -v logs:/logs -v data:/var/www/rainloop/data -p 8080:80 quackerd/rainloop`
### docker-compose:
This docker-compose file sets up postgres with rainloop.
```yaml
version: '3.4'

networks:
        br-rainloop:
                external: false
services:
        rainloop_db:
                container_name: rainloop_db
                image: postgres:12
                restart: unless-stopped
                networks:
                        - br-rainloop
                volumes:
                        - ./db:/var/lib/postgresql/data
                environment:
                        - POSTGRES_USER=rainloop
                        - POSTGRES_PASSWORD=password
                        - POSTGRES_DB=rainloop

        rainloop:
                restart: unless-stopped
                networks: 
                        - br-rainloop
                image: quackerd/rainloop
                container_name: rainloop
                depends_on:
                        - rainloop_db
                volumes:
                        - ./data:/var/www/rainloop/data
                        - ./logs:/logs

```

## Updating
Simply pull and rerun: `docker-compose pull && docker-compose up -d`