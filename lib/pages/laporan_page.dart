import 'package:flutter/material.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'owner_sidebar.dart';

// =========================================================
// KONSTANTA DESAIN
// =========================================================

const Color laporanOrange = Color(0xFFFF6B00);
const Color laporanBackground = Color(0xFFF0F5FA);
const Color laporanDark = Color(0xFF243247);
const Color laporanSecondary = Color(0xFF64748B);

// =========================================================
// MODEL DATA LAPORAN
// =========================================================

class LaporanRecord {
  final DateTime tanggal;
  final String outlet;
  final String penjual;
  final String penjualan;
  final String retur;

  const LaporanRecord({
    required this.tanggal,
    required this.outlet,
    required this.penjual,
    required this.penjualan,
    required this.retur,
  });
}

// =========================================================
// HALAMAN LAPORAN
// =========================================================

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  // =====================================================
  // SEARCH
  // =====================================================

  final TextEditingController searchController =
      TextEditingController();

  String search = '';

  // =====================================================
  // FILTER PERIODE
  // =====================================================

  DateTime selectedStartDate = DateTime(2026, 9, 15);
  DateTime selectedEndDate = DateTime(2026, 9, 21);

  DateTime appliedStartDate = DateTime(2026, 9, 15);
  DateTime appliedEndDate = DateTime(2026, 9, 21);

  String selectedOutlet = 'Semua Outlet';
  String appliedOutlet = 'Semua Outlet';

  // =====================================================
  // DATA CONTOH SESUAI FIGMA
  // =====================================================

  final List<LaporanRecord> laporanData = [
    LaporanRecord(
      tanggal: DateTime(2026, 9, 15),
      outlet: 'Outlet A',
      penjual: 'Andi',
      penjualan: '500.000',
      retur: '500.000',
    ),
    LaporanRecord(
      tanggal: DateTime(2026, 9, 17),
      outlet: 'Outlet B',
      penjual: 'Budi',
      penjualan: '450.000',
      retur: '200.000',
    ),
    LaporanRecord(
      tanggal: DateTime(2026, 9, 19),
      outlet: 'Outlet C',
      penjual: 'Citra',
      penjualan: '600.000',
      retur: '90.000',
    ),
    LaporanRecord(
      tanggal: DateTime(2026, 9, 21),
      outlet: 'Outlet D',
      penjual: 'Bnnet',
      penjualan: '500.000',
      retur: '100.000',
    ),
  ];

  static const List<String> daftarOutlet = [
    'Semua Outlet',
    'Outlet A',
    'Outlet B',
    'Outlet C',
    'Outlet D',
  ];

  static const List<String> daftarBulan = [
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

  // =====================================================
  // FILTER DATA
  // =====================================================

  List<LaporanRecord> get laporanFilter {
    final query = search.toLowerCase().trim();

    return laporanData.where((item) {
      final tanggalSesuai =
          !item.tanggal.isBefore(appliedStartDate) &&
          !item.tanggal.isAfter(appliedEndDate);

      final outletSesuai =
          appliedOutlet == 'Semua Outlet' ||
          item.outlet == appliedOutlet;

      final pencarianSesuai =
          query.isEmpty ||
          item.outlet.toLowerCase().contains(query) ||
          item.penjual.toLowerCase().contains(query) ||
          item.penjualan.toLowerCase().contains(query) ||
          item.retur.toLowerCase().contains(query);

      return tanggalSesuai &&
          outletSesuai &&
          pencarianSesuai;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // FORMAT TANGGAL
  // =====================================================

  String _formatTanggalSingkat(DateTime tanggal) {
    return '${tanggal.day} ${daftarBulan[tanggal.month - 1]}';
  }

  String _formatTanggalLengkap(DateTime tanggal) {
    return '${tanggal.day} '
        '${daftarBulan[tanggal.month - 1]} '
        '${tanggal.year}';
  }

  // =====================================================
  // PILIH TANGGAL MULAI
  // =====================================================

  Future<void> _pilihTanggalMulai() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: laporanOrange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (tanggal == null || !mounted) return;

    setState(() {
      selectedStartDate = tanggal;

      if (selectedStartDate.isAfter(selectedEndDate)) {
        selectedEndDate = selectedStartDate;
      }
    });
  }

  // =====================================================
  // PILIH TANGGAL AKHIR
  // =====================================================

  Future<void> _pilihTanggalAkhir() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: laporanOrange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (tanggal == null || !mounted) return;

    setState(() {
      selectedEndDate = tanggal;

      if (selectedEndDate.isBefore(selectedStartDate)) {
        selectedStartDate = selectedEndDate;
      }
    });
  }

  // =====================================================
  // TAMPILKAN LAPORAN
  // =====================================================

  void _tampilkanLaporan() {
    setState(() {
      appliedStartDate = selectedStartDate;
      appliedEndDate = selectedEndDate;
      appliedOutlet = selectedOutlet;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Laporan periode '
          '${_formatTanggalSingkat(appliedStartDate)} - '
          '${_formatTanggalSingkat(appliedEndDate)} ditampilkan.',
        ),
        backgroundColor: const Color(0xFF16A34A),
      ),
    );
  }

  // =====================================================
  // PRATINJAU CETAK LAPORAN
  // =====================================================

  void _cetakLaporan() {
    final data = laporanFilter;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.print_outlined,
                color: laporanOrange,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pratinjau Laporan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Periode: '
                    '${_formatTanggalLengkap(appliedStartDate)} - '
                    '${_formatTanggalLengkap(appliedEndDate)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Outlet: $appliedOutlet',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'OUTLET',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'PENJUAL',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'PENJUALAN',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'RETUR',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...data.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              item.outlet,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.penjual,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.penjualan,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.retur,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Jumlah data: ${data.length} outlet',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ini merupakan pratinjau laporan. '
                    'Pencetakan ke printer belum dihubungkan.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // BUILD HALAMAN UTAMA
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: laporanBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                30,
                52,
                30,
                25,
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      bottom: 65,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 35),
                        _buildSearch(),
                        const SizedBox(height: 24),
                        _buildStatistics(),
                        const SizedBox(height: 22),
                        _buildPeriodCard(),
                        const SizedBox(height: 20),
                        _buildSalesPerformance(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildBackButton(),
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
                'LAPORAN',
                style: TextStyle(
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  color: laporanDark,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Lihat rekapitulasi dan performa penjualan cabang/penjual.',
                style: TextStyle(
                  fontSize: 10,
                  color: laporanSecondary,
                ),
              ),
            ],
          ),
        ),
        _buildOwnerBadge(),
      ],
    );
  }

  Widget _buildOwnerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: laporanOrange,
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
            color: Colors.black,
            size: 19,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SEARCH
  // =====================================================

  Widget _buildSearch() {
    return Container(
      width: 284,
      height: 32,
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
          hintText: 'Cari laporan...',
          hintStyle: TextStyle(
            fontSize: 10,
            color: Color(0xFF94A3B8),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 15,
            color: Color(0xFF64748B),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 32,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 7,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // KARTU STATISTIK
  // =====================================================

  Widget _buildStatistics() {
    return Row(
      children: [
        _statCard('PENJUALAN', '3,25'),
        const SizedBox(width: 15),
        _statCard('DISTRIBUSI', '125'),
        const SizedBox(width: 15),
        _statCard('RETUR', '25'),
        const SizedBox(width: 15),
        _statCard('LABA', '1,2'),
      ],
    );
  }

  Widget _statCard(
    String title,
    String value,
  ) {
    return Container(
      width: 103,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE9EEF4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.13),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Color(0xFFDC2626),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              height: 1,
              fontWeight: FontWeight.w900,
              color: Color(0xFF202020),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // FILTER PERIODE
  // =====================================================

  Widget _buildPeriodCard() {
    return Container(
      width: double.infinity,
      height: 165,
      padding: const EdgeInsets.fromLTRB(
        18,
        14,
        18,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7043),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Periode',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: laporanDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 10,
                child: _dateFilterBox(
                  selectedStartDate,
                  _pilihTanggalMulai,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                flex: 10,
                child: _dateFilterBox(
                  selectedEndDate,
                  _pilihTanggalAkhir,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                flex: 12,
                child: _outletFilterBox(),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: _tampilkanLaporan,
                icon: const Icon(
                  Icons.search,
                  size: 15,
                ),
                label: const Text(
                  'Tampilkan',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              OutlinedButton.icon(
                onPressed: _cetakLaporan,
                icon: const Icon(
                  Icons.print_outlined,
                  size: 15,
                ),
                label: const Text(
                  'Cetak',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFF5722),
                  side: const BorderSide(
                    color: Color(0xFFFF7043),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // FILTER TANGGAL
  // =====================================================

  Widget _dateFilterBox(
    DateTime date,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE2E8F0),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 14,
              color: Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _formatTanggalSingkat(date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: laporanDark,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // FILTER OUTLET
  // =====================================================

  Widget _outletFilterBox() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.store_outlined,
            size: 15,
            color: Color(0xFF64748B),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedOutlet,
                isExpanded: true,
                isDense: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: Color(0xFF64748B),
                ),
                style: const TextStyle(
                  fontSize: 10,
                  color: laporanDark,
                  fontWeight: FontWeight.w600,
                ),
                items: daftarOutlet.map((outlet) {
                  return DropdownMenuItem<String>(
                    value: outlet,
                    child: Text(
                      outlet,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedOutlet = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // PERFORMA PENJUALAN — SATU BARIS
  // =====================================================

  Widget _buildSalesPerformance() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // JUDUL SESUAI FIGMA
        SizedBox(
          width: 175,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 4,
              right: 5,
            ),
            child: const Text(
              'Performa Penjualan',
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                fontSize: 16,
                height: 1.2,
                fontWeight: FontWeight.w900,
                color: Color(0xFFDC0000),
              ),
            ),
          ),
        ),

        // TABEL
        SizedBox(
          width: 570,
          child: _buildPerformanceTable(),
        ),
      ],
    );
  }

  // =====================================================
  // TABEL PERFORMA PENJUALAN
  // =====================================================

  Widget _buildPerformanceTable() {
    final filtered = laporanFilter;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // HEADER TABEL
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 46,
              color: const Color(0xFFFF8738),
              child: const Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: Center(
                      child: Text(
                        'OUTLET',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: Center(
                      child: Text(
                        'PENJUAL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: Center(
                      child: Text(
                        'PENJUALAN',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Center(
                      child: Text(
                        'RETUR',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // DATA TABEL
          if (filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 35,
              ),
              child: Text(
                'Data laporan tidak ditemukan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            )
          else
            ...filtered.map(
              (item) => Container(
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFF0F3F7),
                      width: 0.7,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 12,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child: Text(
                            item.outlet,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: laporanDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child: Text(
                            item.penjual,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: laporanDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 14,
                      child: Center(
                        child: Text(
                          item.penjualan,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: laporanDark,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Center(
                        child: Text(
                          item.retur,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: laporanDark,
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
  // SIDEBAR OWNER
  // MENGGUNAKAN OWNER SIDEBAR BERSAMA
  // =====================================================

  Widget _buildSidebar() {
    return OwnerSidebar(
      activeItem: 'Laporan',
      onSelected: _handleSidebarSelection,
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR OWNER
  // =====================================================

  void _handleSidebarSelection(String item) {
    switch (item) {
      case 'Dashboard':
        _goTo(const DashboardPage());
        break;

      case 'Produk':
      case 'Outlet':
      case 'Penjual':
        _goTo(const MasterDataPage());
        break;

      case 'Distribusi':
        _goTo(const DistribusiPage());
        break;

      case 'Retur':
        _goTo(const ReturPage());
        break;

      case 'Setoran':
        _goTo(const SetoranPage());
        break;

      case 'Bagi Hasil':
        _goTo(const BagiHasilPage());
        break;

      case 'Laporan':
        // Pengguna sudah berada di halaman Laporan.
        break;

      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  // =====================================================
  // NAVIGASI
  // =====================================================

  void _goTo(Widget page) {
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

  void _showLogoutDialog() {
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
                backgroundColor: laporanOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // TOMBOL KEMBALI
  // =====================================================

  Widget _buildBackButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const DashboardPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: laporanOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 11,
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
    );
  }
}