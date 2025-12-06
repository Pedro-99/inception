#!/bin/bash

set -e

# Substitute environment variables in the nginx template
envsubst '${DOMAIN_NAME} ${NGINX_PORT} ${WORDPRESS_PORT}' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf

# Start nginx in foreground
exec nginx -g 'daemon off;'
