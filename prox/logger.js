const fs = require('fs');

function logRequest(req) {
  const log = `${new Date().toISOString()} - ${req.method} ${req.url}\n`;
  fs.appendFileSync('requests.log', log);
}

module.exports = { logRequest };
