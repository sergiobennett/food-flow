import 'package:flutter/material.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'owner_sidebar.dart';

// =========================================================
// KONSTANTA WARNA
// =========================================================

const Color returOrange = Color(0xFFFF7100);
const Color returBackground = Color(0xFFF0F5FA);
const Color returDark = Color(0xFF263238);
const Color returNavy = Color(0xFF031C2B);
const Color returNavyLight = Color(0xFF0A2D40);

// =========================================================
// HALAMAN DAFTAR RETUR
// =========================================================

class ReturPage extends StatefulWidget {
  const ReturPage({super.key});

  @override
  State<ReturPage> createState() => _ReturPageState();
}

class _ReturPageState extends State<ReturPage> {
  final TextEditingController searchController =
      TextEditingController();

  String search = '';

  // =====================================================
  // DATA RETUR AWAL
  // =====================================================

  final List<Map<String, String>> data = [
    {
      'kode': 'R001',
      'tanggal': '21 Sep 2026',
      'outlet': 'A',
      'penjual': 'Andi',
      'total': '5',
      'status': 'Diterima',
      'produk': 'Produk A',
      'catatan': '',
    },
    {
      'kode': 'R002',
      'tanggal': '21 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'total': '3',
      'status': 'Diterima',
      'produk': 'Produk B',
      'catatan': '',
    },
    {
      'kode': 'R003',
      'tanggal': '20 Sep 2026',
      'outlet': 'C',
      'penjual': 'Citra',
      'total': '7',
      'status': 'Diproses',
      'produk': 'Produk C',
      'catatan': '',
    },
    {
      'kode': 'R004',
      'tanggal': '22 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'total': '3',
      'status': 'Diterima',
      'produk': 'Produk A',
      'catatan': '',
    },
    {
      'kode': 'R005',
      'tanggal': '23 Sep 2026',
      'outlet': 'C',
      'penjual': 'Citra',
      'total': '5',
      'status': 'Diterima',
      'produk': 'Produk B',
      'catatan': '',
    },
    {
      'kode': 'R006',
      'tanggal': '24 Sep 2026',
      'outlet': 'B',
      'penjual': 'Budi',
      'total': '7',
      'status': 'Diterima',
      'produk': 'Produk C',
      'catatan': '',
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
  // BUKA HALAMAN INPUT RETUR
  // =====================================================

  Future<void> _bukaInputRetur() async {
    int nomorTerbesar = 0;

    for (final item in data) {
      final match = RegExp(
        r'^R(\d+)$',
      ).firstMatch(item['kode'] ?? '');

      if (match != null) {
        final nomor = int.parse(match.group(1)!);

        if (nomor > nomorTerbesar) {
          nomorTerbesar = nomor;
        }
      }
    }

    final kodeBaru =
        'R${(nomorTerbesar + 1).toString().padLeft(3, '0')}';

    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => InputReturPage(
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
        content: Text('Retur berhasil ditambahkan.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BUKA DETAIL RETUR
  // =====================================================

  Future<void> _bukaDetailRetur(
    Map<String, String> item,
  ) async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => InputReturPage(
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
        content: Text('Data retur berhasil diperbarui.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BUILD HALAMAN RETUR
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: returBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ReturSidebar(
            onReturTap: () {},
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
                  // HEADER
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'RETUR',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kelola pencatatan stok retur dari outlet dan penjual.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _ReturOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // PENCARIAN DAN INPUT RETUR
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
                            hintText: 'Cari retur...',
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
                        onPressed: _bukaInputRetur,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: returOrange,
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
                          'Input Retur',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // TABEL DENGAN TINGGI TETAP
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

                  // TOMBOL KEMBALI
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
                        backgroundColor: returOrange,
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
  // TABEL RETUR
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
              color: const Color(0xFFFF6B2C),
              child: Row(
                children: [
                  _tableHeader('KODE', 9),
                  _tableDivider(),
                  _tableHeader(
                    'TANGGAL',
                    12,
                    icon: Icons.calendar_month_outlined,
                  ),
                  _tableDivider(),
                  _tableHeader(
                    'OUTLET',
                    11,
                    icon: Icons.storefront_outlined,
                  ),
                  _tableDivider(),
                  _tableHeader(
                    'PENJUAL',
                    12,
                    icon: Icons.person,
                  ),
                  _tableDivider(),
                  _tableHeader(
                    'TOTAL RETUR',
                    13,
                    icon: Icons.inventory_2_outlined,
                  ),
                  _tableDivider(),
                  _tableHeader(
                    'STATUS',
                    13,
                    icon: Icons.access_time,
                  ),
                  _tableDivider(),
                  _tableHeader(
                    'AKSI',
                    10,
                    icon: Icons.settings,
                  ),
                ],
              ),
            ),
          ),

          // DATA
          Expanded(
            child: dataFilter.isEmpty
                ? const Center(
                    child: Text(
                      'Data retur tidak ditemukan.',
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
                        height: 42,
                        color: index.isOdd
                            ? const Color(0xFFF7F9FC)
                            : Colors.white,
                        child: Row(
                          children: [
                            // KODE
                            Expanded(
                              flex: 9,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8EEF5),
                                    borderRadius: BorderRadius.circular(15),
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
                            _tableCell(
                              item['tanggal'] ?? '',
                              12,
                            ),

                            _bodyDivider(),

                            // OUTLET
                            _tableCell(
                              item['outlet'] ?? '',
                              11,
                            ),

                            _bodyDivider(),

                            // PENJUAL
                            _tableCell(
                              item['penjual'] ?? '',
                              12,
                            ),

                            _bodyDivider(),

                            // TOTAL RETUR
                            Expanded(
                              flex: 13,
                              child: Center(
                                child: Text(
                                  item['total'] ?? '0',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ),

                            _bodyDivider(),

                            // STATUS
                            Expanded(
                              flex: 13,
                              child: Center(
                                child: _statusBadge(
                                  item['status'] ?? 'Diterima',
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
                                    _bukaDetailRetur(item);
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
                                        const Color(0xFFE8EEF5),
                                    foregroundColor:
                                        const Color(0xFF334155),
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

  Widget _tableHeader(
    String title,
    int flex, {
    IconData? icon,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 11,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableDivider() {
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

  Widget _tableCell(
    String text,
    int flex,
  ) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF334155),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // STATUS BADGE
  // =====================================================

  Widget _statusBadge(String status) {
    final bool diterima = status == 'Diterima';

    final Color color = diterima
        ? const Color(0xFF009B68)
        : const Color(0xFFFF7900);

    final Color backgroundColor = diterima
        ? const Color(0xFFDDF6EC)
        : const Color(0xFFFFF0E2);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            diterima
                ? Icons.check_circle
                : Icons.access_time,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// HALAMAN INPUT RETUR
// =========================================================

class InputReturPage extends StatefulWidget {
  final String? kode;
  final Map<String, String>? initialData;
  final bool isNew;

  const InputReturPage({
    super.key,
    this.kode,
    this.initialData,
    this.isNew = true,
  });

  @override
  State<InputReturPage> createState() => _InputReturPageState();
}

class _InputReturPageState extends State<InputReturPage> {
  late final TextEditingController tanggalController;
  late final TextEditingController jumlahController;
  late final TextEditingController catatanController;

  String? outlet;
  String? penjual;
  String? produk;

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

  static const List<String> daftarProduk = [
    'Produk A',
    'Produk B',
    'Produk C',
  ];

  @override
  void initState() {
    super.initState();

    final initial = widget.initialData;

    tanggalController = TextEditingController(
      text: initial?['tanggal'] ?? '21 Sep 2026',
    );

    jumlahController = TextEditingController(
      text: initial?['total'] ?? '',
    );

    catatanController = TextEditingController(
      text: initial?['catatan'] ?? '',
    );

    final String? outletAwal = initial?['outlet'];

    if (outletAwal != null) {
      outlet = outletAwal.startsWith('Outlet ')
          ? outletAwal
          : 'Outlet $outletAwal';
    }

    final String? penjualAwal = initial?['penjual'];

    if (penjualAwal != null &&
        daftarPenjual.contains(penjualAwal)) {
      penjual = penjualAwal;
    }

    final String? produkAwal = initial?['produk'];

    if (produkAwal != null &&
        daftarProduk.contains(produkAwal)) {
      produk = produkAwal;
    }
  }

  @override
  void dispose() {
    tanggalController.dispose();
    jumlahController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  // =====================================================
  // PEMILIHAN TANGGAL
  // HANYA ADA SATU DEKLARASI FUNGSI INI
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
              primary: returOrange,
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
  // SIMPAN RETUR
  // =====================================================

  void _simpanRetur() {
    if (tanggalController.text.trim().isEmpty) {
      _pesan('Tanggal retur wajib diisi.');
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

    if (produk == null) {
      _pesan('Silakan pilih produk.');
      return;
    }

    final int? jumlah = int.tryParse(
      jumlahController.text.trim(),
    );

    if (jumlah == null || jumlah <= 0) {
      _pesan('Jumlah retur harus berupa angka lebih dari 0.');
      return;
    }

    final String tanggal = tanggalController.text.trim();

    final String outletSingkat =
        outlet!.replaceFirst('Outlet ', '');

    final Map<String, String> hasil = {
      'kode': widget.kode ?? 'R001',
      'tanggal': tanggal,
      'outlet': outletSingkat,
      'penjual': penjual!,
      'total': jumlah.toString(),
      'status': widget.initialData?['status'] ?? 'Diterima',
      'produk': produk!,
      'catatan': catatanController.text.trim(),
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
  // BUILD HALAMAN INPUT RETUR
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: returBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ReturSidebar(
            onReturTap: () {
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
                  // HEADER
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isNew
                                  ? 'INPUT RETUR'
                                  : 'DETAIL RETUR',
                              style: const TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Catat stok retur dari outlet pada akhir hari.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const _ReturOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // BARIS PENCARIAN DAN INPUT RETUR
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
                              'Cari retur...',
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
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: returOrange,
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
                          'Input Retur',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // PANEL FORM
                  SizedBox(
                    width: double.infinity,
                    height: 334,
                    child: _buildInputCard(),
                  ),

                  const Spacer(),

                  // KEMBALI
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: returOrange,
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
  // PANEL INPUT RETUR
  // =====================================================

  Widget _buildInputCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: returNavy,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFF17394A),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER PANEL
          Container(
            height: 25,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: returNavyLight,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFF17394A),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 15,
                ),
                SizedBox(width: 10),
                VerticalDivider(
                  width: 8,
                  indent: 5,
                  endIndent: 5,
                  color: Color(0xFF28566B),
                ),
                SizedBox(width: 8),
                Text(
                  'Input Retur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 9),

          // FORM
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TANGGAL
                _formField(
                  'TANGGAL',
                  _dateField(),
                ),

                const SizedBox(height: 5),

                // OUTLET
                _formField(
                  'OUTLET',
                  _dropdown(
                    value: outlet,
                    hint: 'Pilih Outlet',
                    items: daftarOutlet,
                    onChanged: (value) {
                      setState(() {
                        outlet = value;

                        if (value == 'Outlet A') {
                          penjual = 'Andi';
                        } else if (value == 'Outlet B') {
                          penjual = 'Budi';
                        } else if (value == 'Outlet C') {
                          penjual = 'Citra';
                        }
                      });
                    },
                  ),
                ),

                const SizedBox(height: 5),

                // PENJUAL
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

                const SizedBox(height: 5),

                // PRODUK
                _formField(
                  'PRODUK',
                  _dropdown(
                    value: produk,
                    hint: 'Pilih Produk',
                    items: daftarProduk,
                    onChanged: (value) {
                      setState(() {
                        produk = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 5),

                // JUMLAH RETUR
                _formField(
                  'JUMLAH RETUR',
                  _textField(
                    controller: jumlahController,
                    hint: 'Masukkan jumlah',
                    isNumber: true,
                  ),
                ),

                const SizedBox(height: 5),

                // CATATAN
                _formField(
                  'CATATAN',
                  _textField(
                    controller: catatanController,
                    hint: 'Opsional',
                  ),
                ),

                const Spacer(),

                // TOMBOL BATAL DAN SIMPAN
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 12,
                      ),
                      label: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFA8B9C5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 7,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    ElevatedButton.icon(
                      onPressed: _simpanRetur,
                      icon: const Icon(
                        Icons.save_outlined,
                        size: 12,
                      ),
                      label: const Text(
                        'Simpan Retur',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: returOrange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 9,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
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
  // LABEL DAN FIELD
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
            color: Color(0xFFCBD5E1),
            fontSize: 7,
            height: 1.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        field,
      ],
    );
  }

  // =====================================================
  // FIELD TANGGAL
  // =====================================================

  Widget _dateField() {
    return SizedBox(
      height: 22,
      child: TextField(
        controller: tanggalController,
        readOnly: true,
        onTap: _pilihTanggal,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        decoration: _inputDecoration(
          hint: 'Pilih tanggal retur',
          suffixIcon: const Icon(
            Icons.calendar_month,
            size: 11,
            color: Color(0xFFA8B9C5),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // TEXT FIELD
  // =====================================================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
  }) {
    return SizedBox(
      height: 22,
      child: TextField(
        controller: controller,
        keyboardType: isNumber
            ? TextInputType.number
            : TextInputType.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        decoration: _inputDecoration(
          hint: hint,
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
        fontSize: 8,
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
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Color(0xFF1B4053),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Color(0xFF1B4053),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: returOrange,
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
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF1B4053),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFFA8B9C5),
              fontSize: 8,
            ),
          ),
          isExpanded: true,
          isDense: true,
          dropdownColor: const Color(0xFF082332),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 13,
            color: Color(0xFFA8B9C5),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
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
}

// =========================================================
// SIDEBAR RETUR
// MENGGUNAKAN OWNER SIDEBAR BERSAMA
// =========================================================

class _ReturSidebar extends StatelessWidget {
  final VoidCallback onReturTap;

  const _ReturSidebar({
    required this.onReturTap,
  });

  @override
  Widget build(BuildContext context) {
    return OwnerSidebar(
      activeItem: 'Retur',
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
        onReturTap();
        break;

      case 'Setoran':
        _goTo(context, const SetoranPage());
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
                backgroundColor: returOrange,
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

class _ReturOwnerBadge extends StatelessWidget {
  const _ReturOwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: returOrange,
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