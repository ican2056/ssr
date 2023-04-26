#！/bin/bash

nohup java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService 2>&1 &
service tinyproxy start
sleep 10
tail -f nohup.out
