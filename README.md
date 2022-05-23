# Docker image for [WeeChat](https://weechat.org/)

[![](https://img.shields.io/badge/Docker%20Hub--blue)](https://hub.docker.com/r/ksurl/weechat) [![](https://img.shields.io/badge/GitHub%20Container%20Registry--yellow)](https://github.com/users/ksurl/packages/container/package/weechat)

[![](https://img.shields.io/github/v/tag/ksurl/docker-weechat?label=image%20version&logo=docker)](https://hub.docker.com/r/ksurl/weechat) [![](https://img.shields.io/docker/image-size/ksurl/weechat/latest?color=lightgrey&logo=Docker)]() [![](https://img.shields.io/github/workflow/status/ksurl/docker-weechat/build?label=build&logo=Docker)](https://github.com/ksurl/docker-weechat/actions?query=workflow%3Abuild)

* Based on alpine

## Usage

### docker cli

    docker run -d \
        --name=CONTAINER_NAME \
        -v HOST_DOWNLOADS:/downloads \
        -v HOST_CONFIG:/config \
        -e PUID=1000
        -e PGID=1000
        -e TZ=UTC \
        ghcr.io/ksurl/weechat

### docker-compose

    version: "3"
    services:
      weechat:
        image: ghcr.io/ksurl/weechat
        container_name: weechat
        network_mode: bridge
        environment:
          - PUID=1000
          - PGID=1000
          - TZ=UTC
        volumes:
          - <HOST>/config:/config
          - <HOST_MNT>/downloads:/downloads
        restart: unless-stopped

### Parameters

| Parameter | Function | Default |
| :----: | --- | --- |
| `-e PUID` | Set uid | `1000` |
| `-e PGID` | Set gid | `1000` |
| `-e TZ` | Specify a timezone to use | `UTC` |
| `-v /config` | Config folder goes here | |
| `-v /downloads` | Downloads go here | |
