### STAGE 1: BUILD ###
# Use Node.js 18-alpine as the base image for the build stage
FROM node:18-alpine AS build

# Create a working directory inside the container
WORKDIR /workspace/app/frontend/kpi-dashboard/

# Clean the npm cache
RUN npm cache clean --force

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Copy the application code into the container
COPY kpi-dashboard .

# Install dependencies (excluding dev dependencies) and build the application
RUN npm install
RUN npm run build  --omit=dev



### STAGE 2: RUN ###
# Use the nginx:alpine image as the base image for the run stage
FROM nginx:alpine AS ngi

# Remove unnecessary packages to reduce vulnerabilities
RUN apk del libaom3 libexpat1 libldap-2.5-0 libtiff6 libxml2 libxslt1.1 perl-base zlib1g

# Copy the built application from the build stage to the nginx HTML directory
COPY --from=build /workspace/app/frontend/kpi-dashboard/dist/kpi-dashboard /usr/share/nginx/html

# Copy the nginx configuration file
COPY /nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the nginx server
EXPOSE 80