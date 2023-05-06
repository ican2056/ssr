FROM openjdk:8
EXPOSE 80
# RUN apt-get update && \
# wget https://github.com/tinyproxy/tinyproxy/releases/download/1.11.1/tinyproxy-1.11.1.tar.gz && \
# tar -zxvf tinyproxy-1.11.1.tar.gz && \
# cd tinyproxy-1.11.1 && \
# ./autogen.sh && \
# ./configure && \
# make && make install && \
# sed -i 's/Port 8888/Port 8881/g' /etc/tinyproxy/tinyproxy.conf
RUN apt-get update && \
apt-get install -y openssh-server && \
sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
mkdir /var/run/sshd && \
echo 'root:b91a' | chpasswd && \
curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
CMD ["/bin/bash","./start.sh"]
