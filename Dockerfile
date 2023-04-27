FROM openjdk:8
RUN apt-get update && \
apt-get install -y systemctl && \
apt-get install -y squid && \
rm /lib/systemd/system/squid.service
# curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
EXPOSE 80
CMD ["/bin/bash","./start.sh"]
