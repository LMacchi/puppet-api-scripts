#!/bin/bash
CERT=$(puppet config print hostcert)
KEY=$(puppet config print hostprivkey) 
CACERT=$(puppet config print localcacert) 
MASTER=$(puppet config print certname)

curl -s -X POST --data @/vagrant/scripts/user_deploy.json -H "Content-Type: application/json" --cert $CERT --key $KEY --cacert $CACERT https://${MASTER}:4433/rbac-api/v1/users
