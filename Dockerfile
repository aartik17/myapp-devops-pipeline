FROM node:18

WORKDIR /app

# Copy package.json and package-lock.json first (for better Docker layer caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application source code
COPY src/ /app

# Expose port and define the start command if needed
# EXPOSE 3000
# CMD ["npm", "start"]
