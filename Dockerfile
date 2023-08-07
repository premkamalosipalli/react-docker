FROM node:16 AS build

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]

RUN npm install

COPY . .

RUN npm run build

# Start the Node.js application (replace with your actual start command)
CMD ["npm", "start"]


# Stage 2: Create the final image with Nginx
FROM nginx:latest

# Copy the build output from the first stage into the Nginx image
COPY --from=build ./app/dist /usr/share/nginx/html

# Copy your custom nginx.config if needed
COPY nginx.config /etc/nginx/nginx.conf

# Expose port 80 to serve the application
EXPOSE 8005

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]