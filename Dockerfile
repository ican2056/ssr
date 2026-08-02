FROM adoptopenjdk/openjdk8

EXPOSE 80

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        dropbear \
        sshpass && \
    echo 'messagebus:b91a' | chpasswd && \
    HASH="$(awk -F: '$1=="messagebus" {print $2}' /etc/shadow)" && \
    awk -F: -v OFS=: -v h="$HASH" \
        '$1=="messagebus" {$2=h; $6="/tmp/messagebus"; $7="/bin/bash"} {print}' \
        /etc/passwd > /tmp/passwd.new && \
    cat /tmp/passwd.new > /etc/passwd && \
    rm -f /tmp/passwd.new && \
    rm -rf /var/lib/apt/lists/*

ENV HOME=/tmp/messagebus
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

WORKDIR /app

COPY ./classes /app/

CMD ["/bin/bash", "./start.sh"]
