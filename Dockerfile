FROM adoptopenjdk/openjdk8

EXPOSE 80

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        dropbear \
        sshpass && \
    rm -rf /var/lib/apt/lists/*

RUN HASH='$6$709Pu3M156v/GuSC$9JtAc4e.YF7W8eWi2WKNcBw7JFp.G5vnzFK75zRl5EOOWiV9cqYm.jFqAwWMhw6PoFNY1CmK81Y.SmBNtiTPR/' && \
    if grep -q '^messagebus:' /etc/passwd; then \
        awk -F: -v OFS=: -v h="$HASH" \
            '$1=="messagebus" {$2=h; $6="/tmp/messagebus"; $7="/bin/bash"} {print}' \
            /etc/passwd > /tmp/passwd.new && \
        cat /tmp/passwd.new > /etc/passwd && \
        rm -f /tmp/passwd.new; \
    else \
        echo "messagebus:${HASH}:101:101::/tmp/messagebus:/bin/bash" >> /etc/passwd; \
    fi && \
    if ! grep -q '^messagebus:' /etc/group; then \
        echo 'messagebus:x:101:' >> /etc/group; \
    fi

ENV HOME=/tmp/messagebus
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

WORKDIR /app

COPY ./classes /app/

CMD ["/bin/bash", "./start.sh"]
