#!/bin/bash

#Change the default admin password
curl --request PUT \
  --url http://localhost:7070/kylin/api/kap/user/ADMIN \
  --header 'Accept: application/vnd.apache.kylin-v2+json' \
  --header 'Accept-Language: en' \
  --header 'Authorization: Basic QURNSU46S1lMSU4=' \
  --header 'Content-Type: application/json;charset=utf-8' \
  --header 'cache-control: no-cache' \
  --data '{\n  "password": "Password1!",\n  "disabled": false,\n  "authorities": ["ROLE_ADMIN","ALL_USERS"]\n\n}'

#Kick off the build job
curl --request PUT \
  --url http://localhost:7070/kylin/api/cubes/kylin_sales_cube/segments/build \
  --header 'Accept: application/vnd.apache.kylin-v2+json' \
  --header 'Accept-Language: en' \
  --header 'Authorization: Basic QURNSU46UGFzc3dvcmQxIQ==' \
  --header 'Content-Type: application/json;charset=utf-8' \
  --header 'cache-control: no-cache' \
  --data '{\n    "startTime": 0,\n    "endTime": 0,\n    "buildType": "BUILD"\n}'
