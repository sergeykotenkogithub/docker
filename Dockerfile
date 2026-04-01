FROM ghcr.io/openclaw/openclaw:latest

USER root

# Порты
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# Лимит памяти
ENV NODE_OPTIONS="--max-old-space-size=350"

# Права
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000

# ЗАПУСК С "ЗАГЛУШКОЙ":
# Мы запускаем бота и ОДНОВРЕМЕННО простейший эхо-сервер на порту 10000, 
# чтобы Render увидел, что порт открыт.
CMD ["/bin/sh", "-c", "python3 -m http.server 10000 & openclaw gateway --host 0.0.0.0 --port 18789 --allow-unconfigured"]