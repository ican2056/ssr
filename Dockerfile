FROM openjdk:8
EXPOSE 80
RUN apt-get update && \
apt-get install -y tinyproxy && \
sed -i 's/Port 8888/Port 8881/g' /etc/tinyproxy/tinyproxy.conf
# curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
CMD ["/bin/bash","./start.sh"]
