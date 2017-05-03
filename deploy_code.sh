#!/bin/bash
MASTER=$(puppet config print certname)

curl -k -s -X POST -H 'Content-Type: application/json' -H "X-Authentication: `sudo cat /root/.puppetlabs/token`" https://${MASTER}:8170/code-manager/v1/deploys -d '{"deploy-all": true, "wait": true}'
