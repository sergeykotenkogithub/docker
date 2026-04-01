FROM ghcr.io/openclaw/openclaw:latest

USER root

# Стандартный порт для Render
ENV PORT=10000
ENV GATEWAY_PORT=10000
EXPOSE 10000

# Даем полные права на домашнюю директорию
RUN mkdir -p /home/node/.openclaw && chmod -R 777 /home/node/

USER 1000
WORKDIR /app

# Запускаем через встроенный бинарник openclaw с жестким ограничением памяти
# и явным указанием хоста/порта
CMD ["node", "--max-old-space-size=400", "./dist/gateway.js", "--host", "0.0.0.0", "--port", "10000", "--allow-unconfigured"]