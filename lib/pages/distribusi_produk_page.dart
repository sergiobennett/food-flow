import 'package:flutter/material.dart';

import 'checker_sidebar.dart';
import 'login_page.dart';
import 'input_stok_bawaan_page.dart';
import 'input_stok_retur_page.dart';
import 'laporan_riwayat_stok_page.dart';

// ===========================================================
// WARNA FOODFLOW
// ===========================================================

const Color orange = Color(0xFFFF7518);
const Color peach = Color(0xFFFFF2E7);
const Color background = Color(0xFFF1F6FA);
const Color darkText = Color(0xFF26354A);
const Color greyText = Color(0xFF65758B);
const Color green = Color(0xFF16A34A);
const Color yellow = Color(0xFFB59B22);

// ===========================================================
// HALAMAN DISTRIBUSI PRODUK CHECKER
// ===========================================================

class DistribusiPage extends StatefulWidget {
  const DistribusiPage({super.key});

  @override
  State<DistribusiPage> createState() => _DistribusiPageState();
}

class _DistribusiPageState extends State<DistribusiPage> {
  final TextEditingController searchController =
      TextEditingController();

  String search = '';
  String filterStatus = 'Semua Status';

  // =========================================================
  // DATA DISTRIBUSI CONTOH
  // =========================================================

  final List<Map<String, dynamic>> distribusi = [
    {
      'kode': 'DSP-001',
      'tanggal': DateTime(2026, 10, 13),
      'outlet': 'Rungkut',
      'penjual': 'Bimuy',
      'status': 'Dalam Pengiriman',
      'produk': [
        {'nama': 'Udang Keju', 'jumlah': 15},
        {'nama': 'Es Teh', 'jumlah': 20},
      ],
    },
    {
      'kode': 'DSP-002',
      'tanggal': DateTime(2026, 10, 12),
      'outlet': 'Wonokromo',
      'penjual': 'Andi',
      'status': 'Diterima',
      'produk': [
        {'nama': 'Tahu Crispy', 'jumlah': 10},
        {'nama': 'Siomay', 'jumlah': 20},
      ],
    },
    {
      'kode': 'DSP-003',
      'tanggal': DateTime(2026, 10, 11),
      'outlet': 'Sukolilo',
      'penjual': 'Citra',
      'status': 'Menunggu Pengiriman',
      'produk': [
        {'nama': 'Udang Rambutan', 'jumlah': 15},
      ],
    },
    {
      'kode': 'DSP-004',
      'tanggal': DateTime(2026, 10, 10),
      'outlet': 'Rungkut',
      'penjual': 'Bimuy',
      'status': 'Diterima',
      'produk': [
        {'nama': 'Udang Keju', 'jumlah': 20},
      ],
    },
  ];

  // =========================================================
  // FILTER DISTRIBUSI
  // =========================================================

  List<Map<String, dynamic>> get distribusiFilter {
    final String query = search.trim().toLowerCase();

    return distribusi.where((item) {
      final String tanggal = _formatTanggal(
        item['tanggal'] as DateTime,
      ).toLowerCase();

      final bool cocokPencarian =
          item['kode'].toString().toLowerCase().contains(query) ||
          item['outlet'].toString().toLowerCase().contains(query) ||
          item['penjual'].toString().toLowerCase().contains(query) ||
          tanggal.contains(query);

      final bool cocokStatus =
          filterStatus == 'Semua Status' ||
          item['status'] == filterStatus;

      return cocokPencarian && cocokStatus;
    }).toList();
  }

  // =========================================================
  // RINGKASAN
  // =========================================================

  int get jumlahDalamPengiriman {
    return distribusi
        .where((item) => item['status'] == 'Dalam Pengiriman')
        .length;
  }

  int get jumlahDiterima {
    return distribusi
        .where((item) => item['status'] == 'Diterima')
        .length;
  }

  // =========================================================
  // PRODUK DAN TOTAL ITEM
  // =========================================================

  List<Map<String, dynamic>> _produkDari(
    Map<String, dynamic> item,
  ) {
    final dynamic rawProduk = item['produk'];

    if (rawProduk is! List) return [];

    return rawProduk.map<Map<String, dynamic>>((produk) {
      return Map<String, dynamic>.from(produk as Map);
    }).toList();
  }

  int _totalItem(Map<String, dynamic> item) {
    return _produkDari(item).fold<int>(
      0,
      (total, produk) {
        final dynamic jumlah = produk['jumlah'];

        return total +
            (jumlah is num
                ? jumlah.toInt()
                : int.tryParse(jumlah.toString()) ?? 0);
      },
    );
  }

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String _formatTanggal(DateTime date) {
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

    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================================================
  // BUILD HALAMAN
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CheckerSidebar(
            activeItem: 'Distribusi Produk',
            onSelected: _handleSidebarTap,
          ),

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Kartu ringkasan dibuat lebih kompak dan dipusatkan
                        // seperti rancangan Figma.
                        _centeredSection(
                          widthFactor: 0.89,
                          child: _buildSummaryCards(),
                        ),
                        const SizedBox(height: 27),
                        _buildSearchAndFilter(),
                        const SizedBox(height: 24),
                        // Tabel tidak lagi memenuhi seluruh lebar konten.
                        _centeredSection(
                          widthFactor: 0.81,
                          child: _buildTableCard(),
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
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return SizedBox(
      height: 105,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DISTRIBUSI PRODUK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: darkText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pantau pengiriman stok ke seluruh outlet.',
                    style: TextStyle(
                      fontSize: 10,
                      color: greyText,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: orange,
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
                    size: 17,
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
  // PEMBATAS LEBAR BAGIAN KONTEN
  // =========================================================

  Widget _centeredSection({
    required double widthFactor,
    required Widget child,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth < 620
            ? constraints.maxWidth
            : constraints.maxWidth * widthFactor;

        return Center(
          child: SizedBox(
            width: width,
            child: child,
          ),
        );
      },
    );
  }

  // =========================================================
  // KARTU RINGKASAN
  // =========================================================

  Widget _buildSummaryCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = constraints.maxWidth * 0.06;
        final double cardWidth =
            (constraints.maxWidth - spacing * 2) / 3;

        return Wrap(
          spacing: spacing,
          runSpacing: 12,
          children: [
            _summaryCard(
              width: cardWidth,
              title: 'Total Distribusi',
              value: '${distribusi.length}',
              icon: Icons.inventory_2_outlined,
              iconColor: Colors.black,
            ),
            _summaryCard(
              width: cardWidth,
              title: 'Dalam Pengiriman',
              value: '$jumlahDalamPengiriman',
              icon: Icons.local_shipping_outlined,
              iconColor: Colors.black,
            ),
            _summaryCard(
              width: cardWidth,
              title: 'Sudah Diterima',
              value: '$jumlahDiterima',
              icon: Icons.check_box,
              iconColor: green,
            ),
          ],
        );
      },
    );
  }

  Widget _summaryCard({
    required double width,
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minWidth: 145),
      height: 103,
      padding: const EdgeInsets.fromLTRB(13, 12, 13, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: greyText,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 31, color: iconColor),
              const SizedBox(width: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // =========================================================
  // PENCARIAN DAN FILTER
  // =========================================================

  Widget _buildSearchAndFilter() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 620;
        final double controlsWidth = compact
            ? constraints.maxWidth
            : constraints.maxWidth * 0.91;
        final double searchWidth = compact
            ? constraints.maxWidth
            : controlsWidth * 0.39;
        final double filterWidth = compact
            ? constraints.maxWidth
            : controlsWidth * 0.175;

        final Widget searchField = SizedBox(
          width: searchWidth,
          height: 34,
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
            style: const TextStyle(
              fontSize: 11,
              color: darkText,
            ),
            decoration: InputDecoration(
              hintText: 'Cari kode distribusi atau outlet...',
              hintStyle: const TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 17,
                color: greyText,
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 33),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ),
          ),
        );

        final Widget statusFilter = SizedBox(
          width: filterWidth,
          height: 34,
          child: DropdownButtonFormField<String>(
            value: filterStatus,
            isExpanded: true,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              filled: true,
              fillColor: background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFFB8C5D5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFFB8C5D5),
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 10,
              color: darkText,
            ),
            items: const [
              'Semua Status',
              'Menunggu Pengiriman',
              'Dalam Pengiriman',
              'Diterima',
            ].map((status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(
                  status,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                filterStatus = value;
              });
            },
          ),
        );

        if (compact) {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              searchField,
              statusFilter,
            ],
          );
        }

        return SizedBox(
          width: controlsWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              searchField,
              statusFilter,
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // TABEL DISTRIBUSI
  // =========================================================

  Widget _buildTableCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Pertahankan scroll horizontal hanya pada layar yang sangat sempit.
          final double tableWidth = constraints.maxWidth < 500
              ? 500
              : constraints.maxWidth;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              child: Column(
                children: [
                  _buildTableHeader(),

                  if (distribusiFilter.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(28),
                      child: Text(
                        'Data distribusi tidak ditemukan.',
                        style: TextStyle(
                          fontSize: 11,
                          color: greyText,
                        ),
                      ),
                    )
                  else
                    ...distribusiFilter.map(_buildDistributionRow),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      height: 37,
      decoration: BoxDecoration(
        color: orange,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          _DistributionHeader(text: 'KODE', flex: 12),
          _DistributionHeader(text: 'TANGGAL', flex: 17),
          _DistributionHeader(text: 'OUTLET', flex: 18),
          _DistributionHeader(text: 'TOTAL ITEM', flex: 12),
          _DistributionHeader(text: 'STATUS', flex: 21),
          _DistributionHeader(text: 'AKSI', flex: 19),
        ],
      ),
    );
  }

  Widget _buildDistributionRow(
    Map<String, dynamic> item,
  ) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F2F5),
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        children: [
          // KODE

          Expanded(
            flex: 12,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EAF2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  item['kode'].toString(),
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
              ),
            ),
          ),

          // TANGGAL

          Expanded(
            flex: 17,
            child: Center(
              child: Text(
                _formatTanggal(item['tanggal'] as DateTime),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  color: darkText,
                ),
              ),
            ),
          ),

          // OUTLET

          Expanded(
            flex: 18,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6D2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 16,
                      color: orange,
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
                        color: darkText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TOTAL ITEM

          Expanded(
            flex: 12,
            child: Center(
              child: Text(
                '${_totalItem(item)}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: greyText,
                ),
              ),
            ),
          ),

          // STATUS

          Expanded(
            flex: 21,
            child: Center(
              child: _statusBadge(item['status'].toString()),
            ),
          ),

          // DETAIL

          Expanded(
            flex: 19,
            child: Center(
              child: InkWell(
                onTap: () => _bukaDetail(item),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
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
                        color: darkText,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: darkText,
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
  // BADGE STATUS
  // =========================================================

  Widget _statusBadge(String status) {
    late Color color;
    late Color fillColor;

    switch (status) {
      case 'Diterima':
        color = green;
        fillColor = const Color(0xFFE0F8E6);
        break;

      case 'Dalam Pengiriman':
        color = const Color(0xFF2388A9);
        fillColor = const Color(0xFFDDF5FA);
        break;

      default:
        color = yellow;
        fillColor = const Color(0xFFFFF7D8);
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 115),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 8,
          height: 1.2,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // =========================================================
  // NAVIGASI KE DETAIL
  // =========================================================

  Future<void> _bukaDetail(
    Map<String, dynamic> item,
  ) async {
    final Map<String, dynamic>? hasil =
        await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => DetailDistribusiPage(
          data: Map<String, dynamic>.from(item),
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    final int index = distribusi.indexWhere(
      (data) => data['kode'] == hasil['kode'],
    );

    if (index < 0) return;

    setState(() {
      distribusi[index] = hasil;
    });
  }

  // =========================================================
  // NAVIGASI SIDEBAR CHECKER
  // =========================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        // Kembali ke halaman sebelumnya, yaitu Dashboard Checker.
        // Tidak membuka Dashboard Owner.
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
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
        // Sudah berada di halaman Distribusi Produk.
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
          title: const Text('Yakin ingin keluar?'),
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

// ===========================================================
// KOMPONEN HEADER TABEL
// ===========================================================

class _DistributionHeader extends StatelessWidget {
  final String text;
  final int flex;

  const _DistributionHeader({
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
// HALAMAN DETAIL DISTRIBUSI
// ===========================================================

class DetailDistribusiPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailDistribusiPage({
    super.key,
    required this.data,
  });

  List<Map<String, dynamic>> get produk {
    final dynamic rawProduk = data['produk'];

    if (rawProduk is! List) return [];

    return rawProduk.map<Map<String, dynamic>>((item) {
      return Map<String, dynamic>.from(item as Map);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CheckerSidebar(
            activeItem: 'Distribusi Produk',
            onSelected: (item) {
              _handleSidebarTap(context, item);
            },
          ),

          Expanded(
            child: Column(
              children: [
                _buildHeader(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double cardWidth = constraints.maxWidth < 620
                              ? constraints.maxWidth
                              : constraints.maxWidth * 0.56;

                          return SizedBox(
                            width: cardWidth,
                            child: _buildDetailCard(context),
                          );
                        },
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
      height: 105,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DISTRIBUSI PRODUK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: darkText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pantau pengiriman stok ke seluruh outlet.',
                    style: TextStyle(
                      fontSize: 10,
                      color: greyText,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Text(
                'Checker ▼',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CARD DETAIL
  // =========================================================

  Widget _buildDetailCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(23, 23, 12, 23),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DETAIL DISTRIBUSI ${data['kode']}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 20),

          _detailInfo('Kode Distribusi', data['kode'].toString()),
          _detailInfo(
            'Tanggal',
            _formatTanggal(data['tanggal'] as DateTime),
          ),
          _detailInfo('Outlet', data['outlet'].toString()),
          _detailInfo('Penjual', data['penjual'].toString()),
          _detailInfo('Status', data['status'].toString()),

          const SizedBox(height: 17),
          _buildProductSection(),
          const SizedBox(height: 16),

          // Tombol selalu berada di sisi kanan bawah kartu, seperti Figma.
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD8DADD),
                    foregroundColor: darkText,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 10,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Batal',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                const SizedBox(width: 10),

                if (data['status'] == 'Dalam Pengiriman')
                  ElevatedButton(
                    onPressed: () => _ubahStatus(context, 'Diterima'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      foregroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Konfirmasi Diterima',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                if (data['status'] == 'Menunggu Pengiriman')
                  ElevatedButton(
                    onPressed: () => _ubahStatus(context, 'Dalam Pengiriman'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      foregroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Mulai Pengiriman',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

  Widget _buildProductSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double sectionWidth = constraints.maxWidth * 0.85;

        return SizedBox(
          width: sectionWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Color(0xFF9CA3AF)),
              const SizedBox(height: 10),
              const Text(
                'RINCIAN PRODUK',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Produk',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      'Jumlah',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...produk.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['nama'].toString(),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text(
                          item['jumlah'].toString(),
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(color: Color(0xFFE0B9A7)),
            ],
          ),
        );
      },
    );
  }

  Widget _detailInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                color: darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _ubahStatus(BuildContext context, String statusBaru) {
    final Map<String, dynamic> hasil =
        Map<String, dynamic>.from(data);

    hasil['status'] = statusBaru;

    Navigator.pop<Map<String, dynamic>>(
      context,
      hasil,
    );
  }

  String _formatTanggal(DateTime date) {
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

    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
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
        // Halaman detail -> distribusi -> dashboard checker.
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
        Navigator.pop(context);
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
        showDialog<void>(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              title: const Text('Yakin ingin keluar?'),
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
        break;
    }
  }
}