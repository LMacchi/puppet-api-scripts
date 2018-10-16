#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 certname"
  exit 2
fi

NODE=$1
CERT=$(/opt/puppetlabs/puppet/bin/puppet config print hostcert)
KEY=$(/opt/puppetlabs/puppet/bin/puppet config print hostprivkey)
CACERT=$(/opt/puppetlabs/puppet/bin/puppet config print localcacert)
MASTER=$(/opt/puppetlabs/puppet/bin/puppet config print certname)

RESPONSE=`curl -s -X GET --cert $CERT --key $KEY --cacert $CACERT https://${MASTER}:8081/pdb/query/v4/catalogs/${NODE}/resources`
if [[ $? -ne 0 ]]; then
  echo $RESPONSE
else
  echo $RESPONSE | python -m json.tool
fi

exit 0
