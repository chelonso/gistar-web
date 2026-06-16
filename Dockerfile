FROM nginx:alpine

# Copy custom Nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy static website files to match the root in Nginx configuration
COPY . /var/www/html/web

# Expose ports 80 and 443
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
