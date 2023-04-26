#！/bin/bash

nohup java -cp .:./lib/netty-all-4.1.42.Final.jar Server service >/app/nohup.out 2>&1 &
service tinyproxy start
tail -f /app/nohup.out
