FROM node:20-slim

# 1. 系统依赖
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        python3 \
        sqlite3 \
        git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. 工作目录
WORKDIR /app

# 3. 安装依赖
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# 4. 复制源码
COPY . .

# 5. 拷贝 entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 6. 声明持久化卷（非常关键）
VOLUME ["/app/data", "/app/my_session"]

# 7. 运行环境
ENV NODE_ENV=production

# 8. 启动入口
ENTRYPOINT ["/entrypoint.sh"]
