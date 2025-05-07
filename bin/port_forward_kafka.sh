#!/bin/bash

set -e
set -x
set -o pipefail

kubectl -n kafka port-forward svc/kafka 9092 

echo "Press CTRL-C to stop port forwarding and exit the script"
wait
