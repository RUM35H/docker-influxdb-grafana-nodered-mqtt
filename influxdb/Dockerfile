FROM influxdb:2.7.6

# Install necessary tools
RUN apt-get update && apt-get install -y curl jq

# Copy the entrypoint script
COPY influxdb/entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set the default command
CMD ["influxd"]
