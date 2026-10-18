import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_setoran_page.dart';
import 'admin_struk_page.dart';
import 'admin_laporan_page.dart';

class AdminBagiHasilPage extends StatefulWidget {
  const AdminBagiHasilPage({super.key});

  @override
  State<AdminBagiHasilPage> createState() =>
      _AdminBagiHasilPageState();
}

class _AdminBagiHasilPageState extends State<AdminBagiHasilPage> {
  static const Color orange = Color(0xFFFF6B00);
  static const Color background = Color(0xFFF2F6FB);
  static const Color darkText = Color(0xFF1F2D42);
  static const Color mutedText = Color(0xFF60738F);
  static const Color sidebarTitle = Color(0xFF60738F);

  String periode = 'September 2026';
  String outlet = 'Semua Outlet';

  // =====================================================
  // DATA BAGI HASIL
  // =====================================================

  final List<Map<String, String>> data = const [
    {
      'periode': 'September 2026',
      'outlet': 'Rungkut',
      'penjualan': 'Rp 350.000',
      'bagiHasil': 'Rp 105.000',
      'status': 'Selesai',
    },
    {
      'periode': 'September 2026',
      'outlet': 'Wonokromo',
      'penjualan': 'Rp 420.000',
      'bagiHasil': 'Rp 126.000',
      'status': 'Selesai',
    },
  ];

  // =====================================================
  // FILTER DATA
  // =====================================================

  List<Map<String, String>> get dataTerfilter {
    return data.where((item) {
      final cocokPeriode = item['periode'] == periode;

      final cocokOutlet = outlet == 'Semua Outlet' ||
          item['outlet'] == outlet;

      return cocokPeriode && cocokOutlet;
    }).toList();
  }

  // =====================================================
  // PILIH PERIODE
  // =====================================================

  Future<void> _pilihPeriode() async {
    final String? pilihan = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text(
            'Pilih Periode',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            'September 2026',
            'Agustus 2026',
            'Juli 2026',
          ].map((item) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(dialogContext, item);
              },
              child: Text(item),
            );
          }).toList(),
        );
      },
    );

    if (!mounted) return;

    if (pilihan != null) {
      setState(() {
        periode = pilihan;
      });
    }
  }

  // =====================================================
  // PILIH OUTLET
  // =====================================================

  Future<void> _pilihOutlet() async {
    final String? pilihan = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text(
            'Pilih Outlet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            'Semua Outlet',
            'Rungkut',
            'Sukolilo',
            'Wonokromo',
          ].map((item) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(dialogContext, item);
              },
              child: Text(item),
            );
          }).toList(),
        );
      },
    );

    if (!mounted) return;

    if (pilihan != null) {
      setState(() {
        outlet = pilihan;
      });
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // =================================================
          // SIDEBAR
          // =================================================

          _buildSidebar(),

          // =================================================
          // KONTEN UTAMA
          // =================================================

          Expanded(
            child: Column(
              children: [
                // =============================================
                // HEADER
                // =============================================

                Container(
                  height: 115,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 40,
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
                              'BAGI HASIL',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: darkText,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kalkulasi dan pencatatan bagi hasil mitra outlet',
                              style: TextStyle(
                                fontSize: 11,
                                color: mutedText,
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

                // =============================================
                // KARTU BAGI HASIL
                // =============================================

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double cardWidth =
                          constraints.maxWidth >= 680
                              ? 632
                              : constraints.maxWidth - 32;

                      final double cardHeight =
                          constraints.maxHeight >= 610
                              ? 575
                              : constraints.maxHeight - 24;

                      return Center(
                        child: Container(
                          width: cardWidth,
                          height: cardHeight,
                          padding: const EdgeInsets.fromLTRB(
                            55,
                            38,
                            55,
                            32,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              // =================================
                              // FILTER PERIODE DAN OUTLET
                              // =================================

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Periode',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      _filterDropdown(
                                        text: periode,
                                        width: 138,
                                        onTap: _pilihPeriode,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Outlet',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      _filterDropdown(
                                        text: outlet,
                                        width: 138,
                                        onTap: _pilihOutlet,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 58),

                              // =================================
                              // TABEL BAGI HASIL
                              // =================================

                              _buildTable(),

                              const Spacer(),

                              // =================================
                              // TOMBOL CETAK STRUK
                              // =================================

                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: 110,
                                  height: 38,
                                  child: ElevatedButton(
                                    onPressed: _cetakStruk,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: orange,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cetak Struk',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
  // SIDEBAR UTAMA
  // =====================================================

  Widget _buildSidebar() {
    return Container(
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
            // LOGO

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
              title: 'MAIN MENU',
              items: const [
                'Dashboard',
              ],
              activeItem: null,
            ),

            const SizedBox(height: 12),

            // KEUANGAN

            _sideBox(
              title: 'KEUANGAN',
              items: const [
                'Setoran',
                'Bagi Hasil',
                'Struk Transparansi',
              ],
              activeItem: 'Bagi Hasil',
            ),

            const SizedBox(height: 12),

            // LAPORAN

            _sideBox(
              title: 'LAPORAN',
              items: const [
                'Laporan Keuangan',
              ],
              activeItem: null,
            ),

            const SizedBox(height: 12),

            // AKUN — HANYA LOGOUT

            _sideBox(
              title: 'AKUN',
              items: const [
                'Logout',
              ],
              activeItem: null,
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // KOTAK MENU SIDEBAR
  // =====================================================

  Widget _sideBox({
    required String title,
    required List<String> items,
    required String? activeItem,
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
            final bool isActive = item == activeItem;

            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: InkWell(
                mouseCursor: SystemMouseCursors.click,
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  if (item == 'Logout') {
                    _showLogoutDialog();
                  } else {
                    _navigateAdmin(item);
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
          }),
        ],
      ),
    );
  }

  // =====================================================
  // DROPDOWN FILTER
  // =====================================================

  Widget _filterDropdown({
    required String text,
    required double width,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      mouseCursor: SystemMouseCursors.click,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: width,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          border: Border.all(
            color: const Color(0xFF8D9BAD),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: mutedText,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 17,
              color: mutedText,
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // TABEL BAGI HASIL
  // =====================================================

  Widget _buildTable() {
    final List<Map<String, String>> hasil = dataTerfilter;

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.3),
        1: FlexColumnWidth(1.4),
        2: FlexColumnWidth(1.3),
        3: FlexColumnWidth(0.8),
      },
      children: [
        // HEADER TABEL

        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF9EA8B5),
                width: 1,
              ),
            ),
          ),
          children: [
            _tableHeader('Outlet'),
            _tableHeader('Penjualan'),
            _tableHeader('Bagi Hasil'),
            _tableHeader('Status'),
          ],
        ),

        // DATA TABEL

        ...hasil.map((item) {
          return TableRow(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF9EA8B5),
                  width: 1,
                ),
              ),
            ),
            children: [
              _tableText(item['outlet']!),
              _tableText(item['penjualan']!),
              _tableText(item['bagiHasil']!),
              _statusText(item['status']!),
            ],
          );
        }),

        // TAMPILAN JIKA DATA KOSONG

        if (hasil.isEmpty)
          TableRow(
            children: [
              const SizedBox(
                height: 55,
                child: Center(
                  child: Text(
                    'Tidak ada data',
                    style: TextStyle(
                      fontSize: 10,
                      color: mutedText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 55),
              const SizedBox(height: 55),
              const SizedBox(height: 55),
            ],
          ),
      ],
    );
  }

  // =====================================================
  // HEADER TABEL
  // =====================================================

  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 2,
        bottom: 8,
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // =====================================================
  // ISI TABEL
  // =====================================================

  Widget _tableText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 12,
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  // =====================================================
  // STATUS BAGI HASIL
  // =====================================================

  Widget _statusText(String text) {
    final bool selesai = text == 'Selesai';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 12,
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: selesai
              ? const Color(0xFF00A64F)
              : orange,
        ),
      ),
    );
  }

  // =====================================================
  // CETAK STRUK
  // =====================================================

  void _cetakStruk() {
    if (dataTerfilter.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tidak ada data bagi hasil untuk dicetak.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Data bagi hasil siap dicetak.',
        ),
      ),
    );
  }

  // =====================================================
  // NAVIGASI ADMIN
  // =====================================================

  void _navigateAdmin(String item) {
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
  // DIALOG LOGOUT
  // =====================================================

  void _showLogoutDialog() {
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