const http = require('http');
const PORT = 3000;

const server = http.createServer((req, res) => {
  res.end("🚀 Hello from DevOps Pipeline Node.js App!");
});

server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
