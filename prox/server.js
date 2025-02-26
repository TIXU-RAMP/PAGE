const express = require('express');
const httpProxy = require('http-proxy');
const app = express();
const proxy = httpProxy.createProxyServer({});

app.use(express.static('public'));

app.get('/proxy', (req, res) => {
  const target = req.query.url;
  proxy.web(req, res, { target });
});

app.listen(8000, () => {
  console.log('Server running on port 8000');
});
