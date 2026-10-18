import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'checker_sidebar.dart';
import 'login_page.dart';
import 'input_stok_retur_page.dart';
import 'distribusi_produk_page.dart';
import 'laporan_riwayat_stok_page.dart';

// =========================================================
// KONSTANTA DESAIN
// =========================================================

const Color stockOrange = Color(0xFFFF7100);
const Color stockBackground = Color(0xFFF0F5FA);
const Color stockDark = Color(0xFF263238);
const Color stockMuted = Color(0xFF718096);

// =========================================================
// INPUT STOK BAWAAN
// =========================================================

class InputStokBawaanPage extends StatefulWidget {
  const InputStokBawaanPage({super.key});

  @override
  State<InputStokBawaanPage> createState() =>
      _InputStokBawaanPageState();
}

class _InputStokBawaanPageState extends State<InputStokBawaanPage> {
  // =====================================================
  // DATA FORM
  // =====================================================

  DateTime selectedDate = DateTime(2026, 9, 20);

  String? selectedOutlet;
  String? selectedProduk;

  final TextEditingController jumlahController =
      TextEditingController();

  final TextEditingController keteranganController =
      TextEditingController();

  // Data contoh untuk dropdown.
  // Nantinya dapat diganti dengan data dari database.
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
    jumlahController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  // =====================================================
  // FORMAT TANGGAL
  // =====================================================

  String _monthName(int month) {
    const months = [
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
    return '${date.day} ${_monthName(date.month)} ${date.year}';
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
              primary: stockOrange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // =====================================================
  // SIMPAN STOK
  // =====================================================

  void _simpanStok() {
    if (selectedOutlet == null ||
        selectedProduk == null ||
        jumlahController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lengkapi Outlet, Produk, dan Jumlah Stok terlebih dahulu.',
          ),
          backgroundColor: Color(0xFFDC2626),
        ),
      );

      return;
    }

    final int? jumlah =
        int.tryParse(jumlahController.text.trim());

    if (jumlah == null || jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Jumlah stok harus berupa angka yang lebih dari nol.',
          ),
          backgroundColor: Color(0xFFDC2626),
        ),
      );

      return;
    }

    // Data sudah tervalidasi.
    // Penyimpanan permanen membutuhkan integrasi database.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Data stok ${selectedProduk!} untuk $selectedOutlet berhasil divalidasi.',
        ),
        backgroundColor: const Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BATAL / RESET FORM
  // =====================================================

  void _resetForm() {
    setState(() {
      selectedDate = DateTime(2026, 9, 20);
      selectedOutlet = null;
      selectedProduk = null;

      jumlahController.clear();
      keteranganController.clear();
    });
  }

  // =====================================================
  // BUILD HALAMAN
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stockBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR CHECKER
          // Menggunakan komponen sidebar bersama.
          // Desain mengikuti Dashboard Checker.

          CheckerSidebar(
            activeItem: 'Stok Bawaan',
            onSelected: (item) => _handleMenuTap(context, item),
          ),

          // KONTEN UTAMA

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                25,
                48,
                30,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER

                  _buildHeader(),

                  const SizedBox(height: 24),

                  // FORM INPUT STOK

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double formWidth =
                            constraints.maxWidth >= 510
                                ? 510
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
                'INPUT STOK BAWAAN',
                style: TextStyle(
                  fontSize: 19,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  color: stockDark,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Masukkan data stok awal sebelum distribusi',
                style: TextStyle(
                  fontSize: 9,
                  color: stockMuted,
                ),
              ),
            ],
          ),
        ),

        // ROLE CHECKER

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: stockOrange,
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
                size: 19,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // FORM INPUT STOK BAWAAN
  // =====================================================

  Widget _buildForm(double width) {
    final double horizontalInset =
        width >= 366 ? (width - 330) / 2 : 18;

    return Container(
      width: width,
      height: 463,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
            bottom: 73,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TANGGAL

                _label('Tanggal'),

                _field(
                  child: InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
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

                const SizedBox(height: 9),

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

                const SizedBox(height: 9),

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

                const SizedBox(height: 9),

                // JUMLAH STOK

                _label('Jumlah Stok'),

                _field(
                  child: TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 9,
                      color: stockDark,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Masukkan jumlah stok...',
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

                const SizedBox(height: 9),

                // KETERANGAN

                _label('Keterangan'),

                _field(
                  child: TextField(
                    controller: keteranganController,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 9,
                      color: stockDark,
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
                  width: 105,
                  height: 38,
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
                  width: 105,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: _simpanStok,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: stockOrange,
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
      padding: const EdgeInsets.only(bottom: 5),
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
    double height = 44,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFD8DDE4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
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
        elevation: 5,
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
                  color: stockDark,
                ),
              ),
            );
          }).toList();
        },
        child: SizedBox(
          width: double.infinity,
          height: 44,
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
                        : stockDark,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 15,
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
  // NAVIGASI SIDEBAR
  // =====================================================

  void _handleMenuTap(
    BuildContext context,
    String item,
  ) {
    switch (item) {
      case 'Dashboard':
        // Kembali ke halaman utama Dashboard Checker.
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        break;

      case 'Stok Bawaan':
        // Sudah berada di halaman Input Stok Bawaan.
        break;

      case 'Stok Retur':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const InputStokReturPage(),
          ),
        );
        break;

      case 'Distribusi Produk':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DistribusiPage(),
          ),
        );
        break;

      case 'Riwayat Stok':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const LaporanRiwayatStokPage(),
          ),
        );
        break;

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
                backgroundColor: stockOrange,
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