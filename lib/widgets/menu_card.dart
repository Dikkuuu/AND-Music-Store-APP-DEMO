import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  // Atribut wajib sesuai soal: nama, harga, dan tersedia
  final String nama;
  final String harga;
  final bool tersedia;

  // Atribut pendukung katalog toko musik
  final String kategori;
  final String gambar;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const MenuCard({
    super.key,
    required this.nama,
    required this.harga,
    required this.tersedia,
    required this.kategori,
    required this.gambar,
    required this.onTap,
    required this.onLongPress,
  });

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    final Widget cardContent = GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        // Satu BoxDecoration berisi LinearGradient, borderRadius 20, border, dan boxShadow
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF252536),
              Color(0xFF191924),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.fromBorderSide(
            BorderSide(color: Color(0x4DF59E0B), width: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 12,
              spreadRadius: 1,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ikon / gambar di dalam lingkaran (BoxShape.circle) + Radial Hero
            Hero(
              tag: 'hero-$nama',
              createRectTween: _createRectTween,
              flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    // Interpolasi radius dari lingkaran (34) menuju persegi membulat (20)
                    final BorderRadius radius = BorderRadius.lerp(
                      const BorderRadius.all(Radius.circular(34)),
                      const BorderRadius.all(Radius.circular(20)),
                      animation.value,
                    )!;
                    return Material(
                      color: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: radius,
                        child: _ProductImage(gambar: gambar),
                      ),
                    );
                  },
                );
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2F2F44),
                    border: Border.fromBorderSide(
                      BorderSide(color: Color(0xFFF59E0B), width: 1.5),
                    ),
                  ),
                  child: ClipOval(
                    child: _ProductImage(gambar: gambar),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kategori.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                      color: Color(0xFF38BDF8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    harga,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Label "Habis" muncul saat tersedia == false
            if (!tersedia)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFDC2626),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Text(
                  'Habis',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            else
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF94A3B8),
              ),
          ],
        ),
      ),
    );

    // ATURAN BUTIR 3: Kartu yang tersedia TIDAK BOLEH dibungkus widget Opacity
    if (tersedia) {
      return cardContent;
    }

    // Jika habis, transparan halus ke 0.4 menggunakan AnimatedOpacity (400 ms)
    return _SoldOutFadeWrapper(child: cardContent);
  }
}

class _SoldOutFadeWrapper extends StatefulWidget {
  final Widget child;
  const _SoldOutFadeWrapper({required this.child});

  @override
  State<_SoldOutFadeWrapper> createState() => _SoldOutFadeWrapperState();
}

class _SoldOutFadeWrapperState extends State<_SoldOutFadeWrapper> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _opacity = 0.4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String gambar;
  const _ProductImage({required this.gambar});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      gambar,
      fit: BoxFit.cover,
      // Optimasi dekode memori bitmap sesuai Pertemuan 4
      cacheWidth: 260,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(
            Icons.music_note_rounded,
            color: Color(0xFFF59E0B),
            size: 32,
          ),
        );
      },
    );
  }
}