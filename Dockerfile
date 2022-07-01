FROM amazonlinux:latest

MAINTAINER  1.0 purecap@sk.com 

# install cloudwatch agent
RUN yum install -y amazon-cloudwatch-agent
# install ps command
RUN yum install -y procps

# copy cloudwatch agent custom config for log monitoring
COPY ./amazon-cloudwatch-agent.toml  /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml
COPY ./env-config.json /opt/aws/amazon-cloudwatch-agent/etc/env-config.json

# copy application script 

# sample log data writing script
COPY ./write_log.sh write_log.sh
RUN  chmod 755 /write_log.sh

# main script
COPY ./run_apps_script.sh run_apps_script.sh
RUN  chmod 755 /run_apps_script.sh

# ENTRYPOINT
ENTRYPOINT /run_apps_script.sh
