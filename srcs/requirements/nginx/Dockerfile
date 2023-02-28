FROM debian:buster

# Install packages required for Nginx
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Copy Nginx configuration file
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Expose port 443 for HTTPS connections
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
