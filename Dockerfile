FROM adoptopenjdk/openjdk8
EXPOSE 80
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dropbear sshpass && \
    echo 'root:b91a' | chpasswd && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY ./classes /app/
USER root
CMD ["/bin/bash", "./start.sh"]
