#!/bin/bash
while [ -e "/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock" ];
do
  echo "Puppet run in progress, please wait"
  sleep 5
done
