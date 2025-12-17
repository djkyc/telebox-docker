FROM node:20-slim

# 安装依赖
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python3 \
        sqlite3 \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

npm run compile


RUN mkdir -p /app/data /app/my_session

VOLUME ["/app/data", "/app/my_session"]

ENV NODE_ENV=production

CMD ["node", "dist/index.js"]
