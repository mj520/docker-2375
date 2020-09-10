FROM nginx:alpine

ADD container-files /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 2375