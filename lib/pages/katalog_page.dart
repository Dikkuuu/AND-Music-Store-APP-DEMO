import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../widgets/menu_card.dart';
import '../widgets/spinning_cup_badge.dart';
import 'detail_page.dart';

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  final ValueNotifier<List<MenuItem>> _catalogNotifier =
      ValueNotifier<List<MenuItem>>(initialMusicCatalog);
  final ValueNotifier<StockFilter> _filterNotifier =
      ValueNotifier<StockFilter>(StockFilter.semua);

  @override
  void dispose() {
    _catalogNotifier.dispose();
    _filterNotifier.dispose();
    super.dispose();
  }

  void _toggleAvailability(String id) {
    final List<MenuItem> updated = _catalogNotifier.value.map((item) {
      if (item.id == id) {
        return item.copyWith(tersedia: !item.tersedia);
      }
      return item;
    }).toList(growable: false);

    _catalogNotifier.value = updated;
  }

  void _openDetail(BuildContext context, MenuItem item) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        // Durasi transisi Radial Hero tepat 600 ms
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DetailPage(item: item),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF181822),
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                'images/logo.png',
                width: 34,
                height: 34,
                cacheWidth: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(
                      Icons.queue_music_rounded,
                      color: Color(0xFF121218),
                      size: 22,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'And Music Store',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Ikon cangkir berputar terus-menerus pada header KatalogPage
            const SpinningCupBadge(),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Row(
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 16,
                  color: Color(0xFF94A3B8),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Ketuk kartu untuk detail • Tekan lama untuk ubah status stok',
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                ),
              ],
            ),
          ),
          // Bilah Filter Stok (Semua / Tersedia / Habis)
          ValueListenableBuilder<StockFilter>(
            valueListenable: _filterNotifier,
            builder: (context, activeFilter, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    _FilterChipItem(
                      label: 'Semua (10)',
                      selected: activeFilter == StockFilter.semua,
                      onSelected: () =>
                          _filterNotifier.value = StockFilter.semua,
                    ),
                    const SizedBox(width: 8),
                    _FilterChipItem(
                      label: 'Tersedia',
                      selected: activeFilter == StockFilter.tersedia,
                      onSelected: () =>
                          _filterNotifier.value = StockFilter.tersedia,
                    ),
                    const SizedBox(width: 8),
                    _FilterChipItem(
                      label: 'Habis',
                      selected: activeFilter == StockFilter.habis,
                      onSelected: () =>
                          _filterNotifier.value = StockFilter.habis,
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(height: 1, color: Color(0x1FFFFFFF)),
          // Daftar 10 menu menggunakan ListView.builder
          Expanded(
            child: ValueListenableBuilder<List<MenuItem>>(
              valueListenable: _catalogNotifier,
              builder: (context, items, _) {
                return ValueListenableBuilder<StockFilter>(
                  valueListenable: _filterNotifier,
                  builder: (context, filter, _) {
                    final List<MenuItem> filteredItems = items.where((item) {
                      if (filter == StockFilter.tersedia) return item.tersedia;
                      if (filter == StockFilter.habis) return !item.tersedia;
                      return true;
                    }).toList(growable: false);

                    if (filteredItems.isEmpty) {
                      return const Center(
                        child: Text(
                          'Tidak ada produk pada kategori filter ini.',
                          style: TextStyle(color: Color(0xFF94A3B8)),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final MenuItem menu = filteredItems[index];
                        return MenuCard(
                          key: ValueKey(menu.id),
                          nama: menu.nama,
                          harga: menu.harga,
                          tersedia: menu.tersedia,
                          kategori: menu.kategori,
                          gambar: menu.gambar,
                          onTap: () => _openDetail(context, menu),
                          onLongPress: () => _toggleAvailability(menu.id),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChipItem({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: const Color(0xFFF59E0B),
      backgroundColor: const Color(0xFF1E1E2C),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: selected ? const Color(0xFF121218) : Colors.white,
      ),
      side: const BorderSide(color: Color(0x33F59E0B)),
    );
  }
}