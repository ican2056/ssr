#！/bin/bash

apt-get update
apt-get install tinyproxy -y
service tinyproxy start

java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService
