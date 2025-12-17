FROM node:20-slim

# 安装构建依赖
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python3 \
        sqlite3 \
        git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

# TeleBox 官方使用 compile（不是 build）
RUN npm run compile

RUN mkdir -p /app/data /app/my_session

VOLUME ["/app/data", "/app/my_session"]

ENV NODE_ENV=production

CMD ["npm", "start"]
