FROM nginx:alpine

ADD templates /etc/nginx/

EXPOSE 2375

RUN echo -e "\nstream {\n    include /etc/nginx/conf.d/*.stream;\n}" >> /etc/nginx/nginx.conf

ENV PROXY_PORT 2375

ENV PROXY_PASS unix:/var/run/docker.sock

RUN sed -i 's/nginx;/root;/g' /etc/nginx/nginx.conf
