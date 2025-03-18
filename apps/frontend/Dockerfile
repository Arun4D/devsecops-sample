### STAGE 1: BUILD ###
# Use Node.js 18.19.0 Alpine as the base image for the build stage
FROM node:18.19.0-alpine AS build

# Create a working directory inside the container
WORKDIR /workspace/app/frontend/kpi-dashboard/

# Clean the npm cache
RUN npm cache clean --force

# Copy the application code into the container
COPY kpi-dashboard .

# Install dependencies (excluding dev dependencies) and build the application
RUN npm install --omit=dev
RUN npm run build --prod


### STAGE 2: RUN ###
# Use the latest nginx image as the base image for the run stage
FROM nginx:latest AS ngi

# Copy the built application from the build stage to the nginx HTML directory
COPY --from=build /workspace/app/frontend/kpi-dashboard/dist/kpi-dashboard /usr/share/nginx/html

# Copy the nginx configuration file
COPY /nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the nginx server
EXPOSE 80