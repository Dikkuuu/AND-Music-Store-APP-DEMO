import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class DetailPage extends StatelessWidget {
  final MenuItem item;

  const DetailPage({super.key, required this.item});

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: const Color(0xFF181822),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Target transformasi Radial Hero: persegi berukuran besar
            Hero(
              tag: 'hero-${item.nama}',
              createRectTween: _createRectTween,
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: const BoxDecoration(
                      color: Color(0xFF252536),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.fromBorderSide(
                        BorderSide(color: Color(0xFFF59E0B), width: 2),
                      ),
                    ),
                    child: Image.asset(
                      item.gambar,
                      fit: BoxFit.cover,
                      cacheWidth: 520,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.album_rounded,
                            color: Color(0xFFF59E0B),
                            size: 96,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: item.tersedia
                    ? const Color(0xFF065F46)
                    : const Color(0xFF991B1B),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                item.tersedia ? 'Stok Tersedia' : 'Habis',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              item.nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.harga,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF59E0B),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E2C),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0x33FFFFFF), width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategori: ${item.kategori}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF38BDF8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Spesifikasi & Deskripsi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.deskripsi,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFFCBD5E1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}