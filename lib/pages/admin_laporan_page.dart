import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_setoran_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_struk_page.dart';

class AdminLaporanKeuanganPage extends StatelessWidget {
  const AdminLaporanKeuanganPage({super.key});

  static const Color orange = Color(0xFFFF6B00);
  static const Color background = Color(0xFFF1F6FC);
  static const Color sidebarTitle = Color(0xFF60738F);
  static const Color sidebarText = Color(0xFFFF6B00);

  static const List<Map<String, String>> laporanBulanan = [
    {
      'bulan': 'September 2026',
      'total': 'Rp 12.500.000',
    },
    {
      'bulan': 'Agustus 2026',
      'total': 'Rp 11.850.000',
    },
    {
      'bulan': 'Juli 2026',
      'total': 'Rp 13.200.000',
    },
    {
      'bulan': 'Juni 2026',
      'total': 'Rp 10.450.000',
    },
  ];

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
                24,
                12,
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LOGO FOOD FLOW

                  const Padding(
                    padding: EdgeInsets.only(
                      left: 23,
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

                  const SizedBox(height: 32),

                  // MAIN MENU

                  _sideBox(
                    context: context,
                    title: 'MAIN MENU',
                    items: const [
                      'Dashboard',
                    ],
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
                  ),

                  const SizedBox(height: 12),

                  // LAPORAN

                  _sideBox(
                    context: context,
                    title: 'LAPORAN',
                    items: const [
                      'Laporan Keuangan',
                    ],
                  ),

                  const SizedBox(height: 12),

                  // AKUN — HANYA LOGOUT

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
          ),

          // =====================================================
          // KONTEN UTAMA
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =================================================
                // HEADER
                // =================================================

                Container(
                  height: 110,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    30,
                    15,
                    40,
                    10,
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
                              'LAPORAN KEUANGAN',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF263548),
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'Rekapitulasi data keuangan dan unduh laporan bulanan',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF60738F),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // ROLE ADMIN

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius:
                              BorderRadius.circular(8),
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
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =================================================
                // REKAP LAPORAN BULANAN
                // =================================================

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          25,
                          45,
                          25,
                          30,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 700,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                // JUDUL

                                const Text(
                                  'Rekap Laporan Bulanan',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // KARTU UTAMA

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(
                                    20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFFFFCFC,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      // BARIS PERTAMA

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                          Expanded(
                                            child: _reportCard(
                                              context,
                                              laporanBulanan[0],
                                            ),
                                          ),

                                          const SizedBox(
                                            width: 20,
                                          ),

                                          Expanded(
                                            child: _reportCard(
                                              context,
                                              laporanBulanan[1],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 16),

                                      // BARIS KEDUA

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                          Expanded(
                                            child: _reportCard(
                                              context,
                                              laporanBulanan[2],
                                            ),
                                          ),

                                          const SizedBox(
                                            width: 20,
                                          ),

                                          Expanded(
                                            child: _reportCard(
                                              context,
                                              laporanBulanan[3],
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
                      );
                    },
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
  // KARTU LAPORAN BULANAN
  // =====================================================

  static Widget _reportCard(
    BuildContext context,
    Map<String, String> laporan,
  ) {
    final String bulan = laporan['bulan']!;
    final String total = laporan['total']!;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 60,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE3EAF3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // INFORMASI LAPORAN

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• Laporan $bulan',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF35639B),
                  ),
                ),

                const SizedBox(height: 4),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  child: Text(
                    'Total: $total',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF60738F),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // TOMBOL UNDUH PDF

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      'Laporan $bulan dipilih.',
                    ),
                    duration: const Duration(
                      seconds: 2,
                    ),
                  ),
                );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(0, 30),
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 7,
              ),
              tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Unduh PDF',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
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
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        7,
        7,
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

          const SizedBox(height: 5),

          // SELURUH ITEM MENU BERWARNA ORANYE

          ...items.map(
            (item) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
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
                          color: sidebarText,
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
        destination = const StrukTransparansiPage();
        break;

      case 'Laporan Keuangan':
        return;
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
              child: const Text(
                'Batal',
              ),
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
              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    );
  }
}