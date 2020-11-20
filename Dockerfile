FROM plugins/docker as plugin

FROM docker:dind

ADD start.sh /start.sh

COPY --from=plugin /bin/drone-docker /bin/drone-docker

RUN chmod +x /start.sh && chmod +x /bin/drone-docker && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk --update add --no-cache && apk add -U --no-cache ca-certificates
    
ENV DOCKER_HOST=unix:///var/run/docker.sock

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh", "/bin/drone-docker"]

ENTRYPOINT ["/bin/drone-docker"]