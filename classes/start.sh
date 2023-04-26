#！/bin/bash

nohup java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService >/app/nohup.out 2>&1 &
sed -i 's/#Listen 192.168.0.1/Listen 127.0.0.1/g' /etc/tinyproxy/tinyproxy.conf
#service tinyproxy start
tail -f /dev/null
