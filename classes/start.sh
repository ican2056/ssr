#！/bin/bash

#nohup python3 -m http.server 8882 &
#sed -i 's/Port 8888/Port 8881/g' /etc/tinyproxy/tinyproxy.conf
#sed -i 's/#Listen 192.168.0.1/Listen 127.0.0.1/g' /etc/tinyproxy/tinyproxy.conf
#tinyproxy -c /etc/tinyproxy/tinyproxy.conf
#proxy http -t tcp -p "0.0.0.0:8888" --daemon
iptables -S
proxy socks -t tcp -p "127.0.0.1:8888" --daemon
/usr/sbin/sshd
# service squid stop
# sed -i 's/http_access deny all/http_access allow all/g' /etc/squid/squid.conf
# service squid restart
# tinyproxy -c /etc/tinyproxy/tinyproxy.conf
sshpass -p 'b91a' ssh -o "StrictHostKeyChecking no" -p 8889 -N -D 127.0.0.1:7889 root@::1 &
java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService
#service squid restart

#nohup java -cp .:./lib/netty-all-4.1.42.Final.jar ServerService >/app/nohup.out 2>&1 &
#sed -i 's/#Listen 192.168.0.1/Listen 127.0.0.1/g' /etc/tinyproxy/tinyproxy.conf
#service tinyproxy start
#tail -f /dev/null
