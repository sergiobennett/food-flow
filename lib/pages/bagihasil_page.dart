import 'package:flutter/material.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'laporan_page.dart';
import 'owner_sidebar.dart';

// =========================================================
// KONSTANTA WARNA
// =========================================================

const Color bhOrange = Color(0xFFFF7100);
const Color bhBackground = Color(0xFFF0F5FA);
const Color bhDark = Color(0xFF1E293B);
const Color bhNavy = Color(0xFF031C2B);
const Color bhNavyLight = Color(0xFF0A2D40);

// =========================================================
// HALAMAN DAFTAR BAGI HASIL
// =========================================================

class BagiHasilPage extends StatefulWidget {
  const BagiHasilPage({super.key});

  @override
  State<BagiHasilPage> createState() => _BagiHasilPageState();
}

class _BagiHasilPageState extends State<BagiHasilPage> {
  final TextEditingController searchController =
      TextEditingController();

  String search = '';

  // =====================================================
  // DATA AWAL SESUAI FIGMA
  // =====================================================

  final List<Map<String, String>> data = [
    {
      'kode': 'BH001',
      'tgl': '21 Sep 2026',
      'outlet': 'A',
      'penjual': 'Andi',
      'penjualan': '500.000',
      'retur': '0',
      'bersih': '500.000',
      'bagi': '500.000',
      'status': 'Proses',
    },
    {
      'kode': 'BH002',
      'tgl': '21 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'penjualan': '450.000',
      'retur': '0',
      'bersih': '450.000',
      'bagi': '200.000',
      'status': 'Selesai',
    },
    {
      'kode': 'BH003',
      'tgl': '22 Sep 2026',
      'outlet': 'C',
      'penjual': 'Citra',
      'penjualan': '600.000',
      'retur': '0',
      'bersih': '600.000',
      'bagi': '90.000',
      'status': 'Selesai',
    },
    {
      'kode': 'BH004',
      'tgl': '22 Sep 2026',
      'outlet': 'D',
      'penjual': 'Bnnet',
      'penjualan': '500.000',
      'retur': '0',
      'bersih': '500.000',
      'bagi': '100.000',
      'status': 'Proses',
    },
    {
      'kode': 'BH005',
      'tgl': '23 Sep 2026',
      'outlet': 'C',
      'penjual': 'Citra',
      'penjualan': '600.000',
      'retur': '0',
      'bersih': '600.000',
      'bagi': '90.000',
      'status': 'Selesai',
    },
    {
      'kode': 'BH006',
      'tgl': '23 Sep 2026',
      'outlet': 'D',
      'penjual': 'Bnnet',
      'penjualan': '500.000',
      'retur': '0',
      'bersih': '500.000',
      'bagi': '100.000',
      'status': 'Proses',
    },
    {
      'kode': 'BH007',
      'tgl': '24 Sep 2026',
      'outlet': 'A',
      'penjual': 'Andi',
      'penjualan': '500.000',
      'retur': '0',
      'bersih': '500.000',
      'bagi': '500.000',
      'status': 'Proses',
    },
  ];

  // =====================================================
  // PENCARIAN
  // =====================================================

  List<Map<String, String>> get dataFilter {
    if (search.trim().isEmpty) {
      return data;
    }

    final query = search.toLowerCase().trim();

    return data.where((item) {
      return item.values.any(
        (value) => value.toLowerCase().contains(query),
      );
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // PROSES BAGI HASIL BARU
  // =====================================================

  Future<void> _prosesBagiHasil() async {
    int nomorTerbesar = 0;

    for (final item in data) {
      final match = RegExp(
        r'^BH(\d+)$',
      ).firstMatch(item['kode'] ?? '');

      if (match != null) {
        final nomor = int.parse(match.group(1)!);

        if (nomor > nomorTerbesar) {
          nomorTerbesar = nomor;
        }
      }
    }

    final kodeBaru =
        'BH${(nomorTerbesar + 1).toString().padLeft(3, '0')}';

    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailBagiHasilPage(
          kode: kodeBaru,
          isNew: true,
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    setState(() {
      data.add(hasil);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bagi hasil berhasil ditambahkan.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // DETAIL BAGI HASIL
  // =====================================================

  Future<void> _bukaDetail(
    Map<String, String> item,
  ) async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailBagiHasilPage(
          kode: item['kode'],
          initialData: Map<String, String>.from(item),
          isNew: false,
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    final index = data.indexWhere(
      (element) => element['kode'] == item['kode'],
    );

    if (index == -1) return;

    setState(() {
      data[index] = hasil;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data bagi hasil berhasil diperbarui.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BUILD HALAMAN UTAMA
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bhBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER BERSAMA
          _BagiHasilSidebar(
            onBagiHasilTap: () {},
          ),

          // KONTEN UTAMA
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                30,
                52,
                30,
                25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =========================================
                  // HEADER
                  // =========================================

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BAGI HASIL',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: bhDark,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kelola dan pantau pembagian hasil penjualan harian.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _BagiHasilOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // =========================================
                  // SEARCH DAN TOMBOL PROSES
                  // =========================================

                  Row(
                    children: [
                      Container(
                        width: 264,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          },
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF334155),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Cari bagi hasil...',
                            hintStyle: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF94A3B8),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 14,
                              color: Color(0xFF64748B),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 30,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 7,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton(
                        onPressed: _prosesBagiHasil,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bhOrange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23,
                            vertical: 11,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Proses Bagi Hasil',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // =========================================
                  // TABEL BAGI HASIL
                  // =========================================

                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: double.infinity,
                        height: 355,
                        child: _buildTable(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // =========================================
                  // KEMBALI
                  // =========================================

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DashboardPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bhOrange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'KEMBALI',
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
          ),
        ],
      ),
    );
  }

  // =====================================================
  // TABEL BAGI HASIL
  // =====================================================

  Widget _buildTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              height: 36,
              color: const Color(0xFFFF762E),
              child: Row(
                children: [
                  _headerCell('KODE', 10),
                  _headerDivider(),
                  _headerCell('TGL', 10),
                  _headerDivider(),
                  _headerCell('OUTLET', 10),
                  _headerDivider(),
                  _headerCell('PENJUAL', 11),
                  _headerDivider(),
                  _headerCell('PENJUALAN', 13),
                  _headerDivider(),
                  _headerCell('BAGI HASIL', 13),
                  _headerDivider(),
                  _headerCell('STATUS', 11),
                  _headerDivider(),
                  _headerCell('AKSI', 10),
                ],
              ),
            ),
          ),

          // ISI TABEL
          Expanded(
            child: dataFilter.isEmpty
                ? const Center(
                    child: Text(
                      'Data bagi hasil tidak ditemukan.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: dataFilter.length,
                    separatorBuilder: (_, __) {
                      return const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Color(0xFFE9EEF4),
                      );
                    },
                    itemBuilder: (context, index) {
                      final item = dataFilter[index];

                      return Container(
                        height: 37,
                        color: index.isOdd
                            ? const Color(0xFFF6F8FB)
                            : Colors.white,
                        child: Row(
                          children: [
                            // KODE
                            Expanded(
                              flex: 10,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0F4F8),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Text(
                                    item['kode'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF334155),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            _bodyDivider(),

                            // TANGGAL
                            _bodyCell(
                              item['tgl'] ?? '',
                              10,
                            ),

                            _bodyDivider(),

                            // OUTLET
                            _bodyCell(
                              item['outlet'] ?? '',
                              10,
                            ),

                            _bodyDivider(),

                            // PENJUAL
                            _bodyCell(
                              item['penjual'] ?? '',
                              11,
                            ),

                            _bodyDivider(),

                            // PENJUALAN
                            _bodyCell(
                              item['penjualan'] ?? '0',
                              13,
                              bold: true,
                            ),

                            _bodyDivider(),

                            // BAGI HASIL
                            _bodyCell(
                              item['bagi'] ?? '0',
                              13,
                              bold: true,
                            ),

                            _bodyDivider(),

                            // STATUS
                            Expanded(
                              flex: 11,
                              child: Center(
                                child: _statusBadge(
                                  item['status'] ?? 'Proses',
                                ),
                              ),
                            ),

                            _bodyDivider(),

                            // DETAIL
                            Expanded(
                              flex: 10,
                              child: Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _bukaDetail(item);
                                  },
                                  icon: const Icon(
                                    Icons.description_outlined,
                                    size: 13,
                                  ),
                                  label: const Text(
                                    'Detail',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFFFFF0E7),
                                    foregroundColor:
                                        const Color(0xFFFF6B00),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 6,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // HEADER CELL
  // =====================================================

  Widget _headerCell(
    String title,
    int flex,
  ) {
    return Expanded(
      flex: flex,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerDivider() {
    return Container(
      width: 1,
      height: 18,
      color: Colors.white.withOpacity(0.25),
    );
  }

  Widget _bodyDivider() {
    return Container(
      width: 1,
      height: double.infinity,
      color: const Color(0xFFF0F3F7),
    );
  }

  Widget _bodyCell(
    String text,
    int flex, {
    bool bold = false,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // STATUS BAGI HASIL
  // =====================================================

  Widget _statusBadge(String status) {
    final bool selesai = status == 'Selesai';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: selesai
            ? const Color(0xFFDFF7E3)
            : const Color(0xFFFFF0E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selesai
                ? Icons.check_circle
                : Icons.access_time,
            size: 12,
            color: selesai
                ? const Color(0xFF009B39)
                : const Color(0xFFFF7900),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: selesai
                  ? const Color(0xFF008C32)
                  : const Color(0xFFE36D00),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// HALAMAN DETAIL BAGI HASIL
// =========================================================

class DetailBagiHasilPage extends StatefulWidget {
  final String? kode;
  final Map<String, String>? initialData;
  final bool isNew;

  const DetailBagiHasilPage({
    super.key,
    this.kode,
    this.initialData,
    this.isNew = false,
  });

  @override
  State<DetailBagiHasilPage> createState() =>
      _DetailBagiHasilPageState();
}

class _DetailBagiHasilPageState
    extends State<DetailBagiHasilPage> {
  late final TextEditingController tanggalController;
  late final TextEditingController penjualanController;
  late final TextEditingController returController;
  late final TextEditingController bagiController;

  String? outlet;
  String? penjual;

  static const List<String> daftarOutlet = [
    'Outlet A',
    'Outlet B',
    'Outlet C',
    'Outlet D',
  ];

  static const List<String> daftarPenjual = [
    'Andi',
    'Budi',
    'Citra',
    'Bnnet',
  ];

  @override
  void initState() {
    super.initState();

    final initial = widget.initialData;

    tanggalController = TextEditingController(
      text: initial?['tgl'] ?? '',
    );

    penjualanController = TextEditingController(
      text: initial?['penjualan'] ?? '',
    );

    returController = TextEditingController(
      text: initial?['retur'] ?? '',
    );

    bagiController = TextEditingController(
      text: initial?['bagi'] ?? '',
    );

    // Ambil nilai awal apabila membuka detail data.
    if (initial != null) {
      final String? outletAwal = initial['outlet'];

      if (outletAwal != null) {
        final String namaOutlet = outletAwal.startsWith('Outlet ')
            ? outletAwal
            : 'Outlet $outletAwal';

        if (daftarOutlet.contains(namaOutlet)) {
          outlet = namaOutlet;
        }
      }

      final String? penjualAwal = initial['penjual'];

      if (penjualAwal != null &&
          daftarPenjual.contains(penjualAwal)) {
        penjual = penjualAwal;
      }
    }
  }

  @override
  void dispose() {
    tanggalController.dispose();
    penjualanController.dispose();
    returController.dispose();
    bagiController.dispose();
    super.dispose();
  }

  // =====================================================
  // FORMAT RUPIAH
  // =====================================================

  int _parseMoney(String value) {
    final digits = value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    return int.tryParse(digits) ?? 0;
  }

  String _formatMoney(int number) {
    final digits = number.toString();

    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  String _hitungPenjualanBersih() {
    if (penjualanController.text.trim().isEmpty &&
        returController.text.trim().isEmpty) {
      return '';
    }

    final penjualan = _parseMoney(
      penjualanController.text,
    );

    final retur = _parseMoney(
      returController.text,
    );

    final bersih = penjualan - retur;

    if (bersih < 0) {
      return '-${_formatMoney(bersih.abs())}';
    }

    return _formatMoney(bersih);
  }

  // =====================================================
  // PEMILIHAN TANGGAL
  // =====================================================

  Future<void> _pilihTanggal() async {
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

    DateTime initialDate = DateTime(2026, 9, 21);

    final parts = tanggalController.text.split(' ');

    if (parts.length >= 3) {
      final day = int.tryParse(parts[0]);
      final monthIndex = bulan.indexOf(parts[1]);
      final year = int.tryParse(parts[2]);

      if (day != null &&
          monthIndex >= 0 &&
          year != null &&
          day >= 1 &&
          day <= 31) {
        initialDate = DateTime(
          year,
          monthIndex + 1,
          day,
        );
      }
    }

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: bhOrange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null || !mounted) return;

    setState(() {
      tanggalController.text =
          '${selectedDate.day} '
          '${bulan[selectedDate.month - 1]} '
          '${selectedDate.year}';
    });
  }

  // =====================================================
  // SIMPAN BAGI HASIL
  // =====================================================

  void _simpanBagiHasil() {
    if (tanggalController.text.trim().isEmpty) {
      _pesan('Silakan pilih tanggal.');
      return;
    }

    if (outlet == null) {
      _pesan('Silakan pilih outlet.');
      return;
    }

    if (penjual == null) {
      _pesan('Silakan pilih penjual.');
      return;
    }

    if (penjualanController.text.trim().isEmpty) {
      _pesan('Total penjualan wajib diisi.');
      return;
    }

    final int penjualan = _parseMoney(
      penjualanController.text,
    );

    final int retur = _parseMoney(
      returController.text,
    );

    if (penjualan <= 0) {
      _pesan('Total penjualan harus lebih dari 0.');
      return;
    }

    if (retur > penjualan) {
      _pesan('Total retur tidak boleh melebihi total penjualan.');
      return;
    }

    if (bagiController.text.trim().isEmpty) {
      _pesan('Bagi hasil wajib diisi.');
      return;
    }

    final int jumlahBagiHasil = _parseMoney(
      bagiController.text,
    );

    if (jumlahBagiHasil < 0) {
      _pesan('Nilai bagi hasil tidak valid.');
      return;
    }

    final String tanggal = tanggalController.text.trim();

    final String outletSingkat =
        outlet!.replaceFirst('Outlet ', '');

    final int bersih = penjualan - retur;

    final Map<String, String> hasil = {
      'kode': widget.kode ?? 'BH001',
      'tgl': tanggal,
      'outlet': outletSingkat,
      'penjual': penjual!,
      'penjualan': _formatMoney(penjualan),
      'retur': _formatMoney(retur),
      'bersih': _formatMoney(bersih),
      'bagi': _formatMoney(jumlahBagiHasil),
      'status': widget.initialData?['status'] ?? 'Proses',
    };

    Navigator.pop<Map<String, String>>(
      context,
      hasil,
    );
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ),
    );
  }

  // =====================================================
  // BUILD DETAIL BAGI HASIL
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bhBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BagiHasilSidebar(
            onBagiHasilTap: () {
              Navigator.pop(context);
            },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                30,
                52,
                30,
                25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =========================================
                  // HEADER
                  // =========================================

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DETAIL BAGI HASIL',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: bhDark,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Rincian pembagian hasil penjualan harian.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _BagiHasilOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // =========================================
                  // TOOLBAR
                  // =========================================

                  Row(
                    children: [
                      Container(
                        width: 264,
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 14,
                              color: Color(0xFF64748B),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Cari bagi hasil...',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton(
                        onPressed: _simpanBagiHasil,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bhOrange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23,
                            vertical: 11,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Proses Bagi Hasil',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // =========================================
                  // PANEL FORM
                  // =========================================

                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: double.infinity,
                        height: 355,
                        child: _buildFormCard(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // =========================================
                  // KEMBALI
                  // =========================================

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bhOrange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'KEMBALI',
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
          ),
        ],
      ),
    );
  }

  // =====================================================
  // PANEL FORM BAGI HASIL
  // =====================================================

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bhNavy,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF17394A),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER ORANYE
          Container(
            height: 26,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8738),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.isNew
                  ? 'Proses Bagi Hasil'
                  : 'Proses Bagi Hasil',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // FORM FIELDS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _formField(
                  'TANGGAL',
                  _dateField(),
                ),

                const SizedBox(height: 4),

                _formField(
                  'OUTLET',
                  _dropdown(
                    value: outlet,
                    hint: 'Pilih Outlet',
                    items: daftarOutlet,
                    onChanged: (value) {
                      setState(() {
                        outlet = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 4),

                _formField(
                  'PENJUAL',
                  _dropdown(
                    value: penjual,
                    hint: 'Pilih Penjual',
                    items: daftarPenjual,
                    onChanged: (value) {
                      setState(() {
                        penjual = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 4),

                _formField(
                  'TOTAL PENJUALAN',
                  _textField(
                    controller: penjualanController,
                    hint: '',
                    isNumber: true,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                ),

                const SizedBox(height: 4),

                _formField(
                  'TOTAL RETUR',
                  _textField(
                    controller: returController,
                    hint: '',
                    isNumber: true,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                ),

                const SizedBox(height: 4),

                _formField(
                  'PENJUALAN BERSIH',
                  _calculatedField(
                    _hitungPenjualanBersih(),
                  ),
                ),

                const SizedBox(height: 4),

                _formField(
                  'BAGI HASIL',
                  _textField(
                    controller: bagiController,
                    hint: '',
                    isNumber: true,
                  ),
                ),

                const Spacer(),

                // TOMBOL BATAL DAN SIMPAN
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _darkButton(
                      'BATAL',
                      false,
                      () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(width: 8),

                    _darkButton(
                      'SIMPAN BAGI HASIL',
                      true,
                      _simpanBagiHasil,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // LABEL FIELD
  // =====================================================

  Widget _formField(
    String label,
    Widget field,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 8,
            height: 1.1,
            fontWeight: FontWeight.bold,
            color: Color(0xFFCBD5E1),
          ),
        ),

        const SizedBox(height: 2),

        field,
      ],
    );
  }

  // =====================================================
  // INPUT TANGGAL
  // =====================================================

  Widget _dateField() {
    return SizedBox(
      height: 22,
      child: TextField(
        controller: tanggalController,
        readOnly: true,
        onTap: _pilihTanggal,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.white,
        ),
        decoration: _inputDecoration(
          hint: 'Pilih tanggal',
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            size: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // INPUT TEXT
  // =====================================================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
    ValueChanged<String>? onChanged,
  }) {
    return SizedBox(
      height: 22,
      child: TextField(
        controller: controller,
        keyboardType: isNumber
            ? TextInputType.number
            : TextInputType.text,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.white,
        ),
        decoration: _inputDecoration(
          hint: hint,
        ),
      ),
    );
  }

  // =====================================================
  // PENJUALAN BERSIH
  // =====================================================

  Widget _calculatedField(String value) {
    return Container(
      height: 22,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFF082332),
        border: Border.all(
          color: const Color(0xFF31566A),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.white,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFA8B9C5),
        fontSize: 9,
      ),
      filled: true,
      fillColor: const Color(0xFF082332),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color(0xFF31566A),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color(0xFF31566A),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: bhOrange,
        ),
      ),
    );
  }

  // =====================================================
  // DROPDOWN
  // =====================================================

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF082332),
        border: Border.all(
          color: const Color(0xFF31566A),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFFA8B9C5),
              fontSize: 9,
            ),
          ),
          isExpanded: true,
          isDense: true,
          dropdownColor: bhNavyLight,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 15,
            color: Colors.white,
          ),
          style: const TextStyle(
            fontSize: 9,
            color: Colors.white,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // =====================================================
  // TOMBOL FORM
  // =====================================================

  Widget _darkButton(
    String title,
    bool primary,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary
              ? const Color(0xFFFF6500)
              : bhNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          side: primary
              ? BorderSide.none
              : const BorderSide(
                  color: Color(0xFF31566A),
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =========================================================
// SIDEBAR BAGI HASIL
// MENGGUNAKAN OWNER SIDEBAR BERSAMA
// =========================================================

class _BagiHasilSidebar extends StatelessWidget {
  final VoidCallback onBagiHasilTap;

  const _BagiHasilSidebar({
    required this.onBagiHasilTap,
  });

  @override
  Widget build(BuildContext context) {
    return OwnerSidebar(
      activeItem: 'Bagi Hasil',
      onSelected: (item) => _handleMenuTap(context, item),
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR OWNER
  // =====================================================

  void _handleMenuTap(BuildContext context, String item) {
    switch (item) {
      case 'Dashboard':
        _goTo(context, const DashboardPage());
        break;

      case 'Produk':
      case 'Outlet':
      case 'Penjual':
        _goTo(context, const MasterDataPage());
        break;

      case 'Distribusi':
        _goTo(context, const DistribusiPage());
        break;

      case 'Retur':
        _goTo(context, const ReturPage());
        break;

      case 'Setoran':
        _goTo(context, const SetoranPage());
        break;

      case 'Bagi Hasil':
        onBagiHasilTap();
        break;

      case 'Laporan':
        _goTo(context, const LaporanPage());
        break;

      case 'Logout':
        _showLogoutDialog(context);
        break;
    }
  }

  // =====================================================
  // PINDAH HALAMAN
  // =====================================================

  void _goTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
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
                backgroundColor: bhOrange,
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

// =========================================================
// OWNER BADGE
// =========================================================

class _BagiHasilOwnerBadge extends StatelessWidget {
  const _BagiHasilOwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bhOrange,
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Owner',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            size: 18,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}