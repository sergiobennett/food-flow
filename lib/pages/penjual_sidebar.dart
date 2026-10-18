import 'package:flutter/material.dart';

class PenjualSidebar extends StatelessWidget {
  static const Color _orange = Color(0xFFFF7518);
  static const Color _peach = Color(0xFFFFF0E5);
  static const Color _groupBackground = Color(0xFFFFF7EF);
  static const Color _muted = Color(0xFF65758B);

  final String activeItem;
  final ValueChanged<String> onSelected;

  const PenjualSidebar({
    super.key,
    required this.activeItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 182,
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // LOGO FOOD FLOW
              // =================================================

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 8, 28),
                child: Text(
                  'FOOD FLOW',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: _orange,
                  ),
                ),
              ),

              // =================================================
              // MAIN MENU
              // =================================================

              _SidebarGroup(
                title: 'MAIN MENU',
                items: const [
                  'Dashboard',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 12),

              // =================================================
              // STOK
              // Menu Stok dihapus.
              // Sekarang hanya ada Pengambilan Stok.
              // =================================================

              _SidebarGroup(
                title: 'STOK',
                items: const [
                  'Pengambilan Stok',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 12),

              // =================================================
              // TRANSAKSI
              // =================================================

              _SidebarGroup(
                title: 'TRANSAKSI',
                items: const [
                  'Struk Transparansi',
                ],
                activeItem: activeItem,
                onSelected: onSelected,
              ),

              const SizedBox(height: 12),

              // =================================================
              // AKUN
              // =================================================

              _SidebarGroup(
                title: 'AKUN',
                items: const [
                  'Profil',
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

// =============================================================
// WIDGET KELOMPOK SIDEBAR
// =============================================================

class _SidebarGroup extends StatelessWidget {
  static const Color _orange = Color(0xFFFF7518);
  static const Color _peach = Color(0xFFFFF0E5);
  static const Color _groupBackground = Color(0xFFFFF7EF);
  static const Color _muted = Color(0xFF65758B);

  final String title;
  final List<String> items;
  final String activeItem;
  final ValueChanged<String> onSelected;

  const _SidebarGroup({
    required this.title,
    required this.items,
    required this.activeItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 8, 8, 7),
      decoration: BoxDecoration(
        color: _groupBackground,
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
              color: _muted,
            ),
          ),

          const SizedBox(height: 4),

          // DAFTAR MENU
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
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? _peach
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
                      color: _orange,
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