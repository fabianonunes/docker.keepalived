# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04
SHELL ["/bin/bash", "-exc"]

COPY --from=hairyhenderson/gomplate:v3.11.6 /gomplate /usr/local/bin/gomplate

RUN <<EOT
  apt-get update
  apt-get install -y --no-install-recommends \
    keepalived \
  ;
  apt-get clean
  rm -rf /var/lib/apt/lists/*

  touch /var/cache/keepalived.failover
EOT

COPY fs /

WORKDIR /etc/keepalived/

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "--log-detail", "--dump-conf", "--vrrp" ]
