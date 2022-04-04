FROM        alpine:3.15.3

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-weechat"

LABEL       maintainer="ksurl"

WORKDIR     /config

ENV         TERM=screen-256color \
            LANG=C.UTF-8

COPY        init /init

RUN         chmod +x /init && \
            echo "**** install packages ****" && \
            apk add --no-cache \
                aspell-libs \
                curl \
                dumb-init \
                gettext \
                gnutls \
                libgcrypt \
                #lua \
                ncurses \
                python3 \ 
                #perl \
                ruby \
                shadow \
                su-exec \
                ttyd \
                tzdata \
                weechat && \
            #echo "**** update ca-certificates ****" && \
            #update-ca-certificates && \
            echo "**** cleanup ****" && \
            rm -rf /tmp/* /var/cache/apk/*

EXPOSE      9001
VOLUME      /config /downloads

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "/init" ]
