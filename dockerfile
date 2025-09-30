# Stage 1: Serve with Nginx
FROM nginx:alpine

# Copy built Angular app from Jenkins workspace
WORKDIR /usr/share/nginx/html
COPY dist/kubernetTestApp/browser ./  

# Copy custom Nginx config (for Angular routing support)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
