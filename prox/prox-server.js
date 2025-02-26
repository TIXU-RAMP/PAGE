const http = require('http');
const httpProxy = require('http-proxy');

const proxy = httpProxy.createProxyServer({});
const server = http.createServer((req, res) => {
  proxy.web(req, res, { target: 'http://example.com' });
});

server.listen(8000, () => {
  console.log('Proxy server is running on port 8000');
});
