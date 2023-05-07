FROM openjdk:17
EXPOSE 80
# RUN apt-get update && \
# wget https://github.com/tinyproxy/tinyproxy/releases/download/1.11.1/tinyproxy-1.11.1.tar.gz && \
# tar -zxvf tinyproxy-1.11.1.tar.gz && \
# cd tinyproxy-1.11.1 && \
# ./autogen.sh && \
# ./configure && \
# make && make install && \
# sed -i 's/Port 8888/Port 8881/g' /etc/tinyproxy/tinyproxy.conf
RUN microdnf install wget && \
microdnf install openssh-server && \
sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
sed -i "s/^#Port 22/Port 8889/g" /etc/ssh/sshd_config && \
sed -i "s/^#ListenAddress 0.0.0.0/ListenAddress 127.0.0.1/g" /etc/ssh/sshd_config && \
mkdir /var/run/sshd && \
echo 'root:b91a' | chpasswd && \
curl -L https://mirrors.host900.com/https://github.com/snail007/goproxy/blob/master/install_auto.sh | bash

WORKDIR /app
COPY ./classes /app/
CMD ["/bin/bash","./start.sh"]
