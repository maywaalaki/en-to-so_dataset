FROM node:18-slim

# Install dependencies + Cloudflare WARP
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    systemctl \
    && curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/cloudflare-warp.list \
    && apt-get update && apt-get install -y cloudflare-warp \
    && apt-get clean

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Start WARP + app safely
CMD bash -c "\
    warp-svc > /dev/null 2>&1 & \
    sleep 8 && \
    warp-cli --accept-tos registration new || true && \
    warp-cli --accept-tos connect || true && \
    node index.js"
