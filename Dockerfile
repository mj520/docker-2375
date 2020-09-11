FROM nginx:alpine

ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 2375