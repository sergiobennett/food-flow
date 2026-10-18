import 'package:flutter/material.dart';

import 'login_page.dart';
import 'penjual_dashboard_page.dart';
import 'pengambilan_stok_page.dart';
import 'struk_transparansi_page.dart';
import 'profil_penjual_page.dart';
import 'penjual_sidebar.dart';

class KonfirmasiPengambilanPage extends StatefulWidget {
  final List<Map<String, dynamic>> menu;
  final DateTime tanggal;

  const KonfirmasiPengambilanPage({
    super.key,
    required this.menu,
    required this.tanggal,
  });

  @override
  State<KonfirmasiPengambilanPage> createState() =>
      _KonfirmasiPengambilanPageState();
}

class _KonfirmasiPengambilanPageState
    extends State<KonfirmasiPengambilanPage> {
  // =========================================================
  // WARNA
  // =========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF2E7);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);
  static const Color cancelColor = Color(0xFF484848);
  static const Color green = Color(0xFF16A34A);

  // =========================================================
  // STATE KONFIRMASI
  // =========================================================

  bool sudahDikonfirmasi = false;

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

                        // TABEL KONFIRMASI

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          child: _buildConfirmationTable(),
                        ),

                        const SizedBox(height: 18),

                        // CHECKBOX PERSETUJUAN

                        _buildAcknowledgement(),

                        const SizedBox(height: 13),

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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'KONFIRMASI PENGAMBILAN',
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
  // TABEL KONFIRMASI
  // =========================================================

  Widget _buildConfirmationTable() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          // HEADER

          Container(
            height: 35,
            color: orange,
            child: const Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      'Produk',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                _ConfirmationHeaderDivider(),

                Expanded(
                  flex: 4,
                  child: Text(
                    'Jumlah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // DATA

          if (widget.menu.isEmpty)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Belum ada produk untuk dikonfirmasi.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: greyText,
                ),
              ),
            )
          else
            ...widget.menu.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> item =
                  entry.value;

              return Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: index == widget.menu.length - 1
                          ? Colors.transparent
                          : const Color(0xFFF0F2F5),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // NAMA PRODUK

                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          item['nama'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                      ),
                    ),

                    // JUMLAH

                    Expanded(
                      flex: 4,
                      child: Text(
                        item['jumlah'].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
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
  // CHECKBOX PERSETUJUAN
  // =========================================================

  Widget _buildAcknowledgement() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          setState(() {
            sudahDikonfirmasi = !sudahDikonfirmasi;
          });
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
            vertical: 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 22,
                height: 23,
                child: Transform.scale(
                  scale: 0.75,
                  child: Checkbox(
                    value: sudahDikonfirmasi,
                    activeColor: orange,
                    onChanged: (value) {
                      setState(() {
                        sudahDikonfirmasi = value ?? false;
                      });
                    },
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),

              const SizedBox(width: 3),

              const Text(
                'Saya mengonfirmasi bahwa stok telah diterima.',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
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
          width: 87,
          height: 27,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: cancelColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
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

        const SizedBox(width: 25),

        SizedBox(
          width: 87,
          height: 27,
          child: ElevatedButton(
            onPressed: _konfirmasi,
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Konfirmasi',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // AKSI KONFIRMASI
  // =========================================================

  void _konfirmasi() {
    if (!sudahDikonfirmasi) {
      _showMessage(
        'Centang konfirmasi terlebih dahulu.',
      );
      return;
    }

    // Mengembalikan hasil ke halaman Pengambilan Stok.

    Navigator.pop(context, true);
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StrukTransparansiPage(
              menu: widget.menu,
              tanggal: widget.tanggal,
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
// PEMBATAS HEADER TABEL
// ===========================================================

class _ConfirmationHeaderDivider extends StatelessWidget {
  const _ConfirmationHeaderDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      width: 1,
      color: const Color(0x55FFFFFF),
    );
  }
}