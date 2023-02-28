FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Create a self-signed SSL certificate for the domain "rvrignon"
COPY tools/rvrignon.42.fr.crt tools/rvrignon.42.fr.key /etc/nginx/ssl/

# Configure Nginx to use the SSL certificate
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Expose port 443 for HTTPS connections
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
