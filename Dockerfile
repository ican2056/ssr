FROM adoptopenjdk/openjdk8

USER root

EXPOSE 80

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        dropbear \
        sshpass \
        passwd && \
    rm -rf /var/lib/apt/lists/*

# 确认镜像中确实存在 messagebus
RUN id messagebus

# 设置可用的 HOME 和登录 Shell
RUN usermod -d /tmp/messagebus -s /bin/bash messagebus

# 先正常设置密码到 /etc/shadow
RUN echo 'messagebus:b91a' | chpasswd

# 非 root Dropbear 无权读取 /etc/shadow，
# 因此构建阶段把密码哈希复制到 /etc/passwd
RUN HASH="$(awk -F: '$1=="messagebus" {print $2}' /etc/shadow)" && \
    test -n "$HASH" && \
    test "$HASH" != "!" && \
    test "$HASH" != "*" && \
    awk -F: -v OFS=: -v h="$HASH" \
        '$1=="messagebus" {$2=h; $6="/tmp/messagebus"; $7="/bin/bash"} {print}' \
        /etc/passwd > /tmp/passwd.new && \
    cat /tmp/passwd.new > /etc/passwd && \
    rm -f /tmp/passwd.new

ENV HOME=/tmp/messagebus
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

WORKDIR /app

COPY ./classes /app/

CMD ["/bin/bash", "./start.sh"]
