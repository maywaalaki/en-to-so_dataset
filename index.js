const express = require('express');
const request = require('request');
const SocksProxyAgent = require('socks-proxy-agent'); // Hubi in magacani sax yahay
const app = express();

const proxy = 'socks5://127.0.0.1:40001';
const agent = new SocksProxyAgent(proxy);

app.get('/proxy', (req, res) => {
    const url = req.query.url;
    if (!url) return res.status(400).send('URL is required');

    request({ url, agent }).pipe(res);
});

app.listen(8080, () => console.log('Server is running on port 8080'));
