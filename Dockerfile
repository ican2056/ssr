FROM openjdk:8
WORKDIR /app

COPY ./classes /app/
EXPOSE 80
ENTRYPOINT [ "java", "-cp", ".:./lib/netty-all-4.1.42.Final.jar", "ServerService"]
