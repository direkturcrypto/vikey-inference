FROM debian:bullseye-slim

WORKDIR /app

# Argumen untuk API key (opsional)
ARG VIKEY_API_KEY=your_default_api_key_here
ARG NODE_PORT=11434

# Salin binary dan file konfigurasi
COPY vikey-inference-linux .
COPY models.json .
COPY .env.example .env

# Sesuaikan izin
RUN chmod +x vikey-inference-linux

# Jika API key disediakan, gunakan API key tersebut
RUN if [ "$VIKEY_API_KEY" != "your_default_api_key_here" ]; then \
    sed -i "s/VIKEY_API_KEY=.*/VIKEY_API_KEY=$VIKEY_API_KEY/" .env; \
  fi

# Atur port
RUN sed -i "s/NODE_PORT=.*/NODE_PORT=$NODE_PORT/" .env

# Ekspose port
EXPOSE $NODE_PORT

# Jalankan aplikasi
CMD ["./vikey-inference-linux"] 