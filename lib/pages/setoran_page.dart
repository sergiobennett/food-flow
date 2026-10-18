import 'package:flutter/material.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'retur_page.dart';
import 'distribusi_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'owner_sidebar.dart';

// =========================================================
// KONSTANTA DESAIN
// =========================================================

const Color setoranOrange = Color(0xFFFF7100);
const Color setoranBackground = Color(0xFFF0F5FA);
const Color setoranDark = Color(0xFF1E293B);
const Color setoranBlue = Color(0xFF2867D7);

// =========================================================
// HALAMAN DAFTAR SETORAN
// =========================================================

class SetoranPage extends StatefulWidget {
  const SetoranPage({super.key});

  @override
  State<SetoranPage> createState() => _SetoranPageState();
}

class _SetoranPageState extends State<SetoranPage> {
  final TextEditingController searchController =
      TextEditingController();

  String search = '';

  // =====================================================
  // DATA SETORAN
  // =====================================================

  final List<Map<String, String>> data = [
    {
      'kode': 'S001',
      'tgl': '21',
      'tanggal': '21 Sep 2026',
      'outlet': 'A',
      'penjual': 'Andi',
      'penjualan': '500.000',
      'setoran': '500.000',
      'status': 'Lunas',
    },
    {
      'kode': 'S002',
      'tgl': '21',
      'tanggal': '21 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'penjualan': '450.000',
      'setoran': '450.000',
      'status': 'Lunas',
    },
    {
      'kode': 'S003',
      'tgl': '20',
      'tanggal': '20 Sep 2026',
      'outlet': 'C',
      'penjual': 'Citra',
      'penjualan': '600.000',
      'setoran': '550.000',
      'status': 'Selisih',
    },
    {
      'kode': 'S004',
      'tgl': '23',
      'tanggal': '23 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'penjualan': '550.000',
      'setoran': '550.000',
      'status': 'Lunas',
    },
    {
      'kode': 'S005',
      'tgl': '23',
      'tanggal': '23 Sep 2026',
      'outlet': 'C',
      'penjual': 'Citra',
      'penjualan': '200.000',
      'setoran': '150.000',
      'status': 'Selisih',
    },
    {
      'kode': 'S006',
      'tgl': '24',
      'tanggal': '24 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'penjualan': '450.000',
      'setoran': '450.000',
      'status': 'Lunas',
    },
  ];

  // =====================================================
  // FILTER PENCARIAN
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
  // BUKA FORM PROSES SETORAN
  // =====================================================

  Future<void> _prosesSetoran() async {
    int nomorTerbesar = 0;

    for (final item in data) {
      final match = RegExp(
        r'^S(\d+)$',
      ).firstMatch(item['kode'] ?? '');

      if (match != null) {
        final nomor = int.parse(match.group(1)!);

        if (nomor > nomorTerbesar) {
          nomorTerbesar = nomor;
        }
      }
    }

    final kodeBaru =
        'S${(nomorTerbesar + 1).toString().padLeft(3, '0')}';

    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailSetoranPage(
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
        content: Text('Setoran berhasil ditambahkan.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BUKA DETAIL SETORAN
  // =====================================================

  Future<void> _bukaDetail(
    Map<String, String> item,
  ) async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailSetoranPage(
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
        content: Text('Data setoran berhasil diperbarui.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BUILD HALAMAN SETORAN
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setoranBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SetoranSidebar(
            onSetoranTap: () {},
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
                              'SETORAN',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: setoranDark,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kelola penerimaan setoran uang harian dari penjual.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _SetoranOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // =========================================
                  // PENCARIAN DAN TOMBOL PROSES
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
                            hintText: 'Cari setoran...',
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
                        onPressed: _prosesSetoran,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: setoranOrange,
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
                          'Proses Setoran',
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
                  // TABEL SETORAN
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
                  // TOMBOL KEMBALI
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
                        backgroundColor: setoranOrange,
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
  // TABEL SETORAN
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
          // HEADER TABEL
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              height: 32,
              color: const Color(0xFFFF762E),
              child: Row(
                children: [
                  _headerCell('KODE', 9),
                  _headerDivider(),
                  _headerCell('TGL', 7),
                  _headerDivider(),
                  _headerCell('OUTLET', 9),
                  _headerDivider(),
                  _headerCell('PENJUAL', 11),
                  _headerDivider(),
                  _headerCell('PENJUALAN', 13),
                  _headerDivider(),
                  _headerCell('SETORAN', 13),
                  _headerDivider(),
                  _headerCell('STATUS', 12),
                  _headerDivider(),
                  _headerCell('AKSI', 10),
                ],
              ),
            ),
          ),

          // DATA SETORAN
          Expanded(
            child: dataFilter.isEmpty
                ? const Center(
                    child: Text(
                      'Data setoran tidak ditemukan.',
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
                        height: 43,
                        color: index.isOdd
                            ? const Color(0xFFF6F8FB)
                            : Colors.white,
                        child: Row(
                          children: [
                            // KODE
                            Expanded(
                              flex: 9,
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
                              7,
                            ),

                            _bodyDivider(),

                            // OUTLET
                            _bodyCell(
                              item['outlet'] ?? '',
                              9,
                            ),

                            _bodyDivider(),

                            // PENJUAL
                            _bodyCell(
                              item['penjual'] ?? '',
                              11,
                            ),

                            _bodyDivider(),

                            // TOTAL PENJUALAN
                            _bodyCell(
                              item['penjualan'] ?? '0',
                              13,
                              bold: true,
                            ),

                            _bodyDivider(),

                            // JUMLAH SETORAN
                            _bodyCell(
                              item['setoran'] ?? '0',
                              13,
                              bold: true,
                            ),

                            _bodyDivider(),

                            // STATUS
                            Expanded(
                              flex: 12,
                              child: Center(
                                child: _statusBadge(
                                  item['status'] ?? 'Lunas',
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
      height: 16,
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
  // STATUS SETORAN
  // =====================================================

  Widget _statusBadge(String status) {
    final bool lunas = status == 'Lunas';

    final Color foreground = lunas
        ? const Color(0xFF00A878)
        : const Color(0xFFE53935);

    final Color background = lunas
        ? const Color(0xFFDFF7EE)
        : const Color(0xFFFFE8EA);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            lunas ? Icons.check_circle : Icons.error,
            size: 12,
            color: foreground,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// HALAMAN DETAIL SETORAN
// =========================================================

class DetailSetoranPage extends StatefulWidget {
  final String? kode;
  final Map<String, String>? initialData;
  final bool isNew;

  const DetailSetoranPage({
    super.key,
    this.kode,
    this.initialData,
    this.isNew = false,
  });

  @override
  State<DetailSetoranPage> createState() =>
      _DetailSetoranPageState();
}

class _DetailSetoranPageState extends State<DetailSetoranPage> {
  late final TextEditingController kodeController;
  late final TextEditingController tanggalController;
  late final TextEditingController penjualanController;
  late final TextEditingController setoranController;

  String outlet = 'Outlet A';
  String penjual = 'Andi';
  String status = 'Lunas';

  static const List<String> daftarOutlet = [
    'Outlet A',
    'Outlet B',
    'Outlet C',
  ];

  static const List<String> daftarPenjual = [
    'Andi',
    'Budi',
    'Citra',
  ];

  static const List<String> daftarStatus = [
    'Lunas',
    'Selisih',
  ];

  @override
  void initState() {
    super.initState();

    final item = widget.initialData;

    kodeController = TextEditingController(
      text: widget.kode ?? 'S001',
    );

    tanggalController = TextEditingController(
      text: item?['tanggal'] ?? '21 Sep 2026',
    );

    penjualanController = TextEditingController(
      text: item?['penjualan'] ?? '',
    );

    setoranController = TextEditingController(
      text: item?['setoran'] ?? '',
    );

    // Ambil data yang sesuai ketika tombol Detail diklik.
    if (item != null) {
      final String? outletAwal = item['outlet'];

      if (outletAwal != null) {
        outlet = outletAwal.startsWith('Outlet ')
            ? outletAwal
            : 'Outlet $outletAwal';
      }

      final String? penjualAwal = item['penjual'];

      if (penjualAwal != null &&
          daftarPenjual.contains(penjualAwal)) {
        penjual = penjualAwal;
      }

      final String? statusAwal = item['status'];

      if (statusAwal != null &&
          daftarStatus.contains(statusAwal)) {
        status = statusAwal;
      }
    }
  }

  @override
  void dispose() {
    kodeController.dispose();
    tanggalController.dispose();
    penjualanController.dispose();
    setoranController.dispose();
    super.dispose();
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
              primary: setoranOrange,
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
  // KONVERSI NOMINAL
  // =====================================================

  int _parseMoney(String value) {
    final digits = value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    return int.tryParse(digits) ?? 0;
  }

  String _formatMoney(String value) {
    final number = _parseMoney(value);

    if (number == 0) return '0';

    return number.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  // =====================================================
  // SIMPAN SETORAN
  // =====================================================

  void _simpanSetoran() {
    if (tanggalController.text.trim().isEmpty) {
      _pesan('Tanggal setoran wajib diisi.');
      return;
    }

    if (penjualanController.text.trim().isEmpty) {
      _pesan('Total penjualan wajib diisi.');
      return;
    }

    if (setoranController.text.trim().isEmpty) {
      _pesan('Jumlah setoran wajib diisi.');
      return;
    }

    final int penjualan = _parseMoney(
      penjualanController.text,
    );

    final int jumlahSetoran = _parseMoney(
      setoranController.text,
    );

    if (penjualan <= 0) {
      _pesan('Total penjualan harus lebih dari 0.');
      return;
    }

    if (jumlahSetoran <= 0) {
      _pesan('Jumlah setoran harus lebih dari 0.');
      return;
    }

    final String tanggal = tanggalController.text.trim();
    final parts = tanggal.split(' ');

    final String tgl = parts.isNotEmpty ? parts[0] : '';

    final hasil = <String, String>{
      'kode': kodeController.text,
      'tgl': tgl,
      'tanggal': tanggal,
      'outlet': outlet.replaceFirst('Outlet ', ''),
      'penjual': penjual,
      'penjualan': _formatMoney(
        penjualanController.text,
      ),
      'setoran': _formatMoney(
        setoranController.text,
      ),
      'status': status,
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
  // BUILD DETAIL SETORAN
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setoranBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SetoranSidebar(
            onSetoranTap: () {
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
                              'DETAIL SETORAN',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: setoranDark,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Rincian penerimaan setoran uang harian.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _SetoranOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // =========================================
                  // SEARCH DAN PROSES SETORAN
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
                              'Cari setoran...',
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
                        onPressed: _simpanSetoran,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: setoranOrange,
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
                          'Proses Setoran',
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
                  // FORM DETAIL SETORAN
                  // =========================================

                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: double.infinity,
                        height: 415,
                        child: _buildFormCard(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

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
                        backgroundColor: setoranOrange,
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
  // KARTU FORM
  // =====================================================

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _formField(
            Icons.sell_outlined,
            'Kode Setoran',
            _textField(
              controller: kodeController,
              readOnly: true,
            ),
          ),

          const SizedBox(height: 8),

          _formField(
            Icons.calendar_month_outlined,
            'Tanggal',
            _dateField(),
          ),

          const SizedBox(height: 8),

          _formField(
            Icons.storefront_outlined,
            'Outlet',
            _dropdown(
              value: outlet,
              items: const [
                'Outlet A',
                'Outlet B',
                'Outlet C',
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  outlet = value;

                  if (value == 'Outlet A') {
                    penjual = 'Andi';
                  } else if (value == 'Outlet B') {
                    penjual = 'Budi';
                  } else {
                    penjual = 'Citra';
                  }
                });
              },
            ),
          ),

          const SizedBox(height: 8),

          _formField(
            Icons.person_outline,
            'Penjual',
            _dropdown(
              value: penjual,
              items: const [
                'Andi',
                'Budi',
                'Citra',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    penjual = value;
                  });
                }
              },
            ),
          ),

          const SizedBox(height: 8),

          _formField(
            Icons.payments_outlined,
            'Total Penjualan',
            _textField(
              controller: penjualanController,
              isNumber: true,
              prefixText: 'Rp',
            ),
          ),

          const SizedBox(height: 8),

          _formField(
            Icons.account_balance_wallet_outlined,
            'Jumlah Setoran',
            _textField(
              controller: setoranController,
              isNumber: true,
              prefixText: 'Rp',
            ),
          ),

          const SizedBox(height: 8),

          _formField(
            Icons.check_circle_outline,
            'Status',
            _dropdown(
              value: status,
              items: const [
                'Lunas',
                'Selisih',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    status = value;
                  });
                }
              },
            ),
          ),

          const Spacer(),

          const Divider(
            height: 10,
            color: Color(0xFFE7EDF4),
          ),

          // TOMBOL BATAL DAN SIMPAN
          Row(
            children: [
              Expanded(
                child: _blueButton(
                  'Batal',
                  Icons.cancel_outlined,
                  () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _blueButton(
                  'Simpan Setoran',
                  Icons.save_outlined,
                  _simpanSetoran,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // FIELD FORM DENGAN IKON
  // =====================================================

  Widget _formField(
    IconData icon,
    String label,
    Widget input,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 18,
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              icon,
              size: 13,
              color: const Color(0xFF344B70),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF344B70),
                ),
              ),

              const SizedBox(height: 4),

              input,
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // FIELD INPUT
  // =====================================================

  Widget _textField({
    required TextEditingController controller,
    bool readOnly = false,
    bool isNumber = false,
    String? prefixText,
  }) {
    return SizedBox(
      height: 24,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: isNumber
            ? TextInputType.number
            : TextInputType.text,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF344054),
        ),
        decoration: _inputDecoration(
          prefixText: prefixText,
        ),
      ),
    );
  }

  // =====================================================
  // FIELD TANGGAL
  // =====================================================

  Widget _dateField() {
    return SizedBox(
      height: 24,
      child: TextField(
        controller: tanggalController,
        readOnly: true,
        onTap: _pilihTanggal,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF344054),
        ),
        decoration: _inputDecoration(
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            size: 12,
            color: Color(0xFF718096),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? prefixText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixText: prefixText == null ? null : '$prefixText ',
      prefixStyle: const TextStyle(
        fontSize: 10,
        color: Color(0xFF344054),
      ),
      filled: true,
      fillColor: const Color(0xFFF0F4F8),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 25,
        minHeight: 22,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: setoranBlue,
        ),
      ),
    );
  }

  // =====================================================
  // DROPDOWN FORM
  // =====================================================

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          isDense: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 15,
            color: Color(0xFF344B70),
          ),
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF344054),
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
  // TOMBOL BIRU
  // =====================================================

  Widget _blueButton(
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 25,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 12,
        ),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: setoranBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

// =========================================================
// SIDEBAR SETORAN
// MENGGUNAKAN OWNER SIDEBAR BERSAMA
// =========================================================

class _SetoranSidebar extends StatelessWidget {
  final VoidCallback onSetoranTap;

  const _SetoranSidebar({
    required this.onSetoranTap,
  });

  @override
  Widget build(BuildContext context) {
    return OwnerSidebar(
      activeItem: 'Setoran',
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
        onSetoranTap();
        break;

      case 'Bagi Hasil':
        _goTo(context, const BagiHasilPage());
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
                backgroundColor: setoranOrange,
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

class _SetoranOwnerBadge extends StatelessWidget {
  const _SetoranOwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: setoranOrange,
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