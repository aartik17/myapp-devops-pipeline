FROM node:18

WORKDIR /app
COPY src/ /app
RUN npm install

EXPOSE 3000
CMD ["node", "index.js"]
