#！/bin/bash

java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService &
service tinyproxy start
tail -f nohup.out
