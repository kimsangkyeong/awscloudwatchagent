#!/bin/bash

#-------  Cloudwatch Log Agent START ------------
# set aws cloudwatch agent config
sed -i 's/replace_file_logstream_1/'`echo $HOSTNAME`'/' /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml
sed -i 's/replace_app_logfile_1/\/var\/log\/apps\/eai*/' /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml
sed -i 's/replace_region/us-east-1/' /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml

# set aws cloudwatch agent environment
export RUN_IN_CONTAINER="True"

# start up amazon-cloudwatch-agent in the background
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent -config /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml -envconfig /opt/aws/amazon-cloudwatch-agent/etc/env-config.json &

#-------  Cloudwatch Log Agent  END ------------

# start up apps
/write_log.sh &

# Wait for any process to exit
wait 

# Exit with status of process that exited first
exit $?
