#!/bin/bash

#Copy kyligence tarball from public data
sudo tar -zxvf /public_data/kyligence/install/Kyligence-Enterprise-3.2.2.2028-GA-mapr.tar.gz -C /opt/
sudo chown -R mapr:mapr /opt/Kyligence-Enterprise-3.2.2.2028-GA-mapr

#Create prereqs
echo "KYLIN_HOME=/opt/Kyligence-Enterprise-3.2.2.2028-GA-mapr" >> ~/.bashrc
echo "SPARK_HOME=/opt/mapr/spark/spark-2.2.1" >> ~/.bashrc
echo "KAFKA_HOME=/opt/mapr/kafka/kafka-1.0.1" >> ~/.bashrc
export KYLIN_HOME=/opt/Kyligence-Enterprise-3.2.2.2028-GA-mapr
export SPARK_HOME=/opt/mapr/spark/spark-2.2.1
export KAFKA_HOME=/opt/mapr/kafka/kafka-1.0.1
hadoop fs -mkdir /kylin
hadoop fs -chown mapr /kylin

#Set up the "minimal" perf profile:
rm -f $KYLIN_HOME/conf/profile
ln -sfn $KYLIN_HOME/conf/profile_min $KYLIN_HOME/conf/profile

#Copy our fixed-up kylin_hive_conf.xml
mv $KYLIN_HOME/conf/kylin_hive_conf.xml $KYLIN_HOME/conf/bak.kylin_hive_conf.xml
cp mapr_kylin_hive_conf.xml $KYLIN_HOME/conf/kylin_hive_conf.xml

#Add properties
echo "kylin.env.zookeeper-connect-string=mapr-zk:5181" >> $KYLIN_HOME/conf/kylin.properties
echo "kylin.env.hdfs-working-dir=maprfs:///kylin" >> $KYLIN_HOME/conf/kylin.properties
echo "kylin.metadata.url=kylin@jdbc,url=jdbc:mysql://mysqldb:3306/kylin?createDatabaseIfNotExist=true,username=root,password=ChangeMe!,passwordEncrypted=false,maxActive=40,maxIdle=10,driverClassName=com.mysql.jdbc.Driver" >> $KYLIN_HOME/conf/kylin.properties
echo "kylin.engine.spark-conf.spark.eventLog.dir=maprfs:///kylin/spark-history" >> $KYLIN_HOME/conf/kylin.properties
echo "kylin.engine.spark-conf.spark.history.fs.logDirectory=maprfs:///kylin/spark-history" >> $KYLIN_HOME/conf/kylin.properties
echo "kap.storage.init-spark-at-starting=true" >> $KYLIN_HOME/conf/kylin.properties

#Load sample data
source $KYLIN_HOME/bin/sample.sh

#Load yelp tables into hive
hive -f hive-table-setup.sql

#Start Server
source $KYLIN_HOME/bin/kylin.sh start

