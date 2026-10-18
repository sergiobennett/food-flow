import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_setoran_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_laporan_page.dart';

class StrukTransparansiPage extends StatelessWidget {
  const StrukTransparansiPage({super.key});

  static const Color orange = Color(0xFFFF6F00);
  static const Color sidebarTitle = Color(0xFF60738F);
  static const Color background = Color(0xFFF1F6FC);
  static const Color darkText = Color(0xFF263548);

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

          _buildSidebar(context),

          // =====================================================
          // KONTEN UTAMA
          // =====================================================

          Expanded(
            child: Column(
              children: [
                // =================================================
                // HEADER
                // =================================================

                Container(
                  height: 115,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    25,
                    40,
                    15,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STRUK TRANSPARANSI',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: darkText,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kelola dan cetak bukti transaksi untuk mitra',
                              style: TextStyle(
                                fontSize: 11,
                                color: sidebarTitle,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // ROLE ADMIN

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

                // =================================================
                // RIWAYAT STRUK
                // =================================================

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      35,
                      20,
                      40,
                      25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Riwayat Struk',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // KARTU RIWAYAT STRUK

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFCFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFE8EEF5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // BARIS PERTAMA

                              Row(
                                children: [
                                  Expanded(
                                    child: _receiptCard(
                                      context,
                                      'Setoran – Outlet Rungkut',
                                      '+ Rp 150.000',
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  Expanded(
                                    child: _receiptCard(
                                      context,
                                      'Setoran – Outlet Sukolilo',
                                      '+ Rp 120.000',
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              // BARIS KEDUA

                              Row(
                                children: [
                                  Expanded(
                                    child: _receiptCard(
                                      context,
                                      'Setoran – Outlet Wonokromo',
                                      '+ Rp 200.000',
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  Expanded(
                                    child: _receiptCard(
                                      context,
                                      'Setoran – Outlet Rungkut',
                                      '+ Rp 100.000',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // =================================================
                        // TOMBOL BAGIAN BAWAH
                        // =================================================

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _orangeButton(
                              'Kembali',
                              () {
                                Navigator.pop(context);
                              },
                            ),

                            const SizedBox(width: 12),

                            _orangeButton(
                              'Cetak',
                              () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Semua struk siap diproses untuk dicetak.',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
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
  // SIDEBAR UTAMA
  // =====================================================

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 180,
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          14,
          25,
          14,
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOGO FOOD FLOW

            const Padding(
              padding: EdgeInsets.only(left: 23),
              child: Text(
                'FOOD FLOW',
                style: TextStyle(
                  color: orange,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // MAIN MENU
            // =================================================

            _sideBox(
              context: context,
              title: 'MAIN MENU',
              items: const [
                'Dashboard',
              ],
            ),

            const SizedBox(height: 12),

            // =================================================
            // KEUANGAN
            // =================================================

            _sideBox(
              context: context,
              title: 'KEUANGAN',
              items: const [
                'Setoran',
                'Bagi Hasil',
                'Struk Transparansi',
              ],
            ),

            const SizedBox(height: 12),

            // =================================================
            // LAPORAN
            // =================================================

            _sideBox(
              context: context,
              title: 'LAPORAN',
              items: const [
                'Laporan Keuangan',
              ],
            ),

            const SizedBox(height: 12),

            // =================================================
            // AKUN
            // =================================================

            // Bagian AKUN berada tepat di bawah LAPORAN.
            // Menu Profil sudah dihapus, Logout tetap tersedia.

            _sideBox(
              context: context,
              title: 'AKUN',
              items: const [
                'Logout',
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // KOTAK MENU SIDEBAR
  // =====================================================

  static Widget _sideBox({
    required BuildContext context,
    required String title,
    required List<String> items,
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
          // JUDUL KATEGORI TETAP ABU-ABU

          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: sidebarTitle,
            ),
          ),

          const SizedBox(height: 7),

          // ITEM MENU BERWARNA ORANYE

          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
              ),
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  if (item == 'Logout') {
                    _showLogoutDialog(context);
                  } else {
                    _navigate(context, item);
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
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: orange,
                      ),
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

  // =====================================================
  // NAVIGASI HALAMAN ADMIN
  // =====================================================

  static void _navigate(
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
        // Halaman yang sedang dibuka.
        return;

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
  // KARTU RIWAYAT STRUK
  // =====================================================

  static Widget _receiptCard(
    BuildContext context,
    String title,
    String amount,
  ) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 48,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EAF3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• $title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF35639B),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A63C),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // TOMBOL CETAK PER STRUK

          SizedBox(
            height: 28,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$title siap diproses untuk dicetak.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Cetak',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // TOMBOL ORANYE
  // =====================================================

  static Widget _orangeButton(
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: orange,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 11,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
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