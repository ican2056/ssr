#！/bin/bash

nohup java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService 2>&1 &
service tinyproxy start
tail -f nohup.out
