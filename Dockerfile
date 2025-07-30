FROM node:18

WORKDIR /app

# Copy package.json separately for better layer caching
COPY src/package*.json ./

# Install dependencies
RUN npm install

# Copy app source code
COPY src/ .

# Expose and run
EXPOSE 3000
CMD ["node", "index.js"]
