FROM nginx:alpine

ADD container-files /

RUN chmod +x /docker-entrypoint.d/start.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 2375