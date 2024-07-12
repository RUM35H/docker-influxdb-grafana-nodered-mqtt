FROM eclipse-mosquitto:latest

# Copy the configuration file
COPY mosquitto/config/mosquitto.conf /mosquitto/config/mosquitto.conf

# Copy the entrypoint script
COPY mosquitto/config/entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set the default command
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]