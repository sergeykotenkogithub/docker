FROM ghcr.io/openclaw/openclaw:latest

USER root

# Порты для Render
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# Лимит памяти для Node.js (чтобы не вылетало на Free тарифе)
ENV NODE_OPTIONS="--max-old-space-size=350"

# Даем права
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000

# Запускаем через встроенный бинарник openclaw
# Это самый надежный путь в этом образе
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "10000", "--allow-unconfigured"]