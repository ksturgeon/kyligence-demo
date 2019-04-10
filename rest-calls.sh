#!/bin/bash

#Change the default admin password
curl --request PUT \
  --url http://localhost:7070/kylin/api/kap/user/ADMIN \
  --header 'Accept: application/vnd.apache.kylin-v2+json' \
  --header 'Accept-Language: en' \
  --header 'Authorization: Basic QURNSU46S1lMSU4=' \
  --header 'Content-Type: application/json;charset=utf-8' \
  --header 'cache-control: no-cache' \
  --data '{"password": "Password1!","disabled": false,"authorities": ["ROLE_ADMIN","ALL_USERS"]}'

#Kick off the build job
curl --request PUT \
  --url http://localhost:7070/kylin/api/cubes/kylin_sales_cube/segments/build \
  --header 'Accept: application/vnd.apache.kylin-v2+json' \
  --header 'Accept-Language: en' \
  --header 'Authorization: Basic QURNSU46UGFzc3dvcmQxIQ==' \
  --header 'Content-Type: application/json;charset=utf-8' \
  --header 'cache-control: no-cache' \
  --data '{"startTime": 0,"endTime": 0,"buildType": "BUILD"}'
