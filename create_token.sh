#!/bin/bash
MASTER=$(puppet config print certname)

if [ ! -d "/root/.puppetlabs" ]; then
  mkdir /root/.puppetlabs
fi

if [ ! -s "/root/.puppetlabs/token" ]; then
  TOKEN=`curl -s -k -X POST -H 'Content-Type: application/json' -d '{"login": "deploy", "password": "puppetlabs", "lifetime": "30d"}' https://${MASTER}:4433/rbac-api/v1/auth/token | python -c 'import sys, json; print json.load(sys.stdin)["token"]'`
  echo $TOKEN > /root/.puppetlabs/token
else
  echo "Token already exists"
fi
