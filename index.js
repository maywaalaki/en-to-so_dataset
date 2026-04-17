const express = require('express');
const request = require('request');

const app = express();

app.get('/proxy', (req, res) => {
    const url = req.query.url;

    if (!url) {
        return res.status(400).send('No URL provided');
    }

    request(url).on('error', () => {
        res.status(500).send('Request failed');
    }).pipe(res);
});

app.get('/', (req, res) => {
    res.send('WireGuard Proxy is running');
});

app.listen(8080, () => {
    console.log('Server running on port 8080');
});
