FROM ican2056/ssr:latest
EXPOSE 80

WORKDIR /app
USER root
CMD ["/bin/bash","./start.sh"]
