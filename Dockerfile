FROM openjdk:8
RUN apt-get update \
&& apt-get install tinyproxy -y

WORKDIR /app
COPY ./classes /app/
EXPOSE 80
CMD ["/bin/bash","./start.sh"]
