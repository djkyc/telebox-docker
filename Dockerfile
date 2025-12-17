# 使用 Node.js 20（官方）
FROM node:20-alpine

# 安装构建环境和 sqlite
RUN apk add --no-cache \
    build-base python3 sqlite git

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY package.json package-lock.json ./

# 安装依赖
RUN npm ci

# 复制其他源代码
COPY . .

# 编译 TypeScript
RUN npm run build

# 创建持久化目录
RUN mkdir -p /app/data /app/my_session

# 容器对外可挂载
VOLUME /app/data
VOLUME /app/my_session

ENV NODE_ENV=production

CMD ["node", "dist/index.js"]
