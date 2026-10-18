import 'package:flutter/material.dart';

import 'login_page.dart';
import 'admin_setoran_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_struk_page.dart';
import 'admin_laporan_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  static const Color orange = Color(0xFFFF6B00);
  static const Color background = Color(0xFFF2F6FB);
  static const Color darkText = Color(0xFF1F2D42);
  static const Color mutedText = Color(0xFF60738F);
  static const Color sidebarTitle = Color(0xFF60738F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // =====================================================
          // SIDEBAR
          // =====================================================

          Container(
            width: 180,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                12,
                25,
                12,
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 23),
                    child: Text(
                      'FOOD FLOW',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: orange,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // MAIN MENU
                  _sideBox(
                    context: context,
                    title: 'MAIN MENU',
                    items: const [
                      'Dashboard',
                    ],
                    activeIndex: 0,
                  ),

                  const SizedBox(height: 12),

                  // KEUANGAN
                  _sideBox(
                    context: context,
                    title: 'KEUANGAN',
                    items: const [
                      'Setoran',
                      'Bagi Hasil',
                      'Struk Transparansi',
                    ],
                    activeIndex: -1,
                  ),

                  const SizedBox(height: 12),

                  // LAPORAN
                  _sideBox(
                    context: context,
                    title: 'LAPORAN',
                    items: const [
                      'Laporan Keuangan',
                    ],
                    activeIndex: -1,
                  ),

                  const SizedBox(height: 12),

                  // AKUN: HANYA LOGOUT
                  _sideBox(
                    context: context,
                    title: 'AKUN',
                    items: const [
                      'Logout',
                    ],
                    activeIndex: -1,
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // KONTEN UTAMA
          // =====================================================

          Expanded(
            child: Column(
              children: [
                // HEADER DASHBOARD
                Container(
                  height: 110,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 35,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DASHBOARD ADMIN KEUANGAN',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                color: darkText,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kelola data setoran, bagi hasil, dan struk transparansi',
                              style: TextStyle(
                                fontSize: 10,
                                color: mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // BADGE AKTOR ADMIN: STATIS, TANPA INTERAKSI
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // BODY DASHBOARD
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      35,
                      35,
                      35,
                      30,
                    ),
                    child: Column(
                      children: [
                        // KARTU STATISTIK
                        Row(
                          children: [
                            Expanded(
                              child: _statCard(
                                title: 'Total Setoran',
                                value: 'Rp 4.250.000',
                              ),
                            ),

                            const SizedBox(width: 25),

                            Expanded(
                              child: _statCard(
                                title: 'Bagi Hasil',
                                value: 'Rp 1.275.000',
                              ),
                            ),

                            const SizedBox(width: 25),

                            Expanded(
                              child: _statCard(
                                title: 'Struk Terbit',
                                value: '38',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 65),

                        // SETORAN TERBARU
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 650,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Setoran Terbaru',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(9),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Rungkut',
                                              '+ Rp 150.000',
                                              '11:15',
                                            ),
                                          ),

                                          const SizedBox(width: 15),

                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Sukolilo',
                                              '+ Rp 120.000',
                                              '12:30',
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Wonokromo',
                                              '+ Rp 200.000',
                                              '13:00',
                                            ),
                                          ),

                                          const SizedBox(width: 15),

                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Rungkut',
                                              '+ Rp 100.000',
                                              '14:45',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SIDEBAR BOX
  // =====================================================

  static Widget _sideBox({
    required BuildContext context,
    required String title,
    required List<String> items,
    required int activeIndex,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EF),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: sidebarTitle,
            ),
          ),

          const SizedBox(height: 7),

          ...List.generate(
            items.length,
            (index) {
              final String item = items[index];
              final bool isActive = index == activeIndex;

              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: InkWell(
                  mouseCursor: SystemMouseCursors.click,
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    if (item == 'Logout') {
                      _showLogoutDialog(context);
                    } else {
                      _navigateAdmin(context, item);
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                      ),
                      child: Text(
                        '• $item',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: orange,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // =====================================================
  // NAVIGASI ADMIN
  // =====================================================

  static void _navigateAdmin(
    BuildContext context,
    String item,
  ) {
    Widget? destination;

    switch (item) {
      case 'Dashboard':
        destination = const AdminDashboardPage();
        break;

      case 'Setoran':
        destination = const AdminSetoranPage();
        break;

      case 'Bagi Hasil':
        destination = const AdminBagiHasilPage();
        break;

      case 'Struk Transparansi':
        destination = const StrukTransparansiPage();
        break;

      case 'Laporan Keuangan':
        destination = const AdminLaporanKeuanganPage();
        break;
    }

    if (destination != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => destination!,
        ),
      );
    }
  }

  // =====================================================
  // KARTU STATISTIK
  // =====================================================

  static Widget _statCard({
    required String title,
    required String value,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 82,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: mutedText,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 7),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // ITEM SETORAN TERBARU
  // =====================================================

  static Widget _historyItem(
    String outlet,
    String amount,
    String time,
  ) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 43,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EBF4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '• $outlet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF32629A),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A64F),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          Text(
            time,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00A64F),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // DIALOG LOGOUT
  // =====================================================

  static void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Yakin ingin keluar?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            'Anda akan keluar dari akun FoodFlow saat ini.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}