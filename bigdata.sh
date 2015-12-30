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
