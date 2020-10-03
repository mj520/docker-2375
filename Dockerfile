FROM alpine

ADD start.sh /start.sh

RUN chmod +x /start.sh  && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk --update add --no-cache && apk add --no-cach curl

CMD [ "/start.sh" ]

# path/key:path/file,...
ENV CONSUL_KEYFILE ""

#get or put
ENV CONSUL_OPT get

# interval second
ENV CONSUL_INTERVAL 60

ENV CONSUL_HTTP_ADD http://consul:8500