# Use the official Nginx image as a base
# We'll use nginx:stable-alpine as it's a lightweight distribution
# for production environments. If you prefer a full Debian-based image,
# use 'nginx:latest' or 'nginx:stable'.
FROM nginx:stable-alpine

# MAINTAINER (optional, but good practice for who maintains the image)
LABEL maintainer="Wing Cheung Ma wingcheungma@gmail.com"

# Copy your custom Nginx configuration file
# This assumes you have a custom nginx.conf in the same directory as your Dockerfile.
# If you don't need a custom config, you can remove this line.
# By default, Nginx looks for its main config at /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Remove the default Nginx index.html and related files from the image
# This ensures our custom content is served without conflicts.
RUN rm -rf /usr/share/nginx/html/*

# Copy your static website content into the Nginx web root directory
# The default web root for Nginx on most official images is /usr/share/nginx/html
COPY html/ /usr/share/nginx/html/

# Expose port 80. This tells Docker that the container listens on the specified network ports
# at runtime. It's informational and doesn't publish the port.
EXPOSE 80

# The default Nginx CMD is already set in the base image:
# CMD ["nginx", "-g", "daemon off;"]
# This command starts Nginx in the foreground, which is necessary for Docker containers
# so the container doesn't exit immediately after starting.
# You typically don't need to explicitly define CMD unless you want to override it.
