#！/bin/bash

/usr/sbin/sshd
java \
  -Xms256m \
  -Xmx384m \
  -XX:MaxMetaspaceSize=96m \
  -XX:MaxDirectMemorySize=64m \
  -XX:ReservedCodeCacheSize=64m \
  -Xss512k \
  -cp .:./lib/netty-all-4.1.42.Final.jar \
  RemoteProxy
