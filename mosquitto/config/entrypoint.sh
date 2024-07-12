#!/bin/sh
set -e

# Wait for config directory to be writable
until touch /mosquitto/config/.write_test 2>/dev/null; do
    echo "Waiting for /mosquitto/config to be writable..."
    sleep 1
done
rm /mosquitto/config/.write_test

# Create a password file
touch /mosquitto/config/pwfile

# Add user credentials to the password file
mosquitto_passwd -b /mosquitto/config/pwfile ${MQTT_USERNAME} ${MQTT_PASSWORD}

# Ensure correct permissions
chown -R mosquitto:mosquitto /mosquitto

# Start Mosquitto
exec "$@"