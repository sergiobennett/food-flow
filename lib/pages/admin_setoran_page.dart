import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_struk_page.dart';
import 'admin_laporan_page.dart';

class AdminSetoranPage extends StatefulWidget {
  const AdminSetoranPage({super.key});

  @override
  State<AdminSetoranPage> createState() => _AdminSetoranPageState();
}

class _AdminSetoranPageState extends State<AdminSetoranPage> {
  static const Color orange = Color(0xFFFF6B00);
  static const Color background = Color(0xFFF2F6FB);
  static const Color mutedText = Color(0xFF60738F);
  static const Color sidebarTitle = Color(0xFF60738F);

  final TextEditingController nominalController =
      TextEditingController();

  final TextEditingController catatanController =
      TextEditingController();

  DateTime selectedDate = DateTime(2026, 9, 20);

  String outlet = '';
  String produk = '';

  @override
  void dispose() {
    nominalController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  // =====================================================
  // FORMAT TANGGAL
  // =====================================================

  String _namaBulan(int bulan) {
    const namaBulan = [
      '',
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

    return namaBulan[bulan];
  }

  String get tanggal =>
      '${selectedDate.day} '
      '${_namaBulan(selectedDate.month)} '
      '${selectedDate.year}';

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
  // PILIH PRODUK
  // =====================================================

  Future<void> _pilihProduk() async {
    final String? pilihan = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text(
            'Pilih Produk',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            'Produk A',
            'Produk B',
            'Produk C',
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
        produk = pilihan;
      });
    }
  }

  // =====================================================
  // PILIH TANGGAL
  // =====================================================

  Future<void> _pilihTanggal() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        selectedDate = picked;
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
                  height: 105,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 50,
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
                              'INPUT SETORAN',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2D42),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Masukkan data uang setoran dari outlet',
                              style: TextStyle(
                                fontSize: 9,
                                color: mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 15),

                      // ROLE ADMIN

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 3),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 17,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =============================================
                // FORM INPUT SETORAN
                // =============================================

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 560,
                        constraints: const BoxConstraints(
                          minHeight: 465,
                        ),
                        padding: const EdgeInsets.fromLTRB(
                          90,
                          20,
                          90,
                          22,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            // TANGGAL

                            _label('Tanggal'),

                            InkWell(
                              onTap: _pilihTanggal,
                              child: _field(tanggal),
                            ),

                            const SizedBox(height: 12),

                            // OUTLET

                            _label('Outlet'),

                            InkWell(
                              onTap: _pilihOutlet,
                              child: _field(
                                outlet.isEmpty
                                    ? 'Pilih Outlet ▼'
                                    : '$outlet ▼',
                              ),
                            ),

                            const SizedBox(height: 12),

                            // PRODUK

                            _label('Produk'),

                            InkWell(
                              onTap: _pilihProduk,
                              child: _field(
                                produk.isEmpty
                                    ? 'Pilih Produk ▼'
                                    : '$produk ▼',
                              ),
                            ),

                            const SizedBox(height: 12),

                            // NOMINAL SETORAN

                            _label('Nominal Setoran'),

                            _inputField(
                              controller: nominalController,
                              hint: 'Masukkan nominal uang...',
                              keyboardType: TextInputType.number,
                            ),

                            const SizedBox(height: 12),

                            // CATATAN TAMBAHAN

                            _label('Catatan Tambahan'),

                            _inputField(
                              controller: catatanController,
                              hint: 'Catatan tambahan (opsional)...',
                            ),

                            const SizedBox(height: 22),

                            // TOMBOL BATAL DAN SIMPAN

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 105,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFFD9DCE0),
                                      foregroundColor: mutedText,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Batal',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 113,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: _simpanSetoran,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: orange,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Simpan',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
              activeItem: 'Setoran',
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
  // KOTAK SIDEBAR
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
                        color: orange,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.w500,
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
  // LABEL FORM
  // =====================================================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // =====================================================
  // FIELD TAMPILAN
  // =====================================================

  Widget _field(String text) {
    return Container(
      width: double.infinity,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        border: Border.all(
          color: const Color(0xFFD0D5DA),
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 9,
          color: Color(0xFFB0B8C4),
        ),
      ),
    );
  }

  // =====================================================
  // INPUT TEXT
  // =====================================================

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        border: Border.all(
          color: const Color(0xFFD0D5DB),
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF243247),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 9,
            color: Color(0xFFB0BAC8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // SIMPAN SETORAN
  // =====================================================

  void _simpanSetoran() {
    if (outlet.isEmpty || produk.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan pilih outlet dan produk terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    if (nominalController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan masukkan nominal setoran.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Data setoran berhasil disimpan.',
        ),
      ),
    );
  }

  // =====================================================
  // DIALOG LOGOUT
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
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