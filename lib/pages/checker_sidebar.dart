import 'package:flutter/material.dart';

class CheckerSidebar extends StatelessWidget {
  const CheckerSidebar({
    super.key,
    required this.activeItem,
    required this.onSelected,
  });

  final String activeItem;
  final ValueChanged<String> onSelected;

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF0E5);
  static const Color groupBackground = Color(0xFFFFF7EF);
  static const Color muted = Color(0xFF65758B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183,
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            10,
            25,
            10,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(
                  17,
                  8,
                  8,
                  25,
                ),
                child: Text(
                  'FOOD FLOW',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: orange,
                  ),
                ),
              ),

              // MAIN MENU
              _SidebarGroup(
                title: 'MAIN MENU',
                items: const [
                  'Dashboard',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 10),

              // STOK GUDANG
              _SidebarGroup(
                title: 'STOK GUDANG',
                items: const [
                  'Stok Bawaan',
                  'Stok Retur',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 10),

              // DISTRIBUSI
              _SidebarGroup(
                title: 'DISTRIBUSI',
                items: const [
                  'Distribusi Produk',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 10),

              // LAPORAN
              _SidebarGroup(
                title: 'LAPORAN',
                items: const [
                  'Riwayat Stok',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 10),

              // AKUN — HANYA LOGOUT
              _SidebarGroup(
                title: 'AKUN',
                items: const [
                  'Logout',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================
// KELOMPOK MENU SIDEBAR
// ===========================================================

class _SidebarGroup extends StatelessWidget {
  const _SidebarGroup({
    required this.title,
    required this.items,
    required this.activeItem,
    required this.onSelected,
  });

  final String title;
  final List<String> items;
  final String activeItem;
  final ValueChanged<String> onSelected;

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF0E5);
  static const Color groupBackground = Color(0xFFFFF7EF);
  static const Color muted = Color(0xFF65758B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        8,
        7,
      ),
      decoration: BoxDecoration(
        color: groupBackground,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL KATEGORI
          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: muted,
            ),
          ),

          const SizedBox(height: 4),

          // ITEM MENU
          ...items.map((item) {
            final bool selected = item == activeItem;

            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                borderRadius: BorderRadius.circular(4),
                onTap: () => onSelected(item),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? peach
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '• $item',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.w500,

                      // Semua item menu tetap berwarna oranye.
                      color: orange,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}