#!/bin/bash

# Exit on error, debug output, fail on pipe errors
set -e
set -x
set -o pipefail

# Trap cleanup to ensure child processes are terminated
trap 'trap - SIGTERM && kill -- -$$' SIGINT SIGTERM EXIT

# Function to handle postgres port-forwarding
postgres() {
    while true; do
        kubectl -n postgres port-forward svc/postgres-db-rw 5432 || true
        echo "Postgres port-forward failed, restarting in 2 seconds..." >&2
        sleep 2
    done
}

# Function to handle tempo port-forwarding
tempo() {
    while true; do
        kubectl -n monitoring port-forward svc/tempo 4317 || true
        echo "Tempo port-forward failed, restarting in 2 seconds..." >&2
        sleep 2
    done
}

# Start port forwards in background
postgres &
tempo &

echo "Port forwarding active:"
echo "  - Postgres on localhost:5432"
echo "  - Tempo on localhost:4317"
echo "Press CTRL-C to stop port forwarding and exit the script"

# Wait for all background processes
wait
