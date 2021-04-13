FROM        alpine

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-weechat"

LABEL       maintainer="ksurl"

WORKDIR     /config

ENV         TERM=screen-256color \
            LANG=C.UTF-8

COPY        init /init

RUN         chmod +x /init && \
            echo "**** install build packages ****" && \
            apk add --no-cache --virtual=build-dependencies \
                cmake \
                gettext-dev \
                asciidoctor \
                ruby-dev \
                lua-dev \
                aspell-dev \
                build-base \
                libcurl \
                libintl \
                zlib-dev \
                curl-dev \
                perl-dev \
                gnutls-dev \
                python3-dev \
                ncurses-dev \
                libgcrypt-dev \
                ca-certificates \
                jq \
                tar && \
            echo "**** install packages ****" && \
            apk -U upgrade && \
            apk add --no-cache \
                aspell-libs \
                curl \
                dumb-init \
                gettext \
                gnutls \
                libgcrypt \
                lua \
                ncurses \
                python3 \ 
                perl \
                ruby \
                shadow \
                su-exec \
                tzdata && \
            echo "**** update ca-certificates ****" && \
            update-ca-certificates && \
            echo "**** install weechat ****" && \
            WEECHAT_TARBALL="$(curl -sS https://api.github.com/repos/weechat/weechat/releases/latest | jq .tarball_url -r)" && \
            curl -sSL $WEECHAT_TARBALL -o /tmp/weechat.tar.gz && \
            mkdir -p /tmp/weechat/build && \
            tar xzf /tmp/weechat.tar.gz --strip 1 -C /tmp/weechat && \
            cd /tmp/weechat/build && \
            cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=None -DENABLE_MAN=ON -DENABLE_TCL=OFF -DENABLE_GUILE=OFF -DENABLE_JAVASCRIPT=OFF -DENABLE_PHP=OFF && \
            make && \
            make install && \
            echo "**** cleanup ****" && \
            apk del --purge build-dependencies && \
            rm -rf /tmp/* /var/cache/apk/*

EXPOSE      9001
VOLUME      /config /downloads

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "/init" ]
