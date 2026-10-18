import 'package:flutter/material.dart';

import 'login_page.dart';
import 'penjual_dashboard_page.dart';
import 'pengambilan_stok_page.dart';
import 'profil_penjual_page.dart';
import 'penjual_sidebar.dart';

class StrukTransparansiPage extends StatefulWidget {
  final List<Map<String, dynamic>> menu;
  final DateTime tanggal;

  const StrukTransparansiPage({
    super.key,
    required this.menu,
    required this.tanggal,
  });

  @override
  State<StrukTransparansiPage> createState() =>
      _StrukTransparansiPageState();
}

class _StrukTransparansiPageState
    extends State<StrukTransparansiPage> {
  // =========================================================
  // WARNA
  // =========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF2E7);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);
  static const Color blueBorder = Color(0xFF1495FF);

  // =========================================================
  // BUILD HALAMAN
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR

          PenjualSidebar(
            activeItem: 'Struk Transparansi',
            onSelected: _handleSidebarTap,
          ),

          // KONTEN UTAMA

          Expanded(
            child: Column(
              children: [
                _buildHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      24,
                      10,
                      24,
                      25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GREETING OUTLET

                        _buildGreeting(),

                        const SizedBox(height: 14),

                        // KARTU STRUK

                        Center(
                          child: _buildReceipt(),
                        ),

                        const SizedBox(height: 15),

                        // TOMBOL DETAIL

                        Center(
                          child: SizedBox(
                            width: 88,
                            height: 28,
                            child: ElevatedButton(
                              onPressed: _showDetail,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                foregroundColor: Colors.black,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Lihat Detail',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

  // =========================================================
  // HEADER HALAMAN
  // =========================================================

  Widget _buildHeader() {
    return SizedBox(
      height: 84,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Struk Transparansi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: darkText,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Daftar stok yang perlu diambil hari ini.',
                    style: TextStyle(
                      fontSize: 9,
                      color: greyText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // ROLE PENJUAL

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Penjual',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 15,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // GREETING
  // =========================================================

  Widget _buildGreeting() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: peach,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, Bimuy 👋',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'OUTLET RUNGKUT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // KARTU STRUK
  // =========================================================

  Widget _buildReceipt() {
    final int totalItem = widget.menu.fold<int>(
      0,
      (total, item) =>
          total +
          (int.tryParse(item['jumlah'].toString()) ?? 0),
    );

    return Container(
      width: 300,
      constraints: const BoxConstraints(
        maxWidth: 360,
      ),
      height: 342,
      padding: const EdgeInsets.fromLTRB(
        26,
        19,
        26,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // INFORMASI OUTLET

          _receiptInfo(
            'Outlet',
            'Rungkut',
          ),

          _receiptInfo(
            'Penjual',
            'Andi',
          ),

          _receiptInfo(
            'Tanggal',
            _formatTanggal(widget.tanggal),
          ),

          const SizedBox(height: 15),

          // GARIS PEMISAH

          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFF999999),
          ),

          const SizedBox(height: 18),

          // HEADER PRODUK

          const Row(
            children: [
              Expanded(
                child: Text(
                  'Produk',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 55,
                child: Text(
                  'Jumlah',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          // DAFTAR PRODUK

          if (widget.menu.isEmpty)
            const Text(
              'Belum ada data produk.',
              style: TextStyle(
                fontSize: 9,
                color: greyText,
              ),
            )
          else
            ...widget.menu.map((item) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['nama'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 55,
                      child: Text(
                        item['jumlah'].toString(),
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 15),

          // GARIS PEMISAH

          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFF999999),
          ),

          const SizedBox(height: 17),

          // TOTAL PENJUALAN

          const Text(
            'Total Penjualan : Rp350.000',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 15),

          // BAGI HASIL

          const Text(
            'Bagi Hasil : Rp105.000',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          // MENDORONG STATUS KE BAGIAN BAWAH

          const Spacer(),

          // STATUS

          const Text(
            'Status',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 5),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF39CD70),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              '✓ Selesai',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // INFORMASI STRUK
  // =========================================================

  Widget _receiptInfo(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 3,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 39,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black,
              ),
            ),
          ),

          const Text(
            ':',
            style: TextStyle(
              fontSize: 9,
              color: Colors.black,
            ),
          ),

          const SizedBox(width: 5),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // DIALOG DETAIL
  // =========================================================

  void _showDetail() {
    final int totalItem = widget.menu.fold<int>(
      0,
      (total, item) =>
          total +
          (int.tryParse(item['jumlah'].toString()) ?? 0),
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Detail Struk Transparansi',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Outlet : Rungkut'),
                const Text('Penjual : Andi'),

                Text(
                  'Tanggal : ${_formatTanggal(widget.tanggal)}',
                ),

                const SizedBox(height: 12),

                const Text(
                  'Daftar Produk:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                ...widget.menu.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: Text(
                      '${item['nama']} : ${item['jumlah']}',
                    ),
                  );
                }),

                const SizedBox(height: 12),

                Text(
                  'Total Item : $totalItem',
                ),

                const SizedBox(height: 8),

                const Text(
                  'Total Penjualan : Rp350.000',
                ),

                const Text(
                  'Bagi Hasil : Rp105.000',
                ),

                const SizedBox(height: 8),

                const Text(
                  'Status : Selesai',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.black,
              ),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String _formatTanggal(DateTime date) {
    const List<String> bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${date.day} '
        '${bulan[date.month - 1]} '
        '${date.year}';
  }

  // =========================================================
  // NAVIGASI SIDEBAR
  // =========================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PenjualDashboardPage(),
          ),
        );
        break;

      case 'Pengambilan Stok':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const PengambilanStokPage(),
          ),
        );
        break;

      case 'Stok':
        _showMessage(
          'Halaman Stok belum tersedia.',
        );
        break;

      case 'Struk Transparansi':
        // Sudah berada di halaman ini.
        break;

      case 'Profil':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfilPenjualPage(),
          ),
        );
        break;

      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  // =========================================================
  // PESAN
  // =========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Yakin ingin keluar?',
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