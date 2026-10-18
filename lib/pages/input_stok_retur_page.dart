import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'checker_sidebar.dart';
import 'login_page.dart';
import 'checker_dashboard_page.dart';
import 'input_stok_bawaan_page.dart';
import 'distribusi_produk_page.dart';
import 'laporan_riwayat_stok_page.dart';

// =========================================================
// KONSTANTA DESAIN
// =========================================================

const Color stockReturOrange = Color(0xFFFF7100);
const Color stockReturBackground = Color(0xFFF0F5FA);
const Color stockReturDark = Color(0xFF263238);
const Color stockReturMuted = Color(0xFF718096);

// =========================================================
// INPUT STOK RETUR
// =========================================================

class InputStokReturPage extends StatefulWidget {
  const InputStokReturPage({super.key});

  @override
  State<InputStokReturPage> createState() =>
      _InputStokReturPageState();
}

class _InputStokReturPageState extends State<InputStokReturPage> {
  // =====================================================
  // DATA FORM
  // =====================================================

  DateTime selectedDate = DateTime(2026, 9, 20);

  String? selectedOutlet;
  String? selectedProduk;

  final TextEditingController jumlahReturController =
      TextEditingController();

  final TextEditingController alasanController =
      TextEditingController();

  // Data contoh untuk pilihan outlet dan produk.
  // Nantinya bisa diganti dengan data dari database.

  final List<String> daftarOutlet = const [
    'Outlet Rungkut',
    'Outlet Sukolilo',
    'Outlet Wonokromo',
  ];

  final List<String> daftarProduk = const [
    'Produk A',
    'Produk B',
    'Produk C',
  ];

  @override
  void dispose() {
    jumlahReturController.dispose();
    alasanController.dispose();
    super.dispose();
  }

  // =====================================================
  // SATU FUNGSI PESAN UNTUK SELURUH HALAMAN
  // =====================================================

  void _showMessage(
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError
              ? const Color(0xFFDC2626)
              : const Color(0xFF16A34A),
        ),
      );
  }

  // =====================================================
  // FORMAT TANGGAL
  // =====================================================

  String _monthName(int month) {
    const List<String> months = [
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

    return months[month - 1];
  }

  String _formattedDate(DateTime date) {
    return '${date.day} '
        '${_monthName(date.month)} '
        '${date.year}';
  }

  // =====================================================
  // PILIH TANGGAL
  // =====================================================

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: stockReturOrange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (!mounted || picked == null) return;

    setState(() {
      selectedDate = picked;
    });
  }

  // =====================================================
  // SIMPAN RETUR
  // =====================================================

  void _simpanRetur() {
    if (selectedOutlet == null ||
        selectedProduk == null ||
        jumlahReturController.text.trim().isEmpty) {
      _showMessage(
        'Lengkapi Outlet, Produk, dan Jumlah Retur terlebih dahulu.',
        isError: true,
      );
      return;
    }

    final int? jumlah = int.tryParse(
      jumlahReturController.text.trim(),
    );

    if (jumlah == null || jumlah <= 0) {
      _showMessage(
        'Jumlah retur harus berupa angka yang lebih dari nol.',
        isError: true,
      );
      return;
    }

    // Validasi berhasil.
    // Penyimpanan permanen membutuhkan integrasi database.

    _showMessage(
      'Data retur $selectedProduk untuk $selectedOutlet berhasil divalidasi.',
    );
  }

  // =====================================================
  // RESET FORM
  // =====================================================

  void _resetForm() {
    setState(() {
      selectedDate = DateTime(2026, 9, 20);
      selectedOutlet = null;
      selectedProduk = null;

      jumlahReturController.clear();
      alasanController.clear();
    });

    _showMessage(
      'Form berhasil dikosongkan.',
    );
  }

  // =====================================================
  // BUILD HALAMAN
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stockReturBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR CHECKER
          // Menggunakan komponen sidebar bersama.

          CheckerSidebar(
            activeItem: 'Stok Retur',
            onSelected: (item) => _handleMenuTap(context, item),
          ),

          // KONTEN UTAMA

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                28,
                28,
                45,
                25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER

                  _buildHeader(),

                  const SizedBox(height: 18),

                  // FORM INPUT RETUR

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double formWidth =
                            constraints.maxWidth >= 570
                                ? 570
                                : constraints.maxWidth;

                        return SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _buildForm(formWidth),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // HEADER
  // =====================================================

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INPUT STOK RETUR',
                style: TextStyle(
                  fontSize: 19,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  color: stockReturDark,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Masukkan data sisa stok dari outlet',
                style: TextStyle(
                  fontSize: 9,
                  color: stockReturMuted,
                ),
              ),
            ],
          ),
        ),

        // BADGE CHECKER

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: stockReturOrange,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Checker',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 3),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 19,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // FORM INPUT RETUR
  // =====================================================

  Widget _buildForm(double width) {
    final double inputWidth =
        width >= 390 ? 354 : width - 36;

    final double horizontalInset =
        (width - inputWidth) / 2;

    return Container(
      width: width,
      height: 498,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // =============================================
          // KOLOM FORM
          // =============================================

          Positioned(
            top: 18,
            left: horizontalInset,
            right: horizontalInset,
            bottom: 76,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TANGGAL

                  _label('Tanggal'),

                  _field(
                    height: 46,
                    child: InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 46,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            _formattedDate(selectedDate),
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 13),

                  // OUTLET

                  _label('Outlet'),

                  _dropdownField(
                    value: selectedOutlet,
                    hint: 'Pilih Outlet',
                    items: daftarOutlet,
                    onSelected: (value) {
                      setState(() {
                        selectedOutlet = value;
                      });
                    },
                  ),

                  const SizedBox(height: 13),

                  // PRODUK

                  _label('Produk'),

                  _dropdownField(
                    value: selectedProduk,
                    hint: 'Pilih Produk',
                    items: daftarProduk,
                    onSelected: (value) {
                      setState(() {
                        selectedProduk = value;
                      });
                    },
                  ),

                  const SizedBox(height: 13),

                  // JUMLAH RETUR

                  _label('Jumlah Retur'),

                  _field(
                    height: 46,
                    child: TextField(
                      controller: jumlahReturController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontSize: 9,
                        color: stockReturDark,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Masukkan jumlah retur...',
                        hintStyle: TextStyle(
                          fontSize: 9,
                          color: Color(0xFFB0B8C4),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 13),

                  // ALASAN RETUR

                  _label('Alasan Retur'),

                  _field(
                    height: 46,
                    child: TextField(
                      controller: alasanController,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontSize: 9,
                        color: stockReturDark,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Catatan tambahan (opsional)...',
                        hintStyle: TextStyle(
                          fontSize: 9,
                          color: Color(0xFFB0B8C4),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =============================================
          // TOMBOL BATAL DAN SIMPAN
          // =============================================

          Positioned(
            right: 18,
            bottom: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TOMBOL BATAL

                SizedBox(
                  width: 113,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5D8DD),
                      foregroundColor: const Color(0xFF64748B),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 9),

                // TOMBOL SIMPAN

                SizedBox(
                  width: 113,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _simpanRetur,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: stockReturOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
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
          ),
        ],
      ),
    );
  }

  // =====================================================
  // LABEL FORM
  // =====================================================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          height: 1.2,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // =====================================================
  // FIELD FORM
  // =====================================================

  Widget _field({
    required Widget child,
    double height = 46,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFD8DDE4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  // =====================================================
  // DROPDOWN OUTLET DAN PRODUK
  // =====================================================

  Widget _dropdownField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String> onSelected,
  }) {
    return _field(
      child: PopupMenuButton<String>(
        tooltip: hint,
        onSelected: onSelected,
        color: Colors.white,
        elevation: 6,
        constraints: const BoxConstraints(
          minWidth: 180,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        itemBuilder: (context) {
          return items.map((item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 11,
                  color: stockReturDark,
                ),
              ),
            );
          }).toList();
        },
        child: SizedBox(
          width: double.infinity,
          height: 46,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value ?? hint,
                  style: TextStyle(
                    fontSize: 9,
                    color: value == null
                        ? const Color(0xFFB0B8C4)
                        : stockReturDark,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR CHECKER
  // =====================================================

  void _handleMenuTap(
    BuildContext context,
    String item,
  ) {
    switch (item) {
      // DASHBOARD CHECKER

      case 'Dashboard':
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const CheckerDashboardPage(),
          ),
          (route) => false,
        );
        break;

      // STOK BAWAAN

      case 'Stok Bawaan':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const InputStokBawaanPage(),
          ),
        );
        break;

      // STOK RETUR

      case 'Stok Retur':
        // Sudah berada di halaman Input Stok Retur.
        break;

      // DISTRIBUSI PRODUK

      case 'Distribusi Produk':
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DistribusiPage(),
          ),
        );
        break;

      // RIWAYAT STOK

      case 'Riwayat Stok':
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LaporanRiwayatStokPage(),
          ),
        );
        break;

      // LOGOUT

      case 'Logout':
        _showLogoutDialog(context);
        break;
    }
  }

  // =====================================================
  // DIALOG LOGOUT
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
                backgroundColor: stockReturOrange,
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