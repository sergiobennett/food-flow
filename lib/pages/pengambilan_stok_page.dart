import 'package:flutter/material.dart';

import 'login_page.dart';
import 'penjual_dashboard_page.dart';
import 'struk_transparansi_page.dart';
import 'profil_penjual_page.dart';
import 'konfirmasi_pengambilan_page.dart';
import 'penjual_sidebar.dart';

class PengambilanStokPage extends StatefulWidget {
  const PengambilanStokPage({super.key});

  @override
  State<PengambilanStokPage> createState() =>
      _PengambilanStokPageState();
}

class _PengambilanStokPageState
    extends State<PengambilanStokPage> {
  // =========================================================
  // WARNA
  // =========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF2E7);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);
  static const Color cancelColor = Color(0xFF777777);

  // =========================================================
  // DATA STOK
  // =========================================================

  DateTime tanggal = DateTime(2026, 9, 19);

  final List<Map<String, dynamic>> menu = [
    {
      'nama': 'Udang Keju',
      'jumlah': '15',
    },
    {
      'nama': 'Tahu Crispy',
      'jumlah': '10',
    },
    {
      'nama': 'Es Teh',
      'jumlah': '20',
    },
  ];

  bool sedangMemproses = false;

  // =========================================================
  // BUILD
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
            activeItem: 'Pengambilan Stok',
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
                      30,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // GREETING

                        _buildGreeting(),

                        const SizedBox(height: 46),

                        // TABEL PENGAMBILAN STOK

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 22,
                          ),
                          child: _buildStockTable(),
                        ),

                        const SizedBox(height: 46),

                        // TOMBOL AKSI

                        _buildActionButtons(),
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
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return SizedBox(
      height: 84,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PENGAMBILAN STOK',
                    style: TextStyle(
                      fontSize: 19,
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
  // TABEL PENGAMBILAN STOK
  // =========================================================

  Widget _buildStockTable() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          // HEADER TABEL

          Container(
            height: 32,
            color: orange,
            child: const Row(
              children: [
                Expanded(
                  child: _TableHeaderCell(
                    text: 'Produk',
                  ),
                ),
                _HeaderDivider(),
                Expanded(
                  child: _TableHeaderCell(
                    text: 'Jumlah',
                    centered: true,
                  ),
                ),
                _HeaderDivider(),
                Expanded(
                  child: _TableHeaderCell(
                    text: 'Outlet',
                    centered: true,
                  ),
                ),
                _HeaderDivider(),
                Expanded(
                  child: _TableHeaderCell(
                    text: 'Tanggal',
                    centered: true,
                  ),
                ),
              ],
            ),
          ),

          // ISI TABEL

          if (menu.isEmpty)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(22),
              child: const Text(
                'Belum ada data stok.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: greyText,
                ),
              ),
            )
          else
            ...menu.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> item =
                  entry.value;

              return Container(
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: index == menu.length - 1
                          ? Colors.transparent
                          : const Color(0xFFF0F2F5),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // PRODUK

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        child: Text(
                          item['nama'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                      ),
                    ),

                    // JUMLAH

                    Expanded(
                      child: Text(
                        item['jumlah'].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),
                    ),

                    // OUTLET

                    const Expanded(
                      child: Text(
                        'Rungkut',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),
                    ),

                    // TANGGAL

                    Expanded(
                      child: Text(
                        _formatTanggalPendek(tanggal),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  // =========================================================
  // TOMBOL BATAL DAN KONFIRMASI
  // =========================================================

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 114,
          height: 29,
          child: ElevatedButton(
            onPressed: sedangMemproses
                ? null
                : () {
                    Navigator.pop(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: cancelColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: cancelColor,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        const SizedBox(width: 17),

        SizedBox(
          width: 114,
          height: 29,
          child: ElevatedButton(
            onPressed:
                sedangMemproses ? null : _bukaKonfirmasi,
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              foregroundColor: Colors.white,
              disabledBackgroundColor: orange,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: sedangMemproses
                ? const SizedBox(
                    width: 13,
                    height: 13,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Konfirmasi Pengambilan',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BUKA HALAMAN KONFIRMASI
  // =========================================================

  Future<void> _bukaKonfirmasi() async {
    if (menu.isEmpty) {
      _showMessage(
        'Belum ada produk yang bisa dikonfirmasi.',
      );
      return;
    }

    for (final item in menu) {
      final String nama =
          item['nama'].toString().trim();

      final int? jumlah = int.tryParse(
        item['jumlah'].toString(),
      );

      if (nama.isEmpty || jumlah == null || jumlah < 1) {
        _showMessage(
          'Data nama produk dan jumlah stok belum valid.',
        );
        return;
      }
    }

    final List<Map<String, dynamic>> dataMenu = menu
        .map(
          (item) => <String, dynamic>{
            'nama': item['nama'].toString(),
            'jumlah': item['jumlah'].toString(),
          },
        )
        .toList();

    setState(() {
      sedangMemproses = true;
    });

    final bool? hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => KonfirmasiPengambilanPage(
          menu: dataMenu,
          tanggal: tanggal,
        ),
      ),
    );

    if (!mounted) return;

    setState(() {
      sedangMemproses = false;
    });

    if (hasil == true) {
      Navigator.pop(
        context,
        {
          'menu': dataMenu,
          'tanggal': tanggal,
        },
      );
    }
  }

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String _formatTanggalPendek(DateTime date) {
    const List<String> bulan = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
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
        // Sudah berada di halaman ini.
        break;

      case 'Stok':
        _showMessage(
          'Halaman Stok belum tersedia.',
        );
        break;

      case 'Struk Transparansi':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StrukTransparansiPage(
              menu: menu
                  .map(
                    (item) => <String, dynamic>{
                      'nama': item['nama'],
                      'jumlah': item['jumlah'],
                    },
                  )
                  .toList(),
              tanggal: tanggal,
            ),
          ),
        );
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

// ===========================================================
// WIDGET HEADER TABEL
// ===========================================================

class _TableHeaderCell extends StatelessWidget {
  final String text;
  final bool centered;

  const _TableHeaderCell({
    required this.text,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Align(
        alignment: centered
            ? Alignment.center
            : Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  const _HeaderDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 17,
      color: const Color(0x55FFFFFF),
    );
  }
}