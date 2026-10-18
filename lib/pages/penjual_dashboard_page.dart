import 'package:flutter/material.dart';

import 'login_page.dart';
import 'pengambilan_stok_page.dart';
import 'struk_transparansi_page.dart';
import 'profil_penjual_page.dart';
import 'penjual_sidebar.dart';

class PenjualDashboardPage extends StatefulWidget {
  const PenjualDashboardPage({super.key});

  @override
  State<PenjualDashboardPage> createState() =>
      _PenjualDashboardPageState();
}

class _PenjualDashboardPageState
    extends State<PenjualDashboardPage> {
  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF2E7);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);

  // =========================================================
  // DATA STOK
  // =========================================================

  List<Map<String, dynamic>> menu = [
    {'nama': 'Udang Keju', 'jumlah': '10'},
    {'nama': 'Udang Rambutan', 'jumlah': '15'},
    {'nama': 'Siomay', 'jumlah': '20'},
  ];

  DateTime tanggal = DateTime.now();
  bool sudahDikonfirmasi = false;

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
          // SIDEBAR PENJUAL

          PenjualSidebar(
            activeItem: 'Dashboard',
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
                      30,
                      12,
                      30,
                      28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SALAM PENJUAL

                        _buildGreeting(),

                        const SizedBox(height: 15),

                        // KARTU STOK DAN STATUS

                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth < 650) {
                              return Column(
                                children: [
                                  _buildStockCard(),

                                  const SizedBox(height: 15),

                                  _buildStatusCard(),
                                ],
                              );
                            }

                            return Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: _buildStockCard(),
                                ),

                                const SizedBox(width: 20),

                                Expanded(
                                  flex: 4,
                                  child: _buildStatusCard(),
                                ),
                              ],
                            );
                          },
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
  // HEADER DASHBOARD
  // BADGE AKTOR STATIS, TIDAK BISA PINDAH AKTOR
  // =========================================================

  Widget _buildHeader() {
    return Container(
      height: 105,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DASHBOARD PENJUAL',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Kelola pengambilan stok dan transaksi Anda.',
                  style: TextStyle(
                    fontSize: 11,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          // BADGE ORANYE STATIS
          // PANAH HANYA TAMPILAN, BUKAN DROPDOWN

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Penjual',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(width: 2),

                Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // KARTU SALAM
  // =========================================================

  Widget _buildGreeting() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
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
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 15),

          Text(
            'OUTLET RUNGKUT',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // KARTU PENGAMBILAN STOK
  // =========================================================

  Widget _buildStockCard() {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        17,
        20,
        14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengambilan Stok Hari Ini',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            _formatTanggal(tanggal),
            style: const TextStyle(
              fontSize: 10,
              color: greyText,
            ),
          ),

          const SizedBox(height: 18),

          // HEADER TABEL PRODUK

          const Row(
            children: [
              Expanded(
                child: Text(
                  'Produk',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                width: 65,
                child: Text(
                  'Jumlah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const Divider(
            color: Color(0xFFB8C0CC),
            height: 12,
          ),

          // DAFTAR PRODUK

          Expanded(
            child: menu.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada produk.',
                      style: TextStyle(
                        fontSize: 11,
                        color: greyText,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final item = menu[index];

                      return Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE0E5EA),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item['nama'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: darkText,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 65,
                              child: Text(
                                item['jumlah'].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 8),

          // TOMBOL KONFIRMASI

          SizedBox(
            height: 34,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _openPengambilanStok,
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Konfirmasi Pengambilan',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // KARTU STATUS PENGAMBILAN
  // =========================================================

  Widget _buildStatusCard() {
    final int totalProduk = menu.length;

    final int totalItem = menu.fold<int>(
      0,
      (total, item) =>
          total +
          (int.tryParse(item['jumlah'].toString()) ?? 0),
    );

    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Pengambilan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 12),

          // STATUS KONFIRMASI

          Row(
            children: [
              Icon(
                sudahDikonfirmasi
                    ? Icons.check_circle
                    : Icons.access_time,
                size: 18,
                color: sudahDikonfirmasi
                    ? Colors.green
                    : orange,
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  sudahDikonfirmasi
                      ? 'Sudah Dikonfirmasi'
                      : 'Menunggu Konfirmasi',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: sudahDikonfirmasi
                        ? Colors.green
                        : orange,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // RINGKASAN PRODUK

          _buildStatusRow(
            '$totalProduk',
            'Produk',
          ),

          const SizedBox(height: 12),

          _buildStatusRow(
            '$totalItem',
            'Total Item',
          ),

          const Divider(height: 25),

          const Text(
            'Hari ini',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            _formatTanggal(tanggal),
            style: const TextStyle(
              fontSize: 10,
              color: greyText,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BARIS STATUS
  // =========================================================

  Widget _buildStatusRow(
    String number,
    String label,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BUKA HALAMAN PENGAMBILAN STOK
  // =========================================================

  Future<void> _openPengambilanStok() async {
    final dynamic hasil = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute(
        builder: (_) => const PengambilanStokPage(),
      ),
    );

    if (!mounted || hasil is! Map) return;

    setState(() {
      final dynamic dataMenu = hasil['menu'];

      if (dataMenu is List) {
        menu = List<Map<String, dynamic>>.from(dataMenu);
      }

      final dynamic dataTanggal = hasil['tanggal'];

      if (dataTanggal is DateTime) {
        tanggal = dataTanggal;
      }

      sudahDikonfirmasi = true;
    });
  }

  // =========================================================
  // BUKA STRUK TRANSPARANSI
  // =========================================================

  void _openStrukTransparansi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StrukTransparansiPage(
          menu: menu,
          tanggal: tanggal,
        ),
      ),
    );
  }

  // =========================================================
  // NAVIGASI SIDEBAR PENJUAL
  // =========================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        // Sudah berada di Dashboard Penjual.
        break;

      case 'Pengambilan Stok':
        _openPengambilanStok();
        break;

      case 'Stok':
        _showInfo('Stok');
        break;

      case 'Struk Transparansi':
        _openStrukTransparansi();
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
  // NOTIFIKASI
  // =========================================================

  void _showInfo(String menuName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '$menuName akan dibuka pada halaman berikutnya.',
          ),
        ),
      );
  }

  // =========================================================
  // DIALOG LOGOUT
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