# Instruksi Publikasi Binary

Dokumen ini berisi petunjuk untuk mempublikasikan binary ke GitHub repository tanpa menyertakan source code.

## Persiapan

1. Pastikan Anda sudah membangun binary dengan perintah `npm run build`
2. Binary dan file-file pendukung seharusnya berada di folder `dist/`

## Publikasi ke GitHub

1. Clone repository GitHub:

```bash
git clone https://github.com/direkturcrypto/vikey-inference.git vikey-inference-release
cd vikey-inference-release
```

2. Hapus semua konten yang ada (jika ada):

```bash
rm -rf *
```

3. Salin file-file binary dan pendukung dari folder dist:

```bash
cp -r ../dist/* .
```

4. Inisialisasi git repository baru (jika perlu):

```bash
git init
git remote add origin https://github.com/direkturcrypto/vikey-inference.git
```

5. Tambahkan semua file ke git:

```bash
git add .
```

6. Commit perubahan:

```bash
git commit -m "Release binary version 1.0.0"
```

7. Push ke repository GitHub:

```bash
git push -u origin main --force
```

## Membuat GitHub Release

1. Pergi ke repository GitHub: https://github.com/direkturcrypto/vikey-inference
2. Klik tab "Releases"
3. Klik "Draft a new release"
4. Isi tag version dengan "v1.0.0"
5. Isi release title dengan "Vikey Inference v1.0.0"
6. Tambahkan deskripsi release
7. Upload file binary (vikey-inference-win.exe, vikey-inference-linux, vikey-inference-macos)
8. Klik "Publish release"

## Catatan

- Pastikan tidak ada source code yang ter-push ke repository
- Pastikan file .gitignore sudah dikonfigurasi dengan benar untuk mencegah file source code ter-push
- Jika ingin memperbarui versi, ulangi langkah-langkah di atas dengan tag version yang berbeda 