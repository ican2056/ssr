FROM ican2056/ssr:latest
EXPOSE 80

WORKDIR /app
CMD ["/bin/bash","./start.sh"]
