#!/bin/bash
# We need to ensure that the cluster is up and running before we start executing any scripts to setup a demo.
# Below loads all of the default "MapR" enviroment variables for the SE Demo cluster.
source /opt/mapr/docker/start-env.sh
# By default our enviroment variables do not have our MCS port.
MCS_PORT=${MCS_PORT:-8443}
MCS_URL="https://${MCS_HOST}:${MCS_PORT}"
echo ""
echo "MapR JOB script executing for demo, Centralized Historian."
echo ""
chk_str="Waiting ..."
# Check that the CLDB is up and running.
check_cluster(){
        find_cldb="curl -sSk -u ${MAPR_ADMIN}:${MAPR_ADMIN_PASS} ${MCS_URL}/rest/node/cldbmaster"
        if [ "$($find_cldb | jq -r '.status')" = "OK" ]; then
                return 0
        else
                echo "Connected to $MCS_URL, Waiting for CLDB Master to be Ready..."
                return 1
        fi
}
until check_cluster; do
    echo "$chk_str"
    sleep 10
done
echo "CLDB Master is ready, continuing startup for $MAPR_CLUSTER ..."

# YOUR DEMO CODE STARTS HERE
# Put your customer demo stuff below this line to continue to be executed or in the "demo" directory under customer-jobs.sh

# Simple test to list volume informaiton over REST API - This is a code place to start putting your code, hint, hint.
curl -sSk -X POST -u ${MAPR_ADMIN}:${MAPR_ADMIN_PASS} ""${MCS_URL}/rest/volume/list"" >> ~/test.json

# You should always end with a good exit :)
exit 0