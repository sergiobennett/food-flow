import 'package:flutter/material.dart';

import 'checker_sidebar.dart';
import 'login_page.dart';
import 'input_stok_bawaan_page.dart';
import 'input_stok_retur_page.dart';
import 'distribusi_produk_page.dart';

// ===========================================================
// KONSTANTA DESAIN FOODFLOW
// ===========================================================

const Color _stokOrange = Color(0xFFFF7518);
const Color _stokBackground = Color(0xFFF0F5FA);
const Color _stokDark = Color(0xFF26354A);
const Color _stokMuted = Color(0xFF65758B);
const Color _stokPeach = Color(0xFFFFE6D2);
const Color _stokBorder = Color(0xFFE2E8F0);

// ===========================================================
// HALAMAN RIWAYAT STOK CHECKER
// ===========================================================

class LaporanRiwayatStokPage extends StatefulWidget {
  const LaporanRiwayatStokPage({super.key});

  @override
  State<LaporanRiwayatStokPage> createState() =>
      _LaporanRiwayatStokPageState();
}

class _LaporanRiwayatStokPageState
    extends State<LaporanRiwayatStokPage> {
  // =========================================================
  // SEARCH DAN FILTER
  // =========================================================

  final TextEditingController searchController =
      TextEditingController();

  String search = '';
  String filterJenis = 'Semua jenis stok';

  // =========================================================
  // DATA CONTOH RIWAYAT STOK
  // =========================================================

  final List<Map<String, dynamic>> riwayat = [
    {
      'kode': 'STK-001',
      'tanggal': DateTime(2026, 10, 14),
      'jenis': 'Stok Bawaan',
      'outlet': 'Rungkut',
      'waktu': '07:15',
      'produk': [
        {
          'nama': 'Udang Keju',
          'jumlah': 5,
        },
        {
          'nama': 'Tahu Crispy',
          'jumlah': 4,
        },
        {
          'nama': 'Siomay',
          'jumlah': 3,
        },
      ],
    },
    {
      'kode': 'STK-002',
      'tanggal': DateTime(2026, 10, 14),
      'jenis': 'Stok Retur',
      'outlet': 'Wonokromo',
      'waktu': '16:30',
      'produk': [
        {
          'nama': 'Tahu Crispy',
          'jumlah': 2,
        },
        {
          'nama': 'Siomay',
          'jumlah': 3,
        },
      ],
    },
    {
      'kode': 'STK-003',
      'tanggal': DateTime(2026, 10, 13),
      'jenis': 'Stok Bawaan',
      'outlet': 'Sukolilo',
      'waktu': '07:30',
      'produk': [
        {
          'nama': 'Udang Rambutan',
          'jumlah': 4,
        },
        {
          'nama': 'Tahu Crispy',
          'jumlah': 3,
        },
        {
          'nama': 'Siomay',
          'jumlah': 3,
        },
      ],
    },
    {
      'kode': 'STK-004',
      'tanggal': DateTime(2026, 10, 13),
      'jenis': 'Stok Retur',
      'outlet': 'Rungkut',
      'waktu': '17:35',
      'produk': [
        {
          'nama': 'Udang Keju',
          'jumlah': 1,
        },
        {
          'nama': 'Siomay',
          'jumlah': 2,
        },
      ],
    },
  ];

  // =========================================================
  // DATA HASIL PENCARIAN DAN FILTER
  // =========================================================

  List<Map<String, dynamic>> get riwayatFilter {
    final String query = search.trim().toLowerCase();

    return riwayat.where((item) {
      final String outlet =
          item['outlet'].toString().toLowerCase();

      final String jenis =
          item['jenis'].toString().toLowerCase();

      final String kode =
          item['kode'].toString().toLowerCase();

      final String tanggal = _formatTanggal(
        item['tanggal'] as DateTime,
      ).toLowerCase();

      final bool cocokPencarian =
          outlet.contains(query) ||
          jenis.contains(query) ||
          kode.contains(query) ||
          tanggal.contains(query);

      final bool cocokJenis =
          filterJenis == 'Semua jenis stok' ||
          item['jenis'] == filterJenis;

      return cocokPencarian && cocokJenis;
    }).toList();
  }

  // =========================================================
  // PRODUK DAN JUMLAH ITEM
  // =========================================================

  List<Map<String, dynamic>> _produkDari(
    Map<String, dynamic> item,
  ) {
    final dynamic rawProduk = item['produk'];

    if (rawProduk is! List) {
      return [];
    }

    return rawProduk.map<Map<String, dynamic>>((produk) {
      return Map<String, dynamic>.from(produk as Map);
    }).toList();
  }

  int _totalItem(Map<String, dynamic> item) {
    return _produkDari(item).fold<int>(
      0,
      (total, produk) {
        final dynamic jumlah = produk['jumlah'];

        final int nilai = jumlah is num
            ? jumlah.toInt()
            : int.tryParse(jumlah.toString()) ?? 0;

        return total + nilai;
      },
    );
  }

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String _formatTanggal(DateTime tanggal) {
    const List<String> bulan = [
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

    return '${tanggal.day} '
        '${bulan[tanggal.month - 1]} '
        '${tanggal.year}';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================================================
  // BUILD HALAMAN RIWAYAT STOK
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _stokBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR CHECKER

          CheckerSidebar(
            activeItem: 'Riwayat Stok',
            onSelected: _handleSidebarTap,
          ),

          // KONTEN UTAMA

          Expanded(
            child: Column(
              children: [
                _buildHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      30,
                      15,
                      30,
                      28,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 840,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            // SEARCH DAN FILTER

                            _buildSearchFilter(),

                            const SizedBox(height: 30),

                            // TABEL RIWAYAT STOK

                            _buildTableCard(),
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

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return SizedBox(
      height: 105,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'RIWAYAT STOK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: _stokDark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pantau perubahan dan pergerakan stok gudang',
                    style: TextStyle(
                      fontSize: 10,
                      color: _stokMuted,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // BADGE CHECKER

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _stokOrange,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Checker',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SEARCH DAN FILTER
  // =========================================================

  Widget _buildSearchFilter() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool sempit = constraints.maxWidth < 540;

        return Wrap(
          spacing: 12,
          runSpacing: 12,

          // PERBAIKAN ERROR:
          // Wrap menggunakan WrapAlignment,
          // bukan MainAxisAlignment.

          alignment: WrapAlignment.spaceBetween,

          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // KOLOM PENCARIAN

            SizedBox(
              width: sempit
                  ? constraints.maxWidth
                  : 320,
              height: 36,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                style: const TextStyle(
                  fontSize: 11,
                  color: _stokDark,
                ),
                decoration: InputDecoration(
                  hintText: 'Cari outlet atau jenis stok...',
                  hintStyle: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF94A3B8),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 17,
                    color: _stokMuted,
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(
                    minWidth: 35,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: _stokBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: _stokBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: _stokOrange,
                    ),
                  ),
                ),
              ),
            ),

            // FILTER JENIS STOK

            SizedBox(
              width: sempit
                  ? constraints.maxWidth
                  : 180,
              height: 36,
              child: DropdownButtonFormField<String>(
                value: filterJenis,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  filled: true,
                  fillColor: _stokBackground,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Color(0xFFB8C5D5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Color(0xFFB8C5D5),
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                ),
                style: const TextStyle(
                  fontSize: 10,
                  color: _stokMuted,
                ),
                items: const [
                  'Semua jenis stok',
                  'Stok Bawaan',
                  'Stok Retur',
                ].map((jenis) {
                  return DropdownMenuItem<String>(
                    value: jenis,
                    child: Text(
                      jenis,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    filterJenis = value;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CARD TABEL
  // =========================================================

  Widget _buildTableCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double lebarTabel =
              constraints.maxWidth < 750
                  ? 750
                  : constraints.maxWidth;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: lebarTabel,
              child: Column(
                children: [
                  _buildTableHeader(),

                  if (riwayatFilter.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'Riwayat stok tidak ditemukan.',
                        style: TextStyle(
                          fontSize: 11,
                          color: _stokMuted,
                        ),
                      ),
                    )
                  else
                    ...riwayatFilter.map(
                      _buildTableRow,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================
  // HEADER TABEL
  // =========================================================

  Widget _buildTableHeader() {
    return Container(
      height: 41,
      decoration: BoxDecoration(
        color: _stokOrange,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          _StokTableHeader(
            text: 'TANGGAL',
            flex: 19,
          ),
          _StokTableHeader(
            text: 'JENIS INPUT',
            flex: 17,
          ),
          _StokTableHeader(
            text: 'OUTLET',
            flex: 19,
          ),
          _StokTableHeader(
            text: 'JUMLAH ITEM',
            flex: 15,
          ),
          _StokTableHeader(
            text: 'WAKTU',
            flex: 13,
          ),
          _StokTableHeader(
            text: 'AKSI',
            flex: 15,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BARIS TABEL
  // =========================================================

  Widget _buildTableRow(
    Map<String, dynamic> item,
  ) {
    return Container(
      height: 55,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F2F5),
            width: 0.7,
          ),
        ),
      ),
      child: Row(
        children: [
          // TANGGAL

          Expanded(
            flex: 19,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Text(
                _formatTanggal(
                  item['tanggal'] as DateTime,
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  color: _stokDark,
                ),
              ),
            ),
          ),

          // JENIS INPUT

          Expanded(
            flex: 17,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: Text(
                item['jenis'].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: _stokDark,
                ),
              ),
            ),
          ),

          // OUTLET

          Expanded(
            flex: 19,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: _stokPeach,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 16,
                      color: _stokOrange,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      item['outlet'].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: _stokDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // JUMLAH ITEM

          Expanded(
            flex: 15,
            child: Center(
              child: Text(
                '${_totalItem(item)}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _stokMuted,
                ),
              ),
            ),
          ),

          // WAKTU

          Expanded(
            flex: 13,
            child: Center(
              child: Text(
                item['waktu'].toString(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // TOMBOL DETAIL

          Expanded(
            flex: 15,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => _bukaDetail(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EEF5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 13,
                        color: _stokDark,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: _stokDark,
                        ),
                      ),
                    ],
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
  // NAVIGASI KE DETAIL
  // =========================================================

  void _bukaDetail(
    Map<String, dynamic> item,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailRiwayatStokPage(
          data: Map<String, dynamic>.from(item),
        ),
      ),
    );
  }

  // =========================================================
  // NAVIGASI SIDEBAR
  // =========================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        break;

      case 'Stok Bawaan':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const InputStokBawaanPage(),
          ),
        );
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
        // Sudah berada di halaman Riwayat Stok.
        break;

      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  void _showLogoutDialog() {
    showDialog<void>(
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
                backgroundColor: _stokOrange,
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

// ===========================================================
// HEADER KOLOM TABEL
// ===========================================================

class _StokTableHeader extends StatelessWidget {
  final String text;
  final int flex;

  const _StokTableHeader({
    required this.text,
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ===========================================================
// HALAMAN DETAIL RIWAYAT STOK
// ===========================================================

class DetailRiwayatStokPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailRiwayatStokPage({
    super.key,
    required this.data,
  });

  // =========================================================
  // PRODUK DAN TOTAL ITEM
  // =========================================================

  List<Map<String, dynamic>> get produk {
    final dynamic rawProduk = data['produk'];

    if (rawProduk is! List) {
      return [];
    }

    return rawProduk.map<Map<String, dynamic>>((item) {
      return Map<String, dynamic>.from(item as Map);
    }).toList();
  }

  int get totalItem {
    return produk.fold<int>(
      0,
      (total, item) {
        final dynamic jumlah = item['jumlah'];

        final int nilai = jumlah is num
            ? jumlah.toInt()
            : int.tryParse(jumlah.toString()) ?? 0;

        return total + nilai;
      },
    );
  }

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String _formatTanggal(DateTime tanggal) {
    const List<String> bulan = [
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

    return '${tanggal.day} '
        '${bulan[tanggal.month - 1]} '
        '${tanggal.year}';
  }

  // =========================================================
  // BUILD HALAMAN DETAIL
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _stokBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR CHECKER

          CheckerSidebar(
            activeItem: 'Riwayat Stok',
            onSelected: (item) {
              _handleSidebarTap(context, item);
            },
          ),

          // KONTEN DETAIL

          Expanded(
            child: Column(
              children: [
                _buildHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      25,
                      0,
                      25,
                      28,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 620,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            // TOMBOL KEMBALI

                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 14,
                                ),
                                label: const Text(
                                  'Kembali ke Riwayat Stok',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _stokOrange,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // CARD INFORMASI PENCATATAN

                            _buildInformasiCard(),

                            const SizedBox(height: 20),

                            // CARD RINCIAN PRODUK

                            _buildProdukCard(),
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

  // =========================================================
  // HEADER DETAIL
  // =========================================================

  Widget _buildHeader() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'DETAIL RIWAYAT STOK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: _stokDark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Informasi lengkap pencatatan stok gudang.',
                    style: TextStyle(
                      fontSize: 10,
                      color: _stokMuted,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // BADGE CHECKER

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _stokOrange,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Checker',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CARD INFORMASI PENCATATAN
  // =========================================================

  Widget _buildInformasiCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        22,
        22,
        22,
        24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'INFORMASI PENCATATAN',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _stokDark,
            ),
          ),

          const SizedBox(height: 22),

          // KODE DAN JENIS INPUT

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _infoField(
                  'Kode Pencatatan',
                  data['kode'].toString(),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _infoField(
                  'Jenis Input',
                  data['jenis'].toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // TANGGAL DAN WAKTU

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _infoField(
                  'Tanggal',
                  _formatTanggal(
                    data['tanggal'] as DateTime,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _infoField(
                  'Waktu',
                  data['waktu'].toString(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // OUTLET DAN JUMLAH ITEM

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 11,
                      color: _stokDark,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Outlet: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Outlet ${data['outlet']}',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 11,
                    color: _stokDark,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Jumlah Item: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '$totalItem',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FIELD INFORMASI
  // =========================================================

  Widget _infoField(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _stokMuted,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: _stokDark,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // CARD RINCIAN PRODUK
  // =========================================================

  Widget _buildProdukCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        22,
        22,
        22,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RINCIAN PRODUK',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _stokDark,
            ),
          ),

          const SizedBox(height: 22),

          // HEADER TABEL PRODUK

          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'PRODUK',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _stokDark,
                    ),
                  ),
                ),

                SizedBox(
                  width: 75,
                  child: Text(
                    'JUMLAH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _stokDark,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            thickness: 0.8,
            color: Color(0xFF9CA3AF),
          ),

          // DAFTAR PRODUK

          if (produk.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Text(
                'Belum ada rincian produk.',
                style: TextStyle(
                  fontSize: 10,
                  color: _stokMuted,
                ),
              ),
            )
          else
            ...produk.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['nama'].toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: _stokDark,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 75,
                      child: Text(
                        item['jumlah'].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: _stokDark,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 4),

          const Divider(
            height: 1,
            thickness: 0.8,
            color: Color(0xFF9CA3AF),
          ),

          const SizedBox(height: 12),

          // TOTAL ITEM

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'TOTAL ITEM',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _stokDark,
                    ),
                  ),
                ),

                SizedBox(
                  width: 75,
                  child: Text(
                    '$totalItem',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _stokDark,
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
  // NAVIGASI SIDEBAR DETAIL
  // =========================================================

  void _handleSidebarTap(
    BuildContext context,
    String item,
  ) {
    switch (item) {
      case 'Dashboard':
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        break;

      case 'Stok Bawaan':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const InputStokBawaanPage(),
          ),
        );
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
        Navigator.pop(context);
        break;

      case 'Logout':
        _showLogoutDialog(context);
        break;
    }
  }

  // =========================================================
  // LOGOUT DETAIL
  // =========================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
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
                backgroundColor: _stokOrange,
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