FROM openjdk:8
EXPOSE 80
RUN apt-get update && \
apt-get install -y tinyproxy
# curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
CMD ["/bin/bash","./start.sh"]
