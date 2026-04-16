const express = require('express');
const request = require('request');
const SocksProxyAgent = require('socks-proxy-agent');
const app = express();

// Cloudflare WARP wuxuu inta badan ka shaqeeyaa port 40001
const proxy = 'socks5://127.0.0.1:40001';
const agent = new SocksProxyAgent(proxy);

app.get('/proxy', (req, res) => {
    const url = req.query.url;
    if (!url) return res.status(400).send('No URL provided');

    console.log(`Proxying: ${url}`);

    // Xogta waxaa laga dhex saarayaa WARP (agent)
    request({ url, agent }).pipe(res).on('error', (err) => {
        res.status(500).send('Error connecting to URL');
    });
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => console.log(`Proxy Bridge is running on port ${PORT}`));
