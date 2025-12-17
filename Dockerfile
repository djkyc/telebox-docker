FROM node:20-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python3 \
        sqlite3 \
        git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json ./

# Install npm dependencies
RUN npm ci --omit=dev

# Copy all source code
COPY . .

# No build step needed — TeleBox official is pure JS
# RUN npm run compile   ← remove

RUN mkdir -p /app/data /app/my_session

VOLUME ["/app/data", "/app/my_session"]

ENV NODE_ENV=production

CMD ["npm", "start"]
