FROM ghcr.io/openclaw/openclaw:latest

USER root

# Порты и память
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000
ENV NODE_OPTIONS="--max-old-space-size=350"

# Права
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
WORKDIR /app

# ЗАПУСК:
# 1. Мы запускаем маааленький сервер на Node.js, который просто держит порт 10000 открытым для Render.
# 2. Параллельно запускаем самого бота.
CMD ["/bin/sh", "-c", "node -e 'require(\"http\").createServer((req,res)=>res.end(\"ok\")).listen(10000)' & openclaw gateway --port 18789 --allow-unconfigured"]