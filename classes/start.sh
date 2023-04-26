#！/bin/bash

#nohup java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService >/app/nohup.out 2>&1 &
service tinyproxy start
cat /etc/tinyproxy/tinyproxy.conf
tail -f /dev/null
