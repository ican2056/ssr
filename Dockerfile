FROM openjdk:8
WORKDIR /app

COPY ./classes /app/
EXPOSE 80
CMD ["/bin/bash","./start.sh"]
