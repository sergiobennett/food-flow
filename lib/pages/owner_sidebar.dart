import 'package:flutter/material.dart';

/// Sidebar bersama untuk halaman Owner FoodFlow.
/// Desain dibuat konsisten dengan sidebar Checker.
class OwnerSidebar extends StatelessWidget {
  final String activeItem;
  final ValueChanged<String> onSelected;

  const OwnerSidebar({
    super.key,
    required this.activeItem,
    required this.onSelected,
  });

  static const Color _orange = Color(0xFFFF7100);
  static const Color _boxColor = Color(0xFFFFF6EC);
  static const Color _activeColor = Color(0xFFFFE8D6);
  static const Color _headingColor = Color(0xFF78909C);

  static const List<_OwnerSidebarSection> _sections = [
    _OwnerSidebarSection(
      title: 'MAIN MENU',
      items: ['Dashboard'],
    ),
    _OwnerSidebarSection(
      title: 'MASTER DATA',
      items: ['Produk', 'Outlet', 'Penjual'],
    ),
    _OwnerSidebarSection(
      title: 'TRANSAKSI',
      items: ['Distribusi', 'Retur', 'Setoran', 'Bagi Hasil'],
    ),
    _OwnerSidebarSection(
      title: 'LAPORAN',
      items: ['Laporan'],
    ),
    _OwnerSidebarSection(
      title: 'AKUN',
      items: ['Logout'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          const Padding(
            padding: EdgeInsets.only(left: 27),
            child: Text(
              'FOOD FLOW',
              style: TextStyle(
                fontSize: 16,
                height: 1.2,
                fontWeight: FontWeight.w900,
                color: _orange,
              ),
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _sections.map(_buildSection).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // KATEGORI SIDEBAR
  // =====================================================

  Widget _buildSection(_OwnerSidebarSection section) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      padding: const EdgeInsets.fromLTRB(
        10,
        6,
        5,
        6,
      ),
      decoration: BoxDecoration(
        color: _boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 8,
              height: 1.1,
              fontWeight: FontWeight.w900,
              color: _headingColor,
            ),
          ),

          const SizedBox(height: 4),

          ...section.items.map(_buildItem),
        ],
      ),
    );
  }

  // =====================================================
  // ITEM MENU
  // =====================================================

  Widget _buildItem(String item) {
    final bool isActive = item == activeItem;

    return InkWell(
      onTap: () => onSelected(item),
      borderRadius: BorderRadius.circular(4),
      mouseCursor: SystemMouseCursors.click,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? _activeColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Text(
              '• ',
              style: TextStyle(
                fontSize: 11,
                height: 1.2,
                fontWeight: FontWeight.bold,
                color: _orange,
              ),
            ),

            Expanded(
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  height: 1.2,
                  fontWeight: isActive
                      ? FontWeight.bold
                      : FontWeight.w600,
                  color: _orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// MODEL KATEGORI SIDEBAR
// =====================================================

class _OwnerSidebarSection {
  final String title;
  final List<String> items;

  const _OwnerSidebarSection({
    required this.title,
    required this.items,
  });
}