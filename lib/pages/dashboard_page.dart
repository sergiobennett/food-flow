import 'package:flutter/material.dart';

import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'owner_sidebar.dart';

// =========================================================
// DASHBOARD PAGE
// =========================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color orange = Color(0xFFFF7100);
  static const Color background = Color(0xFFF0F5FA);
  static const Color darkText = Color(0xFF263238);

  // =====================================================
  // BUILD DASHBOARD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          OwnerSidebar(
            activeItem: 'Dashboard',
            onSelected: _handleSidebarTap,
          ),

          // KONTEN UTAMA

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                30,
                43,
                40,
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER

                  _buildHeader(),

                  const SizedBox(height: 5),

                  // KARTU STATISTIK

                  Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        _statCard('PRODUK', '15'),

                        const SizedBox(width: 16),

                        _statCard('OUTLET', '8'),

                        const SizedBox(width: 16),

                        _statCard('PENJUALAN', '10'),

                        const SizedBox(width: 16),

                        _statCard('DISTRIBUSI', '125'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  // GRAFIK DISTRIBUSI

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: _buildChartCard(),
                  ),

                  const SizedBox(height: 25),

                  // NEW ACTIVITY

                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'New Activity',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.795,
                        child: _buildActivityCard(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR OWNER
  // =====================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        // Sudah berada di Dashboard Owner.
        break;

      case 'Produk':
      case 'Outlet':
      case 'Penjual':
        _bukaMasterData();
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
        _goTo(const LaporanPage());
        break;

      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  // =====================================================
  // NAVIGASI MASTER DATA
  // =====================================================

  void _bukaMasterData() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MasterDataPage(),
      ),
    );
  }

  // =====================================================
  // NAVIGASI HALAMAN LAIN
  // =====================================================

  void _goTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  // =====================================================
  // HEADER DASHBOARD OWNER + BADGE AKTOR STATIS
  // =====================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DASHBOARD OWNER',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Pantau data distribusi dan performa bisnis secara terpusat',
                  style: TextStyle(
                    fontSize: 9,
                    height: 1.2,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Badge aktor hanya sebagai penanda, tidak bisa diklik.
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Owner',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
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
          ),
        ],
      ),
    );
  }

  // =====================================================
  // KARTU STATISTIK
  // =====================================================

  Widget _statCard(
    String title,
    String value,
  ) {
    return Container(
      width: 95,
      height: 61,
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFFE8EDF3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
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
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              height: 1.1,
              fontWeight: FontWeight.w900,
              color: Color(0xFFDC2626),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              height: 1,
              fontWeight: FontWeight.w900,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // KARTU PERFORMA DISTRIBUSI
  // =====================================================

  Widget _buildChartCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        20,
        14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE6ECF2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER GRAFIK

          SizedBox(
            height: 30,
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1E7),
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: orange,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 11),

                const Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Performa Distribusi',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.1,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        'Tren distribusi produk dalam 7 hari terakhir',
                        style: TextStyle(
                          fontSize: 7,
                          height: 1.1,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // FILTER TANGGAL

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
                    borderRadius:
                        BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 10,
                        color: Color(0xFF64748B),
                      ),

                      SizedBox(width: 6),

                      Text(
                        '15 Sep 2026 - 21 Sep 2026',
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),

                      SizedBox(width: 4),

                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 12,
                        color: Color(0xFF64748B),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // GRAFIK DAN RINGKASAN

          SizedBox(
            height: 198,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // PANEL GRAFIK

                Expanded(
                  flex: 76,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 14,
                    ),
                    child: Container(
                      height: 184,
                      padding: const EdgeInsets.fromLTRB(
                        8,
                        8,
                        8,
                        4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE8EEF5),
                        ),
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 154,
                            width: double.infinity,
                            child: CustomPaint(
                              painter:
                                  _DashboardChartPainter(),
                            ),
                          ),

                          const SizedBox(height: 2),

                          Row(
                            children: [
                              const Icon(
                                Icons.circle,
                                color: orange,
                                size: 8,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                'Produk Didistribusikan',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      Colors.grey.shade500,
                                ),
                              ),

                              const SizedBox(width: 12),

                              const Icon(
                                Icons.square,
                                color: Color(0xFF7CB8FF),
                                size: 8,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                'Retur Produk',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // PANEL RINGKASAN

                Expanded(
                  flex: 24,
                  child: Container(
                    height: 198,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFE8EEF5),
                      ),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ringkasan',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),

                        const SizedBox(height: 5),

                        _summaryItem(
                          Icons.inventory_2_outlined,
                          'Produk Didistribusikan',
                          '1.020',
                          'dari periode sebelumnya',
                          '+ 12%',
                          orange,
                        ),

                        const Divider(
                          height: 5,
                          thickness: 0.5,
                          color: Color(0xFFEEF2F7),
                        ),

                        _summaryItem(
                          Icons.replay,
                          'Retur Produk',
                          '157',
                          'dari periode sebelumnya',
                          '+ 8%',
                          const Color(0xFF7CB8FF),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 0.5,
                          color: Color(0xFFEEF2F7),
                        ),

                        _summaryItem(
                          Icons.storefront,
                          'Rata-rata per Hari',
                          '143',
                          'dari periode sebelumnya',
                          '+ 15%',
                          const Color(0xFF22C55E),
                        ),

                        const Divider(
                          height: 5,
                          thickness: 0.5,
                          color: Color(0xFFEEF2F7),
                        ),

                        _summaryItem(
                          Icons.bolt,
                          'Tertinggi (Produk)',
                          '185',
                          '21 Sep 2026',
                          null,
                          const Color(0xFFA855F7),
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

  // =====================================================
  // ITEM RINGKASAN
  // =====================================================

  Widget _summaryItem(
    IconData icon,
    String title,
    String value,
    String subtitle,
    String? percent,
    Color color,
  ) {
    return SizedBox(
      height: 31,
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 12,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 6.5,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 1),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 1),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 5.5,
                    height: 1,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),

          if (percent != null) ...[
            const SizedBox(width: 2),

            Text(
              percent,
              style: const TextStyle(
                fontSize: 7,
                height: 1,
                fontWeight: FontWeight.bold,
                color: Color(0xFF22C55E),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // =====================================================
  // NEW ACTIVITY
  // =====================================================

  Widget _buildActivityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE8EEF5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // BARIS PERTAMA

          Row(
            children: [
              Expanded(
                child: _activityItem(
                  'Distribusi baru',
                  'Outlet Rungkut',
                  '10:32',
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _activityItem(
                  'Setoran diterima',
                  'Outlet Sukolilo',
                  '09:20',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // BARIS KEDUA

          Row(
            children: [
              Expanded(
                child: _activityItem(
                  'Produk ditambahkan',
                  'Produk A',
                  '09:45',
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _activityItem(
                  'Retur tercatat',
                  'Outlet Wonokromo',
                  '08:55',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // ITEM AKTIVITAS
  // =====================================================

  Widget _activityItem(
    String title,
    String subtitle,
    String time,
  ) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 38,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Text(
            '•',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.1,
                    color: Color(0xFF16A34A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              height: 1,
              fontWeight: FontWeight.bold,
              color: Color(0xFF16A34A),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  void _showLogoutDialog() {
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

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
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

// =========================================================
// CUSTOM PAINTER GRAFIK DISTRIBUSI
// =========================================================

class _DashboardChartPainter extends CustomPainter {
  const _DashboardChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const double maxValue = 200;
    const int steps = 4;
    const double leftMargin = 24;
    const double bottomMargin = 36;

    final double chartWidth =
        size.width - leftMargin - 2;

    final double chartHeight =
        size.height - bottomMargin;

    final Paint gridPaint = Paint()
      ..color = const Color(0xFFE8EEF5)
      ..strokeWidth = 0.7;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // GARIS GRID DAN ANGKA SUMBU Y

    for (int i = 0; i <= steps; i++) {
      final double value =
          maxValue - (maxValue / steps) * i;

      final double y =
          (chartHeight / steps) * i;

      canvas.drawLine(
        Offset(leftMargin, y),
        Offset(size.width, y),
        gridPaint,
      );

      textPainter.text = TextSpan(
        text: value.toInt().toString(),
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 6.5,
        ),
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(0, y - 4),
      );
    }

    // DATA GRAFIK

    const List<double> lineData = [
      120,
      140,
      105,
      165,
      155,
      130,
      170,
    ];

    const List<double> barData = [
      80,
      95,
      75,
      120,
      110,
      100,
      135,
    ];

    const List<List<String>> labels = [
      ['Sen', '15 Sep'],
      ['Sel', '16 Sep'],
      ['Rab', '17 Sep'],
      ['Kam', '18 Sep'],
      ['Jum', '19 Sep'],
      ['Sab', '20 Sep'],
      ['Min', '21 Sep'],
    ];

    final double interval =
        chartWidth / lineData.length;

    final Paint barPaint = Paint()
      ..color = const Color(0xFF7CB8FF)
      ..style = PaintingStyle.fill;

    final Paint linePaint = Paint()
      ..color = const Color(0xFFFF7100)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = const Color(0xFFFF7100)
      ..style = PaintingStyle.fill;

    final Path linePath = Path();
    final List<Offset> points = [];

    // BATANG DAN LABEL GRAFIK

    for (int i = 0; i < lineData.length; i++) {
      final double x =
          leftMargin + interval * i + interval / 2;

      final double barHeight =
          (barData[i] / maxValue) * chartHeight;

      final Rect barRect = Rect.fromLTRB(
        x - 8,
        chartHeight - barHeight,
        x + 8,
        chartHeight,
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          barRect,
          const Radius.circular(2),
        ),
        barPaint,
      );

      // NILAI BATANG

      textPainter.text = TextSpan(
        text: barData[i].toInt().toString(),
        style: const TextStyle(
          color: Color(0xFF5C9FF5),
          fontSize: 6.5,
          fontWeight: FontWeight.w600,
        ),
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          chartHeight - barHeight - 10,
        ),
      );

      // HARI

      textPainter.text = TextSpan(
        text: labels[i][0],
        style: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 7,
          fontWeight: FontWeight.w600,
        ),
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          chartHeight + 7,
        ),
      );

      // TANGGAL

      textPainter.text = TextSpan(
        text: labels[i][1],
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 5.5,
        ),
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          chartHeight + 18,
        ),
      );

      // TITIK GARIS

      final double lineY =
          chartHeight -
          (lineData[i] / maxValue) * chartHeight;

      final Offset point = Offset(x, lineY);

      points.add(point);

      if (i == 0) {
        linePath.moveTo(x, lineY);
      } else {
        linePath.lineTo(x, lineY);
      }
    }

    // AREA TRANSPARAN

    final Path areaPath = Path.from(linePath)
      ..lineTo(points.last.dx, chartHeight)
      ..lineTo(points.first.dx, chartHeight)
      ..close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFF7100).withOpacity(0.12),
          const Color(0xFFFF7100).withOpacity(0.0),
        ],
      ).createShader(
        Rect.fromLTRB(
          leftMargin,
          0,
          size.width,
          chartHeight,
        ),
      );

    canvas.drawPath(areaPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    // TITIK DAN NILAI GARIS

    for (int i = 0; i < points.length; i++) {
      final Offset point = points[i];

      canvas.drawCircle(
        point,
        2.5,
        Paint()..color = Colors.white,
      );

      canvas.drawCircle(
        point,
        1.8,
        dotPaint,
      );

      textPainter.text = TextSpan(
        text: lineData[i].toInt().toString(),
        style: const TextStyle(
          color: Color(0xFFFF7100),
          fontSize: 6.5,
          fontWeight: FontWeight.w600,
        ),
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          point.dx - textPainter.width / 2,
          point.dy - 10,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}