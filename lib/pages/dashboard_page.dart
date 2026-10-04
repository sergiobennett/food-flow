import 'package:flutter/material.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'login_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Row(
        children: [

          // =========================
          // SIDEBAR
          // =========================
          Container(
            width: 180,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 25),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "FOOD FLOW",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF7100),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                _menuTitle("MAIN MENU"),

                _menuItem(
                  Icons.dashboard,
                  "Dashboard",
                  selected: true,
                ),

                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MasterDataPage(),
                      ),
                    );
                  },
                  child: _menuTitle("MASTER DATA"),
                ),

                _menuItem(
                  Icons.inventory_2_outlined,
                  "Produk",
                ),

                _menuItem(
                  Icons.store_outlined,
                  "Outlet",
                ),

                _menuItem(
                  Icons.people_outline,
                  "Penjual",
                ),

                const SizedBox(height: 15),

                // =========================
                // TRANSAKSI
                // =========================
                _menuTitle("TRANSAKSI"),

                _menuItem(
                  Icons.local_shipping_outlined,
                  "Distribusi",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DistribusiPage(),
                      ),
                    );
                  },
                ),

                _menuItem(
                  Icons.assignment_return_outlined,
                  "Retur",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReturPage(),
                      ),
                    );
                  },
                ),

                _menuItem(
                  Icons.payments_outlined,
                  "Setoran",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetoranPage(),
                      ),
                    );
                  },
                ),

                _menuItem(
                  Icons.share_outlined,
                  "Bagi Hasil",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BagiHasilPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                _menuTitle("LAPORAN"),

                _menuItem(
                  Icons.description_outlined,
                  "Laporan",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LaporanPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                _menuTitle("AKUN"),

                _menuItem(
                  Icons.person_outline,
                  "Profil",
                ),

                _menuItem(
                  Icons.logout,
                  "LogOut",
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),

          // =========================
          // MAIN CONTENT
          // =========================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // HEADER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: const [

                          Text(
                            "DASHBOARD OWNER",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17243A),
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Pantau data distribusi dan performa bisnis secara terpusat",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7100),
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // STATISTIC CARDS
                  // =========================
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [

                      _statCard(
                        "PRODUK",
                        "15",
                      ),

                      const SizedBox(width: 15),

                      _statCard(
                        "OUTLET",
                        "8",
                      ),

                      const SizedBox(width: 15),

                      _statCard(
                        "PENJUALAN",
                        "10",
                      ),

                      const SizedBox(width: 15),

                      _statCard(
                        "DISTRIBUSI",
                        "125",
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // PERFORMANCE CARD
                  // =========================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.08),
                          blurRadius: 10,
                          offset:
                              const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [

                            Row(
                              children: [

                                Container(
                                  padding:
                                      const EdgeInsets
                                          .all(10),
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xFFFFEEE1,
                                    ),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      10,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.bar_chart,
                                    color:
                                        Color(0xFFFF7100),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                const Text(
                                  "Performa Distribusi",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Color(0xFF17243A),
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color(
                                    0xFFE2E8F0,
                                  ),
                                ),
                                borderRadius:
                                    BorderRadius.circular(
                                  6,
                                ),
                              ),
                              child: const Text(
                                "15 Sep 2026 - 21 Sep 2026",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        const Padding(
                          padding:
                              EdgeInsets.only(left: 50),
                          child: Text(
                            "Tren distribusi produk dalam 7 hari terakhir",
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  Color(0xFF718096),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          height: 230,
                          child: _DistributionChart(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // NEW ACTIVITY
                  // =========================
                  const Text(
                    "New Activity",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.07),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: _activity(
                                "Distribusi baru",
                                "Outlet Rungkut",
                                "10:32",
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: _activity(
                                "Setoran diterima",
                                "Outlet Sukolilo",
                                "09:20",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [

                            Expanded(
                              child: _activity(
                                "Produk ditambahkan",
                                "Produk A",
                                "09:45",
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: _activity(
                                "Retur tercatat",
                                "Outlet Wonokromo",
                                "08:55",
                              ),
                            ),
                          ],
                        ),
                      ],
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

  // =========================
  // MENU TITLE
  // =========================
  static Widget _menuTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        bottom: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Color(0xFF718096),
        ),
      ),
    );
  }

  // =========================
  // MENU ITEM
  // =========================
  Widget _menuItem(
    IconData icon,
    String title, {
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFF1E6)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFFFF6B00),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                  color: const Color(0xFFFF6B00),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // STAT CARD
  // =========================
  static Widget _statCard(
    String title,
    String value,
  ) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.12),
            blurRadius: 7,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ACTIVITY
  // =========================
  static Widget _activity(
    String title,
    String subtitle,
    String time,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEF5),
        borderRadius:
            BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                "• $title",
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF3867A5),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0A9F50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Text(
            time,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF0A9F50),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // LOGOUT DIALOG
  // =========================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
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
                    builder: (context) =>
                        const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFFF7518),
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


// ==================================================
// CHART
// ==================================================

class _DistributionChart extends StatelessWidget {
  const _DistributionChart();

  @override
  Widget build(BuildContext context) {

    final data = [
      80,
      95,
      75,
      120,
      110,
      100,
      135,
    ];

    final lineData = [
      120,
      140,
      100,
      160,
      155,
      130,
      170,
    ];

    final days = [
      "Sen",
      "Sel",
      "Rab",
      "Kam",
      "Jum",
      "Sab",
      "Min",
    ];

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [

        const SizedBox(
          width: 30,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "200",
                style: TextStyle(fontSize: 9),
              ),
              Text(
                "150",
                style: TextStyle(fontSize: 9),
              ),
              Text(
                "100",
                style: TextStyle(fontSize: 9),
              ),
              Text(
                "50",
                style: TextStyle(fontSize: 9),
              ),
              Text(
                "0",
                style: TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),

        Expanded(
          child: CustomPaint(
            painter: _ChartPainter(
              bars: data,
              lines: lineData,
              days: days,
            ),
          ),
        ),
      ],
    );
  }
}


class _ChartPainter extends CustomPainter {

  final List<int> bars;
  final List<int> lines;
  final List<String> days;

  _ChartPainter({
    required this.bars,
    required this.lines,
    required this.days,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {

    final paintGrid = Paint()
      ..color = const Color(0xFFE7EDF4)
      ..strokeWidth = 1;

    final paintBar = Paint()
      ..color = const Color(0xFF82B5FF);

    final paintLine = Paint()
      ..color = const Color(0xFFFF7100)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintPoint = Paint()
      ..color = const Color(0xFFFF7100)
      ..style = PaintingStyle.fill;

    const maxValue = 200.0;

    final chartHeight = size.height - 30;
    final spacing = size.width / bars.length;

    // Grid
    for (int i = 0; i < 5; i++) {

      final y =
          chartHeight - (i * chartHeight / 4);

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paintGrid,
      );
    }

    // Bars
    for (int i = 0; i < bars.length; i++) {

      final barHeight =
          (bars[i] / maxValue) *
              chartHeight;

      final x =
          spacing * i + spacing / 2 - 12;

      canvas.drawRect(
        Rect.fromLTWH(
          x,
          chartHeight - barHeight,
          24,
          barHeight,
        ),
        paintBar,
      );
    }

    // Line
    final path = Path();

    for (int i = 0; i < lines.length; i++) {

      final x =
          spacing * i + spacing / 2;

      final y =
          chartHeight -
              (lines[i] / maxValue) *
                  chartHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      canvas.drawCircle(
        Offset(x, y),
        3,
        paintPoint,
      );
    }

    canvas.drawPath(
      path,
      paintLine,
    );

    // Days
    for (int i = 0; i < days.length; i++) {

      final x =
          spacing * i + spacing / 2;

      final textPainter = TextPainter(
        text: TextSpan(
          text: days[i],
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF718096),
          ),
        ),
        textDirection:
            TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          x - textPainter.width / 2,
          chartHeight + 8,
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