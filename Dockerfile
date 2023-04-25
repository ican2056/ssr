FROM openjdk:8
WORKDIR /app

COPY classes /app/
EXPOSE 80
ENTRYPOINT [ "java", "-cp", ".:./lib/*.jar", "ServerService"]
