FROM        alpine:3.22.1

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-weechat"

LABEL       maintainer="ksurl"

WORKDIR     /config

ENV         TERM=screen-256color \
            LANG=C.UTF-8

COPY        init /init

RUN         set -x; \
            chmod +x /init && \
            echo "**** install packages ****" && \
            apk add --no-cache \
                aspell-libs \
                curl \
                dumb-init \
                gettext \
                gnutls \
                libgcrypt \
                ncurses \
                python3 \ 
                ruby \
                shadow \
                su-exec \
                tzdata \
                weechat && \
            echo "**** cleanup ****" && \
            rm -rf /tmp/* /var/cache/apk/*

VOLUME      /config /downloads

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "/init" ]
