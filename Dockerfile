FROM nginx:alpine

ADD templates/* /etc/nginx/templates/

EXPOSE 2375

ENV PROXY_PORT 2375

ENV PROXY_UPSTREAM "keepalive_timeout 300s;keepalive_requests 100000;upstream  backend {server consul:8500;keepalive 300;}"

ENV PROXY_PASS http://unix:/var/run/docker.sock

# admin 123456
ENV PROXY_USER "admin:T8PxFzD7p5DUc"

ENV PROXY_AUTH /etc/nginx/conf.d/htpasswd

RUN sed -i 's/nginx;/root;/g' /etc/nginx/nginx.conf