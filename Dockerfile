FROM drone/drone-runner-docker as runner

FROM docker:dind

ADD start.sh /start.sh

RUN chmod +x /start.sh  && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk --update add --no-cache && apk add -U --no-cache ca-certificates

EXPOSE 3000

ENV GODEBUG netdns=go
ENV DRONE_PLATFORM_OS linux
ENV DRONE_PLATFORM_ARCH amd64

COPY --from=runner /bin/drone-runner-docker /bin/drone-runner-docker

LABEL com.centurylinklabs.watchtower.stop-signal="SIGINT"

ENTRYPOINT ["/start.sh"]

CMD [ "/bin/drone-runner-docker" ]