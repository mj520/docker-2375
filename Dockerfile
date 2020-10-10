FROM alpine

ADD start.sh /start.sh

RUN chmod +x /start.sh  && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk --update add --no-cache && apk add --no-cach curl

ENV PLUGIN_API ""

ENV PLUGIN_TOKEN ""

CMD [ "/start.sh" ]