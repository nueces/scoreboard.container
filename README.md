# scoreboard.container

This container image includes the `CRG Derby Scoreboard`, the `Thin Mint Scoreboard Overlay` and the `Thin Mint Announcer's View`.

## CRG Derby Scoreboard

Project page:

- https://github.com/rollerderby/scoreboard

Accesible via:

- http://localhost:8000/

## Thin Mint Scoreboard Overlay

A custom stream overlay for it with broadcast-quality
Project page:

- https://github.com/heliogoodbye/tmsb

Admin interface:

- http://localhost:8000/custom/overlay/tmsb/admin/index.html

Streaming overlay

- http://localhost:8000/custom/overlay/tmsb/index.html

## Thin Mint Announcer's View

An announcer-focused custom view with real-time game information baed on the data from the CRG.
Project page:

- https://github.com/heliogoodbye/Thin-Mint-Announcers-View

Accesible via:

- http://localhost:8000/custom/view/announcers.html

## How to run the image:

```shell
docker compose up --build
```

> Note: Depending on your local configuration, the container may run on a host or IP address other than localhost.
