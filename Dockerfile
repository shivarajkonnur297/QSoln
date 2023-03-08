# Use an official Node.js runtime as a parent image
FROM node:14-alpine as build

# Set the working directory to /app
WORKDIR /app

# Copy the rest of the application code to the working directory
COPY . .

# Install Node.js dependencies
RUN npm install

# Build the ReactJS application
RUN npm run build

# Use an official Nginx runtime as a parent image
FROM nginx:stable-alpine

# Copy the ReactJS application from the build stage to the Nginx web server directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for incoming traffic
EXPOSE 80

# Start Nginx and keep the container running in the foreground
CMD ["nginx", "-g", "daemon off;"]
