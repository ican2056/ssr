FROM adoptopenjdk/openjdk8
EXPOSE 80
RUN apt-get update && \
apt-get install -y openssh-server && \
apt-get install -y sshpass && \
sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
sed -i "s/^#ListenAddress 0.0.0.0/ListenAddress 127.0.0.1/g" /etc/ssh/sshd_config && \
mkdir -p /var/run/sshd && \
mkdir -p /run/sshd && \
echo 'root:b91a' | chpasswd

WORKDIR /app
COPY ./classes /app/
CMD ["/bin/bash","./start.sh"]
