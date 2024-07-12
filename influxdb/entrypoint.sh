#!/bin/bash
set -e

# Start InfluxDB in the background
influxd &

# Wait for InfluxDB to be ready
for i in {1..30}; do
  if curl -s http://localhost:8086/health > /dev/null; then
    echo "InfluxDB is ready!"
    break
  fi
  echo "Waiting for InfluxDB to be ready... (attempt $i)"
  sleep 2
done

if [ $i -eq 30 ]; then
  echo "InfluxDB failed to start within 60 seconds"
  exit 1
fi

# Setup initial user, org, and bucket
influx setup --username ${INFLUXDB_USER} --password ${INFLUXDB_PASSWORD} --org myorg --bucket mybucket --force

# Generate API token
API_TOKEN=$(influx auth create --user ${INFLUXDB_USER} --org myorg --all-access --json | jq -r '.token')

# Export API token to a file that Node-RED can read
echo "INFLUXDB_TOKEN=${API_TOKEN}" > /shared/influxdb_token.env

# Keep the container running
tail -f /dev/null