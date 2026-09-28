# Use the official Ubuntu LTS base image for stability
FROM ubuntu:26.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update repository package list and install shellinabox in a single layer
# Clean up apt caches afterwards to keep the image size minimal
RUN apt-get update && \
    apt-get install -y --no-install-recommends shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the root password (change 'root' to a secure password in production)
RUN echo 'root:ejax' | chpasswd

# Expose the default port used by ShellInABox
EXPOSE 4200

# Start ShellInABox in plain HTTP mode (-t) using default login prompt (-s /:LOGIN)
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
