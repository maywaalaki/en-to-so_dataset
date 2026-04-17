const express = require('express');
const request = require('request');
const SocksProxyAgent = require('socks-proxy-agent');
const app = express();

const proxy = 'socks5://127.0.0.1:40001';
const agent = new SocksProxyAgent(proxy);

app.get('/proxy', (req, res) => {
    const url = req.query.url;
    if (!url) return res.status(400).send('No URL provided');

    // Tani waxay YouTube u tusaysaa IP-ga Cloudflare
    request({ url, agent }).pipe(res);
});

app.listen(8000, () => console.log('Proxy Bridge Active on Port 8000'));
