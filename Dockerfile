FROM node:18-slim

# Rakib Cloudflare WARP
RUN apt-get update && apt-get install -y curl gnupg lsb-release \
    && curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list \
    && apt-get update && apt-get install -y cloudflare-warp

WORKDIR /app

# Marka hore koobiyeey package files si loo rakibo dependencies
COPY package*.json ./
RUN npm install

# Ka dib koobiyeey koodhka kale oo dhan
COPY . .

# Bilow WARP ka dibna Node.js
CMD warp-svc > /dev/null 2>&1 & \
    sleep 5 && \
    warp-cli --accept-tos registration register && \
    warp-cli --accept-tos mode proxy && \
    warp-cli --accept-tos connect && \
    node index.js
