FROM docker:dind

ADD start.sh /start.sh

RUN chmod +x /start.sh  && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk --update add --no-cache

ENV REGISTRY ""

ENV USERNAME ""

ENV PASSWORD ""

ENV IMAGES ""

CMD [ "/start.sh" ]