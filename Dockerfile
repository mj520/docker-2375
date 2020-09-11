FROM nginx:alpine

ADD container-files /

RUN chmod +x /docker-entrypoint.d/start.sh

EXPOSE 2375