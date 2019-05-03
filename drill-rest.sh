#!/bin/bash

#Create the Hive plugin:
curl --request POST \
  --url http://mdn:8047/storage/newplugin.json \
  --header 'Content-Type: application/json' \
  --data '{"name": "hive","config": {"type": "hive","enabled": true,"configProps": {"hive.metastore.uris": "thrift://hive:9083","javax.jdo.option.ConnectionURL": "jdbc:mysql://:3306;databaseName=../sample-data/drill_hive_db;create=true","hive.metastore.warehouse.dir": "/tmp/drill_hive_wh","fs.default.name": "file:///","hive.metastore.sasl.enabled": "false","datanucleus.schema.autoCreateAll": "true"}}}'

#Enable it:
curl --request GET \
  --url http://mdn:8047/storage/hive/enable/true

#Set drill opts:
curl --request POST \
  --url http://mdn:8047/query.json \
  --header 'Content-Type: application/json' \
  --data '    {"queryType" : "SQL","query" : "ALTER SYSTEM SET `planner.enable_decimal_data_type` = true"}'
