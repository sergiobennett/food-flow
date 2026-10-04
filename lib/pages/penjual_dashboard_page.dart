import 'package:flutter/material.dart';

import 'login_page.dart';
import 'pengambilan_stok_page.dart';
import 'struk_transparansi_page.dart';
import 'profil_penjual_page.dart';

class PenjualDashboardPage extends StatefulWidget {
  const PenjualDashboardPage({super.key});

  @override
  State<PenjualDashboardPage> createState() =>
      _PenjualDashboardPageState();
}

class _PenjualDashboardPageState
    extends State<PenjualDashboardPage> {
  // =========================================================
  // DATA STOK
  // =========================================================

  List<Map<String, dynamic>> menu = [
    {
      'nama': 'Udang Keju',
      'jumlah': '10',
    },
    {
      'nama': 'Tahu Crispy',
      'jumlah': '15',
    },
    {
      'nama': 'Es Teh',
      'jumlah': '20',
    },
  ];

  DateTime tanggal = DateTime.now();

  bool sudahDikonfirmasi = true;

  // =========================================================
  // WARNA
  // =========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF0E5);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);

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
                      24,
                      18,
                      24,
                      28,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DASHBOARD PENJUAL',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Kelola pengambilan stok dan transaksi Anda.',
                          style: TextStyle(
                            fontSize: 8,
                            color: greyText,
                          ),
                        ),

                        const SizedBox(height: 18),

                        _buildGreeting(),

                        const SizedBox(height: 10),

                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildStockCard(),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              flex: 1,
                              child: _buildStatusCard(),
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

            // =================================================
            // MAIN MENU
            // =================================================

            _sectionTitle('MAIN MENU'),

            _sidebarItem(
              'Dashboard',
              selected: true,
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // =================================================
            // STOK
            // =================================================

            _sectionTitle('STOK'),

            _sidebarItem(
              'Pengambilan Stok',
              onTap: () async {
                await _openPengambilanStok();
              },
            ),

            _sidebarItem(
              'Stok',
              onTap: () {
                _showInfo('Stok');
              },
            ),

            const SizedBox(height: 16),

            // =================================================
            // TRANSAKSI
            // =================================================

            _sectionTitle('TRANSAKSI'),

            _sidebarItem(
              'Struk Transparansi',
              onTap: () {
                _openStrukTransparansi();
              },
            ),

            const SizedBox(height: 16),

            // =================================================
            // AKUN
            // =================================================

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
  // BUKA PENGAMBILAN STOK
  // =========================================================

  Future<void> _openPengambilanStok() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const PengambilanStokPage(),
      ),
    );

    if (!mounted) return;

    if (hasil != null && hasil is Map) {
      setState(() {
        if (hasil['menu'] != null) {
          menu = List<Map<String, dynamic>>.from(
            hasil['menu'],
          );
        }

        if (hasil['tanggal'] != null) {
          tanggal = hasil['tanggal'];
        }

        sudahDikonfirmasi = true;
      });
    }
  }

  // =========================================================
  // BUKA STRUK TRANSPARANSI
  // =========================================================

  void _openStrukTransparansi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StrukTransparansiPage(
          menu: menu,
          tanggal: tanggal,
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
  // CARD PENGAMBILAN STOK
  // =========================================================

  Widget _buildStockCard() {
    return Container(
      height: 235,
      padding: const EdgeInsets.fromLTRB(
        18,
        15,
        18,
        13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengambilan Stok Hari Ini',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            _formatTanggal(tanggal),
            style: const TextStyle(
              fontSize: 7,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 12),

          const Row(
            children: [
              Expanded(
                child: Text(
                  'Produk',
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                width: 40,
                child: Text(
                  'Jumlah',
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const Divider(
            height: 7,
            thickness: 0.6,
          ),

          // =================================================
          // MENU DINAMIS
          // =================================================

          Expanded(
            child: menu.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada menu',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: menu.length,
                    itemBuilder:
                        (context, index) {
                      final item =
                          menu[index];

                      return _productRow(
                        item['nama']
                            .toString(),
                        item['jumlah']
                            .toString(),
                      );
                    },
                  ),
          ),

          Align(
            alignment:
                Alignment.centerRight,
            child: SizedBox(
              width: 190,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  await _openPengambilanStok();
                },
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  foregroundColor:
                      Colors.white,
                  elevation: 0,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Konfirmasi Pengambilan',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PRODUCT ROW
  // =========================================================

  Widget _productRow(
    String produk,
    String jumlah,
  ) {
    return Container(
      height: 26,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD9D9D9),
            width: 0.7,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              produk,
              style: const TextStyle(
                fontSize: 8,
                color: darkText,
              ),
              overflow:
                  TextOverflow.ellipsis,
            ),
          ),

          SizedBox(
            width: 40,
            child: Text(
              jumlah,
              style: const TextStyle(
                fontSize: 8,
                color: orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATUS CARD
  // =========================================================

  Widget _buildStatusCard() {
    final totalProduk = menu.length;

    int totalItem = 0;

    for (final item in menu) {
      final jumlah =
          int.tryParse(
                item['jumlah']
                    .toString(),
              ) ??
              0;

      totalItem += jumlah;
    }

    return Container(
      height: 235,
      padding: const EdgeInsets.fromLTRB(
        17,
        15,
        17,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Pengambilan',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(
                sudahDikonfirmasi
                    ? Icons.check_circle
                    : Icons
                        .radio_button_unchecked,
                size: 14,
                color: sudahDikonfirmasi
                    ? Colors.green
                    : Colors.grey,
              ),

              const SizedBox(width: 4),

              Text(
                sudahDikonfirmasi
                    ? 'Sudah Dikonfirmasi'
                    : 'Menunggu Konfirmasi',
                style: TextStyle(
                  fontSize: 8,
                  color: sudahDikonfirmasi
                      ? Colors.green
                      : orange,
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalProduk.toString(),
                style: const TextStyle(
                  fontSize: 9,
                  color: darkText,
                ),
              ),

              Text(
                totalItem.toString(),
                style: const TextStyle(
                  fontSize: 9,
                  color: darkText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          const Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Produk',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),

              Text(
                'Total Item',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ],
          ),

          const Divider(
            thickness: 0.6,
          ),

          const Text(
            'Hari ini',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            _formatTanggal(tanggal),
            style: const TextStyle(
              fontSize: 6,
              color: Colors.grey,
            ),
          ),
        ],
      ),
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
        duration:
            const Duration(seconds: 1),
      ),
    );
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.fromLTRB(
            20,
            15,
            20,
            20,
          ),
          content: SizedBox(
            width: 220,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout,
                  size: 22,
                  color: Color(0xFF9A4E25),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Yakin ingin keluar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.bold,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Anda akan keluar dari akun FoodFlow saat ini.',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    color: greyText,
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 26,
                        child:
                            ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                            );
                          },
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                              0xFFD9DDE3,
                            ),
                            foregroundColor:
                                Colors.white,
                            elevation: 0,
                            padding:
                                EdgeInsets.zero,
                            shape:
                                const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .zero,
                            ),
                          ),
                          child:
                              const Text(
                            'Batal',
                            style:
                                TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 45),

                    Expanded(
                      child: SizedBox(
                        height: 26,
                        child:
                            ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                            );

                            Navigator
                                .pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const LoginPage(),
                              ),
                              (route) =>
                                  false,
                            );
                          },
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                orange,
                            foregroundColor:
                                Colors.black,
                            elevation: 0,
                            padding:
                                EdgeInsets.zero,
                            shape:
                                const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .zero,
                            ),
                          ),
                          child:
                              const Text(
                            'Ya',
                            style:
                                TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}