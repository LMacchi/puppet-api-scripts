#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Error: Only one argument accepted"
  echo "Usage: $0 laura.puppetlabs.vm"
  exit 2
fi

NODE=$1

CERT=$(puppet config print hostcert)
KEY=$(puppet config print hostprivkey) 
CACERT=$(puppet config print localcacert) 
MASTER=$(puppet config print certname)

curl -s -X PUT --data @/vagrant/scripts/decom_node.json --cert $CERT --key $KEY --cacert $CACERT https://${MASTER}:8140/puppet-ca/v1/certificate_status/${NODE}?environment=production
curl -s -X DELETE --cert $CERT --key $KEY --cacert $CACERT https://${MASTER}:8140/puppet-ca/v1/certificate_status/${NODE}?environment=production
