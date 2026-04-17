FROM node:18-slim

RUN apt-get update && apt-get install -y \
    curl \
    iproute2 \
    iptables \
    wireguard \
    wireguard-tools \
    dnsutils \
    && apt-get clean

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD bash -c "wg-quick up wg0 || true && node index.js"
