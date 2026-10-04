import 'package:flutter/material.dart';
import 'penjual_dashboard_page.dart';
import 'pengambilan_stok_page.dart';
import 'profil_penjual_page.dart';

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
  static const Color peach = Color(0xFFFFF0E5);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);
  static const Color blueBorder = Color(0xFF1495FF);

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        children: [
          _buildSidebar(),

          Expanded(
            child: Column(
              children: [
                _buildTopBar(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      28,
                      18,
                      28,
                      30,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Struk Transparansi',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Daftar stok yang perlu diambil hari ini.',
                          style: TextStyle(
                            fontSize: 8,
                            color: greyText,
                          ),
                        ),

                        const SizedBox(height: 18),

                        _buildGreeting(),

                        const SizedBox(height: 17),

                        Center(
                          child: _buildReceipt(),
                        ),

                        const SizedBox(height: 18),

                        Center(
                          child: SizedBox(
                            width: 70,
                            height: 22,
                            child: ElevatedButton(
                              onPressed: () {
                                _showDetail();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                foregroundColor:
                                    Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                'Lihat Detail',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight:
                                      FontWeight.bold,
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
  // SIDEBAR
  // =========================================================

  Widget _buildSidebar() {
    return Container(
      width: 177,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                28,
                30,
                20,
                25,
              ),
              child: Text(
                'FOOD FLOW',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: orange,
                ),
              ),
            ),

            _sectionTitle('MAIN MENU'),
            _sidebarItem(
              'Dashboard',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PenjualDashboardPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('STOK'),

            _sidebarItem(
              'Pengambilan Stok',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PengambilanStokPage(),
                  ),
                );
              },
            ),

            _sidebarItem(
              'Stok',
              onTap: () {
                _showInfo('Stok');
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('TRANSAKSI'),

            _sidebarItem(
              'Struk Transparansi',
              selected: true,
              onTap: () {},
            ),

            const SizedBox(height: 16),

            _sectionTitle('AKUN'),

            _sidebarItem(
              'Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfilPenjualPage(),
                  ),
                );
              },
            ),

            _sidebarItem(
              'Logout',
              logout: true,
              onTap: () {
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // TOP BAR
  // =========================================================

  Widget _buildTopBar() {
    return Container(
      height: 65,
      color: background,
      padding: const EdgeInsets.only(
        left: 28,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius:
                  BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Penjual',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(width: 4),

                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
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
        horizontal: 17,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: peach,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, Bimuy 👋',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 10),

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
  // RECEIPT
  // =========================================================

  Widget _buildReceipt() {
    return Container(
      width: 360,
      height: 430,
      padding: const EdgeInsets.fromLTRB(
        32,
        20,
        32,
        18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: blueBorder,
          width: 2.2,
        ),
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // INFORMASI
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

          const SizedBox(height: 22),

          Container(
            height: 1,
            width: 220,
            color: Colors.grey,
          ),

          const SizedBox(height: 24),

          // HEADER PRODUK
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Produk',
                  style: TextStyle(
                    fontSize: 8,
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
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // LIST PRODUK
          if (widget.menu.isEmpty)
            const Text(
              'Belum ada data produk.',
              style: TextStyle(
                fontSize: 8,
                color: Colors.grey,
              ),
            )
          else
            ...widget.menu.map(
              (item) {
                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 7,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['nama']
                              .toString(),
                          style:
                              const TextStyle(
                            fontSize: 8,
                            fontWeight:
                                FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 55,
                        child: Text(
                          item['jumlah']
                              .toString(),
                          style:
                              const TextStyle(
                            fontSize: 8,
                            fontWeight:
                                FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          const SizedBox(height: 15),

          Container(
            height: 1,
            width: 220,
            color: Colors.grey,
          ),

          const SizedBox(height: 22),

          const Text(
            'Total Penjualan : Rp350.000',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Bagi Hasil : Rp105.000',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const Spacer(),

          const Text(
            'Status',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 5),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius:
                  BorderRadius.circular(4),
            ),
            child: const Text(
              '✓ Selesai',
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RECEIPT INFO
  // =========================================================

  Widget _receiptInfo(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 55,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const Text(
            ':',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
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
  // DETAIL
  // =========================================================

  void _showDetail() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Detail Struk Transparansi',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Outlet : Rungkut',
              ),
              const Text(
                'Penjual : Andi',
              ),

              const SizedBox(height: 10),

              Text(
                'Tanggal : ${_formatTanggal(widget.tanggal)}',
              ),

              const SizedBox(height: 15),

              const Text(
                'Produk:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              ...widget.menu.map(
                (item) => Text(
                  '• ${item['nama']} : ${item['jumlah']}',
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Total Penjualan : Rp350.000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                'Bagi Hasil : Rp105.000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor:
                    Colors.white,
              ),
              child: const Text(
                'Tutup',
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String _formatTanggal(
    DateTime date,
  ) {
    const bulan = [
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
  // SECTION TITLE
  // =========================================================

  static Widget _sectionTitle(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 2,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 6,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  // =========================================================
  // SIDEBAR ITEM
  // =========================================================

  static Widget _sidebarItem(
    String title, {
    bool selected = false,
    bool logout = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(5),
        child: Container(
          height: 27,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 9,
          ),
          decoration: BoxDecoration(
            color: selected
                ? peach
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(5),
          ),
          alignment:
              Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                '•',
                style: TextStyle(
                  fontSize: 10,
                  color: logout
                      ? Colors.red
                      : selected
                          ? orange
                          : greyText,
                ),
              ),

              const SizedBox(width: 5),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 8,
                    color: logout
                        ? Colors.red
                        : selected
                            ? orange
                            : greyText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // INFO
  // =========================================================

  void _showInfo(String menuName) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '$menuName akan dibuka pada halaman berikutnya.',
        ),
      ),
    );
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  void _showLogoutDialog() {
    showDialog(
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
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Batal',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor:
                    Colors.white,
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