FROM consul

ADD start.sh /start.sh

RUN chmod +x /start.sh

CMD [ "/start.sh" ]

# path/key:path/file,...
ENV CONSUL_KEYFILE ""

#get or put
ENV CONSUL_OPT get

# interval second
ENV CONSUL_INTERVAL 60