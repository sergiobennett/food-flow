import 'package:flutter/material.dart';
import 'owner_sidebar.dart';

import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'login_page.dart';

// =========================================================
// HALAMAN DAFTAR DISTRIBUSI
// =========================================================

class DistribusiPage extends StatefulWidget {
  const DistribusiPage({super.key});

  @override
  State<DistribusiPage> createState() => _DistribusiPageState();
}

class _DistribusiPageState extends State<DistribusiPage> {
  static const Color orange = Color(0xFFFF7100);
  static const Color background = Color(0xFFF0F5FA);

  final TextEditingController searchController =
      TextEditingController();

  String search = '';

  final List<Map<String, dynamic>> distribusi = [
    {
      'kode': 'D001',
      'tanggal': '21 Sep',
      'outlet': 'Outlet A',
      'penjual': 'Andi',
      'total': '50',
      'status': 'Diproses',
    },
    {
      'kode': 'D002',
      'tanggal': '21 Sep',
      'outlet': 'Outlet B',
      'penjual': 'Budi',
      'total': '45',
      'status': 'Diterima',
    },
    {
      'kode': 'D003',
      'tanggal': '20 Sep',
      'outlet': 'Outlet C',
      'penjual': 'Citra',
      'total': '60',
      'status': 'Diterima',
    },
    {
      'kode': 'D004',
      'tanggal': '22 Sep',
      'outlet': 'Outlet A',
      'penjual': 'Andi',
      'total': '40',
      'status': 'Diproses',
    },
    {
      'kode': 'D005',
      'tanggal': '22 Sep',
      'outlet': 'Outlet C',
      'penjual': 'Citra',
      'total': '60',
      'status': 'Diterima',
    },
    {
      'kode': 'D006',
      'tanggal': '23 Sep',
      'outlet': 'Outlet B',
      'penjual': 'Budi',
      'total': '45',
      'status': 'Diterima',
    },
  ];

  List<Map<String, dynamic>> get distribusiFilter {
    if (search.trim().isEmpty) {
      return distribusi;
    }

    final query = search.toLowerCase().trim();

    return distribusi.where((item) {
      return item.values.any(
        (value) => value.toString().toLowerCase().contains(query),
      );
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // NAVIGASI KE FORM TAMBAH DISTRIBUSI
  // =====================================================

  Future<void> bukaBuatDistribusi() async {
    int nomorTerbesar = 0;

    for (final item in distribusi) {
      final kode = item['kode'].toString();
      final match = RegExp(r'^D(\d+)$').firstMatch(kode);

      if (match != null) {
        final nomor = int.parse(match.group(1)!);

        if (nomor > nomorTerbesar) {
          nomorTerbesar = nomor;
        }
      }
    }

    final kodeBaru =
        'D${(nomorTerbesar + 1).toString().padLeft(3, '0')}';

    final hasil = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => BuatDistribusiPage(
          kode: kodeBaru,
          isNew: true,
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    setState(() {
      distribusi.add(hasil);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Distribusi berhasil ditambahkan.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // DETAIL DISTRIBUSI
  // =====================================================

  Future<void> bukaDetailDistribusi(
    Map<String, dynamic> item,
  ) async {
    final hasil = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => BuatDistribusiPage(
          kode: item['kode'].toString(),
          tanggal: item['tanggal'].toString(),
          outlet: item['outlet'].toString(),
          penjual: item['penjual'].toString(),
          total: item['total'].toString(),
          status: item['status'].toString(),
          isNew: false,
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    final index = distribusi.indexWhere(
      (data) => data['kode'] == item['kode'],
    );

    if (index == -1) return;

    setState(() {
      distribusi[index] = hasil;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data distribusi berhasil diperbarui.'),
        backgroundColor: Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // BUILD DAFTAR DISTRIBUSI
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          _DistribusiSidebar(
            onDistribusiTap: () {},
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
                  // HEADER

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DISTRIBUSI',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Kelola distribusi produk ke outlet dan penjual.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const _DistribusiOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // PENCARIAN DAN TOMBOL BUAT DISTRIBUSI

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
                            hintText: 'Cari distribusi...',
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
                        onPressed: bukaBuatDistribusi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 11,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Buat Distribusi',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // TABEL DISTRIBUSI

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
                        backgroundColor: orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
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
  // KARTU TABEL DISTRIBUSI
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
              height: 29,
              color: const Color(0xFFFF7945),
              child: Row(
                children: [
                  _headerCell('KODE', 10),
                  _headerDivider(),
                  _headerCell('TANGGAL', 11),
                  _headerDivider(),
                  _headerCell('OUTLET', 11),
                  _headerDivider(),
                  _headerCell('PENJUAL', 11),
                  _headerDivider(),
                  _headerCell('TOTAL', 8),
                  _headerDivider(),
                  _headerCell('STATUS', 12),
                  _headerDivider(),
                  _headerCell('AKSI', 10),
                ],
              ),
            ),
          ),

          // DATA DISTRIBUSI

          Expanded(
            child: distribusiFilter.isEmpty
                ? const Center(
                    child: Text(
                      'Data distribusi tidak ditemukan.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: distribusiFilter.length,
                    separatorBuilder: (_, __) {
                      return const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Color(0xFFE9EEF4),
                      );
                    },
                    itemBuilder: (context, index) {
                      final item = distribusiFilter[index];

                      return Container(
                        height: 35,
                        color: index.isOdd
                            ? const Color(0xFFF5F8FC)
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
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8EDF3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    item['kode'].toString(),
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
                              item['tanggal'].toString(),
                              11,
                            ),

                            _bodyDivider(),

                            // OUTLET

                            _bodyCell(
                              item['outlet'].toString(),
                              11,
                            ),

                            _bodyDivider(),

                            // PENJUAL

                            _bodyCell(
                              item['penjual'].toString(),
                              11,
                            ),

                            _bodyDivider(),

                            // TOTAL

                            Expanded(
                              flex: 8,
                              child: Center(
                                child: Text(
                                  item['total'].toString(),
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
                              flex: 12,
                              child: Center(
                                child: _statusWidget(
                                  item['status'].toString(),
                                ),
                              ),
                            ),

                            _bodyDivider(),

                            // AKSI DETAIL

                            Expanded(
                              flex: 10,
                              child: Center(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    bukaDetailDistribusi(item);
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

  Widget _headerCell(
    String title,
    int flex,
  ) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
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
  // STATUS DISTRIBUSI
  // =====================================================

  Widget _statusWidget(String status) {
    final bool diterima = status == 'Diterima';

    final Color color = diterima
        ? const Color(0xFF009B68)
        : const Color(0xFFFF5A1F);

    final Color fillColor = diterima
        ? const Color(0xFFE1F6EF)
        : const Color(0xFFFFEEE5);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: fillColor,
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
              fontSize: 9,
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
// HALAMAN BUAT DISTRIBUSI / DETAIL DISTRIBUSI
// =========================================================

class BuatDistribusiPage extends StatefulWidget {
  final String? kode;
  final String? tanggal;
  final String? outlet;
  final String? penjual;
  final String? total;
  final String? status;
  final bool isNew;

  const BuatDistribusiPage({
    super.key,
    this.kode,
    this.tanggal,
    this.outlet,
    this.penjual,
    this.total,
    this.status,
    this.isNew = true,
  });

  @override
  State<BuatDistribusiPage> createState() =>
      _BuatDistribusiPageState();
}

class _BuatDistribusiPageState extends State<BuatDistribusiPage> {
  static const Color orange = Color(0xFFFF7100);

  late final TextEditingController kodeController;
  late final TextEditingController tanggalController;

  final TextEditingController searchController =
      TextEditingController();

  String outlet = 'Outlet A';
  String penjual = 'Andi';
  String status = 'Diterima';

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
    'Diterima',
    'Diproses',
  ];

  @override
  void initState() {
    super.initState();

    kodeController = TextEditingController(
      text: widget.kode ?? 'D001',
    );

    tanggalController = TextEditingController(
      text: _formatInitialDate(widget.tanggal),
    );

    outlet = widget.outlet ?? 'Outlet A';
    penjual = widget.penjual ?? 'Andi';
    status = widget.status ?? 'Diterima';
  }

  String _formatInitialDate(String? tanggal) {
    if (tanggal == null || tanggal.isEmpty) {
      return '21 Sep 2026';
    }

    if (tanggal.contains('2026')) {
      return tanggal;
    }

    return '$tanggal 2026';
  }

  @override
  void dispose() {
    kodeController.dispose();
    tanggalController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // DATE PICKER
  // =====================================================

  Future<void> _pilihTanggal() async {
    const bulan = [
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
        initialDate = DateTime(year, monthIndex + 1, day);
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
              primary: Color(0xFFFF7100),
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
  // SIMPAN DISTRIBUSI
  // =====================================================

  void _simpanDistribusi() {
    if (tanggalController.text.trim().isEmpty) {
      _pesan('Tanggal distribusi wajib diisi.');
      return;
    }

    final parts = tanggalController.text.trim().split(' ');

    final tanggalSingkat = parts.length >= 2
        ? '${parts[0]} ${parts[1]}'
        : tanggalController.text.trim();

    final hasil = <String, dynamic>{
      'kode': kodeController.text,
      'tanggal': tanggalSingkat,
      'outlet': outlet,
      'penjual': penjual,
      'total': widget.total ?? '50',
      'status': status,
    };

    Navigator.pop<Map<String, dynamic>>(
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
  // BUILD FORM DISTRIBUSI
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          _DistribusiSidebar(
            onDistribusiTap: () {
              Navigator.pop(context);
            },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                30,
                28,
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
                                  ? 'BUAT DISTRIBUSI'
                                  : 'DETAIL DISTRIBUSI',
                              style: const TextStyle(
                                fontSize: 22,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Kelola distribusi produk ke outlet dan penjual.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const _DistribusiOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // PENCARIAN DAN TOMBOL

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
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF334155),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Cari distribusi...',
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
                        onPressed: _simpanDistribusi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 11,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          widget.isNew
                              ? 'Buat Distribusi'
                              : 'Simpan Perubahan',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  // PANEL DETAIL

                  Expanded(
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: _buildDistributionCard(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // KEMBALI

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
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
  // KARTU DETAIL DISTRIBUSI
  // =====================================================

  Widget _buildDistributionCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 334,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF031C2B),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFF15394A),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER PANEL

          Container(
            height: 30,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0A2D40),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFF103A4D),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 17,
                ),
                SizedBox(width: 10),
                VerticalDivider(
                  width: 8,
                  indent: 6,
                  endIndent: 6,
                  color: Color(0xFF28566B),
                ),
                SizedBox(width: 8),
                Text(
                  'Detail Distribusi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // INFORMASI DISTRIBUSI

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF103A4D),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'INFORMASI DISTRIBUSI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 10,
                      child: _field(
                        'KODE',
                        controller: kodeController,
                        readOnly: true,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 11,
                      child: _dateField(),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 11,
                      child: _dropdownField(
                        'OUTLET',
                        outlet,
                        daftarOutlet,
                        (value) {
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

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 11,
                      child: _dropdownField(
                        'PENJUAL',
                        penjual,
                        daftarPenjual,
                        (value) {
                          if (value != null) {
                            setState(() {
                              penjual = value;
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 10,
                      child: _dropdownField(
                        'STATUS',
                        status,
                        daftarStatus,
                        (value) {
                          if (value != null) {
                            setState(() {
                              status = value;
                            });
                          }
                        },
                        isStatus: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // PRODUK YANG DIDISTRIBUSIKAN

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF103A4D),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PRODUK YANG DIDISTRIBUSIKAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  height: 25,
                  color: const Color(0xFF12384A),
                  child: const Row(
                    children: [
                      _ProductHeaderCell(
                        text: 'KODE',
                        flex: 10,
                      ),
                      _ProductHeaderCell(
                        text: 'PRODUK',
                        flex: 15,
                      ),
                      _ProductHeaderCell(
                        text: 'JUMLAH',
                        flex: 11,
                      ),
                      _ProductHeaderCell(
                        text: 'HARGA',
                        flex: 11,
                      ),
                      _ProductHeaderCell(
                        text: 'SUBTOTAL',
                        flex: 12,
                      ),
                    ],
                  ),
                ),

                _productRow(
                  kode: 'P001',
                  nama: 'Produk A',
                  jumlah: '20',
                  harga: '10.000',
                  subtotal: '200.000',
                ),

                _productRow(
                  kode: 'P002',
                  nama: 'Produk B',
                  jumlah: '15',
                  harga: '12.000',
                  subtotal: '180.000',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // FIELD INPUT
  // =====================================================

  Widget _field(
    String label, {
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        SizedBox(
          height: 23,
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF061622),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF28566B),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF28566B),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFFFF7100),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // FIELD TANGGAL
  // =====================================================

  Widget _dateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TANGGAL',
          style: TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        SizedBox(
          height: 23,
          child: TextField(
            controller: tanggalController,
            readOnly: true,
            onTap: _pilihTanggal,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF061622),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 5,
              ),
              suffixIcon: const Icon(
                Icons.calendar_month,
                color: Colors.white70,
                size: 11,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF28566B),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF28566B),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // DROPDOWN FIELD
  // =====================================================

  Widget _dropdownField(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged, {
    bool isStatus = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Container(
          height: 23,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF061622),
            border: Border.all(
              color: const Color(0xFF28566B),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              dropdownColor: const Color(0xFF0A2D40),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white70,
                size: 13,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      if (isStatus) ...[
                        Icon(
                          Icons.circle,
                          size: 7,
                          color: item == 'Diterima'
                              ? const Color(0xFF00C997)
                              : const Color(0xFFFF7043),
                        ),
                        const SizedBox(width: 4),
                      ],

                      Flexible(
                        child: Text(
                          item,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // BARIS PRODUK
  // =====================================================

  Widget _productRow({
    required String kode,
    required String nama,
    required String jumlah,
    required String harga,
    required String subtotal,
  }) {
    return Container(
      height: 25,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF103A4D),
          ),
        ),
      ),
      child: Row(
        children: [
          _productCell(kode, 10),
          _productCell(nama, 15),
          _productCell(jumlah, 11),
          _productCell(harga, 11),
          _productCell(subtotal, 12),
        ],
      ),
    );
  }

  Widget _productCell(
    String text,
    int flex,
  ) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}

// =========================================================
// HEADER TABEL PRODUK
// =========================================================

class _ProductHeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _ProductHeaderCell({
    required this.text,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =========================================================
// SIDEBAR DISTRIBUSI
// MENGGUNAKAN OWNER SIDEBAR BERSAMA
// =========================================================

class _DistribusiSidebar extends StatelessWidget {
  final VoidCallback onDistribusiTap;

  const _DistribusiSidebar({
    required this.onDistribusiTap,
  });

  @override
  Widget build(BuildContext context) {
    return OwnerSidebar(
      activeItem: 'Distribusi',
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
        onDistribusiTap();
        break;

      case 'Retur':
        _goTo(context, const ReturPage());
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
  // NAVIGASI
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
  // DIALOG LOGOUT
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
                backgroundColor: const Color(0xFFFF7518),
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

class _DistribusiOwnerBadge extends StatelessWidget {
  const _DistribusiOwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF7100),
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