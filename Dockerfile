# Tiny, non-root nginx serving on 8080
FROM nginx:alpine

# Drop default content
RUN rm -rf /usr/share/nginx/html/*

# Copy our site
COPY site/ /usr/share/nginx/html/

# Harden a bit: custom config, non-root port
COPY nginx.conf /etc/nginx/nginx.conf

RUN rm -rf /etc/nginx/templates/*

# Health check (K8s will still probe via HTTP)
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://localhost:8080/ >/dev/null 2>&1 || exit 1

