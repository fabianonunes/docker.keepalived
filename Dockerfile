FROM alpine:3.19

RUN apk add --no-cache \
  bash \
  findutils \
  gomplate \
  keepalived \
;

RUN touch /var/cache/keepalived.failover

COPY fs /

WORKDIR /etc/keepalived/

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "--log-detail", "--dump-conf", "--vrrp" ]
