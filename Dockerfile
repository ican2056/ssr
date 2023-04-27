FROM openjdk:8
RUN apt-get update && \
apt-get install squid && \
perl -p -i -e 's/http_access deny all/http_access allow all/' /etc/squid/squid.conf
# curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
EXPOSE 80
CMD ["/bin/bash","./start.sh"]
