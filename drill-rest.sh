#!/bin/bash



curl --request POST \
  --url http://dsr-demo-s69kky.se.corp.maprtech.com:8047/query.json \
  --header 'Content-Type: application/json' \
  --data '    {"queryType" : "SQL","query" : "ALTER SYSTEM SET `planner.enable_decimal_data_type` = true"}'
