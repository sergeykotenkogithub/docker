FROM ghcr.io/openclaw/openclaw:latest

USER root
ENV PORT=10000
ENV NODE_ENV=production
# Чуть-чуть поднимем лимит, чтобы он не падал сразу при запуске
ENV NODE_OPTIONS="--max-old-space-size=350"

# Ставим PM2
RUN npm install -g pm2

RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
WORKDIR /app

# ЗАПУСК: 
# 1. Заглушка для Render на 10000.
# 2. PM2 запускает бота и следит за ним.
CMD ["/bin/sh", "-c", "node -e 'require(\"http\").createServer((req,res)=>res.end(\"ok\")).listen(10000)' & pm2-runtime start dist/gateway.js --node-args='--max-old-space-size=350' -- --port 18789 --allow-unconfigured"]