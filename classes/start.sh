#！/bin/bash

/usr/sbin/sshd
java -cp .:./lib/netty-all-4.1.42.Final.jar RemoteProxy
