#!/bin/bash
#
# This file was auto-generated by gen-all-dockerfiles.sh; do not modify manually.
#
# ./common-services-wso2ext/docker-entrypoint.sh
#

if [ -z "$MSB_ADDR" ]; then
    echo "Missing required variable MSB_ADDR: Microservices Service Bus address <ip>:<port>"
    exit 1
fi

# Wait for MSB initialization
echo Wait for MSB initialization
for i in {1..20}; do
    curl -sS -m 1 $MSB_ADDR > /dev/null && break
    sleep $i
done

# Configure service based on docker environment variables
./instance-config.sh

# Start mysql
su mysql -c /usr/bin/mysqld_safe &

# Perform one-time config
if [ ! -e init.log ]; then
    # Perform workarounds due to defects in release binary
    ./instance-workaround.sh

    # Init mysql; set root password
    ./init-mysql.sh

    # microservice-specific one-time initialization
    ./instance-init.sh

    date > init.log
fi

# Start the microservice
./instance-run.sh

