FROM openjdk:8
RUN apt-get update && \
apt-get install squid && \
sed -i 's/http_access deny all/http_access allow all/g' /etc/squid/squid.conf
# curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
EXPOSE 80
CMD ["/bin/bash","./start.sh"]
