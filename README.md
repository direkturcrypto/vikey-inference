# Vikey Inference

Vikey Inference adalah proxy server yang meneruskan permintaan API Ollama ke vikey.ai untuk inferensi model dan embedding.

## Fitur

- Kompatibel dengan API Ollama
- Kompatibel dengan API OpenAI
- Mendukung berbagai platform (Windows, Linux, macOS)
- Konfigurasi model kustom melalui models.json
- Setup API key interaktif saat pertama kali dijalankan

## Instalasi

### Unduh Binary

Unduh binary yang sesuai dengan sistem operasi Anda dari [release terbaru](https://github.com/direkturcrypto/vikey-inference/releases/latest).

### Izin Eksekusi (Linux/macOS)

Untuk Linux/macOS, tambahkan izin eksekusi pada binary:

```bash
chmod +x ./vikey-inference-linux
# atau
chmod +x ./vikey-inference-macos
```

## Penggunaan

### Menjalankan Binary

```bash
# Windows
vikey-inference-win.exe

# Linux
./vikey-inference-linux

# macOS
./vikey-inference-macos
```

Pada saat pertama kali dijalankan, jika tidak ada API key yang ditemukan, Anda akan diminta untuk memasukkan API key:

```
========================================
VIKEY_API_KEY is not set in your .env file
You need to provide a valid API key to continue
Visit https://vikey.ai to sign up and get your API key
========================================

Please enter your VIKEY_API_KEY: _
```

API key akan disimpan ke file .env untuk penggunaan selanjutnya.

### Penggunaan dengan Aplikasi Klien

Atur URL API Ollama ke `http://localhost:11434` di aplikasi klien Anda.

### Endpoint API

Server menyediakan endpoint API berikut:

- API Ollama: `/api/*`
- API OpenAI: `/v1/*`

## Environment Variables

Anda dapat mengkustomisasi server dengan membuat file `.env` dengan opsi berikut:

| Variable | Deskripsi | Default |
|----------|-----------|---------|
| NODE_PORT | Port yang digunakan server | 11434 |
| VIKEY_API_KEY | API key untuk layanan vikey.ai | - |
| EMBEDDING_API_URL | URL API embedding | https://qwen7b.gaia.domains/v1 |
| EMBEDDING_API_KEY | API key untuk layanan embedding | - |
| LLAMAEDGE_ENABLED | Mengaktifkan mode LlamaEdge | false |
| GAIA_CONFIG_PATH | Path ke direktori konfigurasi (saat LlamaEdge mode aktif) | ./config |

## Instalasi sebagai Layanan

### Systemd (Linux)

1. Buat file service systemd:

```bash
sudo nano /etc/systemd/system/vikey-inference.service
```

2. Tambahkan konfigurasi berikut:

```ini
[Unit]
Description=Vikey Inference Server
After=network.target

[Service]
ExecStart=/path/to/vikey-inference-linux
WorkingDirectory=/path/to
Restart=always
User=your_username
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

3. Aktifkan dan jalankan service:

```bash
sudo systemctl enable vikey-inference
sudo systemctl start vikey-inference
```

### Docker

Berikut adalah contoh Dockerfile sederhana:

```dockerfile
FROM debian:bullseye-slim

WORKDIR /app

# Copy binary dan file konfigurasi
COPY vikey-inference-linux .
COPY models.json .
COPY .env.example .env

# Sesuaikan izin
RUN chmod +x vikey-inference-linux

# Ekspose port
EXPOSE 11434

# Jalankan aplikasi
CMD ["./vikey-inference-linux"]
```

Build dan jalankan container:

```bash
docker build -t vikey-inference .
docker run -p 11434:11434 -e VIKEY_API_KEY=your_key_here vikey-inference
```

## Custom Models

Tambahkan model kustom dengan mengedit file `models.json` yang harus diletakkan di direktori yang sama dengan binary.

## Troubleshooting

Jika Anda mengalami masalah:

1. Pastikan file yang diperlukan berada di direktori yang sama dengan binary:
   - `.env` atau `.env.example`
   - `models.json`

2. Periksa bahwa variabel lingkungan diatur dengan benar di file `.env`.

3. Untuk melihat versi aplikasi:
   ```bash
   ./vikey-inference-linux --version
   ```

## Support

Untuk bantuan lebih lanjut, silakan buka [issue di GitHub](https://github.com/direkturcrypto/vikey-inference/issues). 