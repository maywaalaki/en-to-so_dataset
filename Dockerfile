FROM node:18-slim

# Rakib Cloudflare WARP
RUN apt-get update && apt-get install -y curl gnupg lsb-release \
    && curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list \
    && apt-get update && apt-get install -y cloudflare-warp

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Script-ka bilowga: Shid WARP, is diiwaangeli, ka dibna shid Proxy-ga
CMD warp-svc > /dev/null 2>&1 & \
    sleep 2 && \
    warp-cli --accept-tos register && \
    warp-cli --accept-tos set-mode proxy && \
    warp-cli --accept-tos connect && \
    node index.js
