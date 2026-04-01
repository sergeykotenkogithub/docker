FROM ghcr.io/openclaw/openclaw:latest

USER root
ENV PORT=10000
ENV NODE_ENV=production
ENV NODE_OPTIONS="--max-old-space-size=350"

# Ставим PM2 для контроля памяти
RUN npm install -g pm2

RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
# Важно: в этом образе рабочая директория может быть другой, 
# поэтому используем полный путь к бинарнику
WORKDIR /home/node

# ЗАПУСК: 
# 1. Заглушка для Render.
# 2. PM2 запускает команду 'openclaw gateway'.
# --interpreter node: говорим PM2 использовать ноду с нашими лимитами.
CMD ["/bin/sh", "-c", "node -e 'require(\"http\").createServer((req,res)=>res.end(\"ok\")).listen(10000)' & pm2-runtime start \"openclaw gateway --port 18789 --allow-unconfigured\" --interpreter node"]