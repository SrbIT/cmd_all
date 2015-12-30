#!/bin/bash

rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install -y supervisor 

mkdir -p /opt/src && cd /opt/src

wget http://mirrors.viethosting.vn/apache/kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz

tar -zxvf kafka_2.11-0.9.0.0.tgz

wget http://mirrors.viethosting.vn/apache/zookeeper/zookeeper-3.4.7/zookeeper-3.4.7.tar.gz

tar -zxvf zookeeper-3.4.7.tar.gz

wget http://mirrors.viethosting.vn/apache/storm/apache-storm-0.10.0/apache-storm-0.10.0.tar.gz

tar -xzvf apache-storm-0.10.0.tar.gz

useradd elasticsearch

wget https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.1/elasticsearch-2.1.1.tar.gz

tar -zxvf elasticsearch-2.1.1.tar.gz

chown -R elasticsearch:elasticsearch /opt/src/elasticsearch-2.1.1

wget https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz

tar -zxvf kibana-4.3.1-linux-x64.tar.gz

mkdir -p /opt/src/src_bin && cd /opt/src/ && mv *gz /opt/src/src_bin/

cp /opt/src/zookeeper-3.4.7/conf/zoo_sample.cfg /opt/src/zookeeper-3.4.7/conf/zoo.cfg

mkdir -p /opt/src/logs_src/

echo "# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just
# example sakes.
dataDir=/opt/src/logs_src/zookeeper
# the port at which the clients will connect
clientPort=2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the
# administrator guide before turning on autopurge.
#
# http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1" > /opt/src/zookeeper-3.4.7/conf/zoo.cfg

echo "[program:nimbus]
command=/opt/src/apache-storm-0.10.0/bin/storm nimbus
autostart=true

[program:ui]
command=/opt/src/apache-storm-0.10.0/bin/storm ui
autostart=true

[program:drpc]
command=/opt/src/apache-storm-0.10.0/bin/storm drpc
autostart=true

[program:s]
command=/opt/src/apache-storm-0.10.0/bin/storm supervisor
autostart=true

[program:logviewer]
command=/opt/src/apache-storm-0.10.0/bin/storm logviewer
autostart=true" >> /etc/supervisord.conf

cp /opt/src/apache-storm-0.10.0/conf/storm.yaml /opt/src/apache-storm-0.10.0/conf/storm.yaml.bk

echo "storm.zookeeper.servers:
    - "localhost"
#
storm.local.dir: "/opt/src/apache-storm-0.10.0"
# nimbus.host: "nimbus"
nimbus.host: "localhost"
supervisor.slots.ports:
    - 6700
    - 6701
    - 6702
    - 6703
    - 6704
drpc.servers:
    - "localhost"" > /opt/src/apache-storm-0.10.0/conf/storm.yaml

