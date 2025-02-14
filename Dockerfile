FROM debian:stable-slim AS builder
RUN apt update && \
    apt dist-upgrade -y && \
    apt --no-install-recommends -y install ocaml camlp4 libnum-ocaml-dev git make lib32z1 zlib1g-dev m4 wget ncat ca-certificates
RUN git clone https://github.com/ygrek/mldonkey \
 && cd mldonkey \
 && ./configure --prefix=$PWD/out --enable-batch --enable-upnp-natpmp --enable-gnutella --enable-gnutella2 --disable-gui \
 && make -j1 \
 && make install




FROM debian:stable-slim

RUN \
    export DEBIAN_FRONTEND=noninteractive \
 && apt -y update \
 && apt -y upgrade \
 && apt install --no-install-recommends -y \
        zlib1g libbz2-1.0  libgd3 netcat-openbsd \
        libminiupnpc17 librsvg2-2 librsvg2-common ca-certificates

RUN apt install -y supervisor \
 && apt install -y procps \
 && apt -y --purge autoremove \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/log/mldonkey \
 && rm -rf /var/lib/mldonkey \
 && mkdir -p /var/lib/mldonkey \
 && mkdir /usr/lib/mldonkey/

RUN useradd -ms /bin/bash mldonkey \
 && mkdir -p /var/log/supervisor

COPY --from=builder /mldonkey/out/bin/* /usr/bin/
COPY --from=builder /mldonkey/distrib/mldonkey_command /usr/lib/mldonkey/

ENV MLDONKEY_DIR=/var/lib/mldonkey LC_ALL=C.UTF-8 LANG=C.UTF-8
VOLUME /var/lib/mldonkey

EXPOSE 4000 4001 4080 4081 20562 20566 16965 

ADD entrypoint.sh /
ADD init.sh /

RUN chmod +x /entrypoint.sh /init.sh

ENTRYPOINT ["/init.sh"]
