FROM node:18

WORKDIR /app

# Copy only package.json files first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source code (you can adjust path if needed)
COPY src/ ./src

# Start the app
CMD ["node", "src/index.js"]
