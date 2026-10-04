import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_setoran_page.dart';
import 'admin_struk_page.dart';
import 'admin_laporan_page.dart';

class AdminBagiHasilPage extends StatefulWidget {
  const AdminBagiHasilPage({super.key});
  @override
  State<AdminBagiHasilPage> createState() =>
      _AdminBagiHasilPageState();
}
class _AdminBagiHasilPageState extends State<AdminBagiHasilPage> {
  String periode = 'September 2026';
  String outlet = 'Semua Outlet';
    // ================= PILIH PERIODE =================

  void _pilihPeriode() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pilih Periode'),
          children: [
            'September 2026',
            'Agustus 2026',
            'Juli 2026',
          ].map((item) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  periode = item;
                });

                Navigator.pop(context);
              },
              child: Text(item),
            );
          }).toList(),
        );
      },
    );
  }


  // ================= PILIH OUTLET =================

  void _pilihOutlet() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pilih Outlet'),
          children: [
            'Semua Outlet',
            'Rungkut',
            'Sukolilo',
            'Wonokromo',
          ].map((item) {
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  outlet = item;
                });

                Navigator.pop(context);
              },
              child: Text(item),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FB),
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 150,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 22),

                const Text(
                  'FOOD FLOW',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B00),
                  ),
                ),

                const SizedBox(height: 25),

                _sideBox(
                  context: context,
                  title: 'MAIN MENU',
                  items: const ['Dashboard'],
                  activeIndex: -1,
                ),

                const SizedBox(height: 12),

                _sideBox(
                  context: context,
                  title: 'KEUANGAN',
                  items: const [
                    'Setoran',
                    'Bagi Hasil',
                    'Struk Transparansi',
                  ],
                  activeIndex: 1,
                ),

                const SizedBox(height: 12),

                _sideBox(
                  context: context,
                  title: 'LAPORAN',
                  items: const ['Laporan Keuangan'],
                  activeIndex: -1,
                ),

                const Spacer(),
                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      '• Logout',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF60738F),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================= CONTENT =================
          Expanded(
            child: Column(
              children: [
                // ================= HEADER =================
                Container(
                  height: 105,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 50,
                  ),
                  child: Row(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BAGI HASIL',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2D42),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Kalkulasi dan pencatatan bagi hasil mitra outlet',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF60738F),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ROLE ADMIN
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B00),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 13,
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

                // ================= BODY =================
                Expanded(
                  child: Center(
                    child: Container(
                      width: 520,
                      height: 430,
                      padding: const EdgeInsets.fromLTRB(
                        55,
                        28,
                        55,
                        25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // ================= FILTER =================
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Periode',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _dropdown(
                                    periode,
                                    width: 110,
                                    onTap: () {
                                      _pilihPeriode();
                                    },
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Outlet',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _dropdown(
                                    outlet,
                                    width: 110,
                                    onTap: () {
                                      _pilihOutlet();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 45),

                          // ================= TABLE =================
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1.3),
                              1: FlexColumnWidth(1.4),
                              2: FlexColumnWidth(1.3),
                              3: FlexColumnWidth(1.0),
                            },
                            children: [
                              TableRow(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF9EA8B5),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                children: [
                                  _tableHeader('Outlet'),
                                  _tableHeader('Penjualan'),
                                  _tableHeader('Bagi Hasil'),
                                  _tableHeader('Status'),
                                ],
                              ),

                              TableRow(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF9EA8B5),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                children: [
                                  _tableText('Rungkut'),
                                  _tableText('Rp 350.000'),
                                  _tableText('Rp 105.000'),
                                  _statusText('Selesai'),
                                ],
                              ),

                              TableRow(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF9EA8B5),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                children: [
                                  _tableText('Wonokromo'),
                                  _tableText('Rp 420.000'),
                                  _tableText('Rp 126.000'),
                                  _statusText('Selesai'),
                                ],
                              ),
                            ],
                          ),

                          const Spacer(),

                          // ================= CETAK =================
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 90,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Struk bagi hasil siap dicetak.',
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF6B00),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Cetak Struk',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  // ================= SIDEBAR BOX =================

// ================= SIDEBAR BOX =================

static Widget _sideBox({
  required BuildContext context,
  required String title,
  required List<String> items,
  required int activeIndex,
}) {
  return Container(
    width: 130,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7EF),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Color(0xFF60738F),
          ),
        ),
        const SizedBox(height: 4),

        ...List.generate(
          items.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  mouseCursor: SystemMouseCursors.click,
                  onTap: () {
                    _navigate(context, items[index]);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 22,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '• ${items[index]}',
                        style: TextStyle(
                          fontSize: 9,
                          color: index == activeIndex
                              ? const Color(0xFFFF6B00)
                              : const Color(0xFF60738F),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

static void _navigate(
  BuildContext context,
  String item,
) {
  if (item == 'Dashboard') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminDashboardPage(),
      ),
    );
  } else if (item == 'Setoran') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminSetoranPage(),
      ),
    );
  } else if (item == 'Bagi Hasil') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminBagiHasilPage(),
      ),
    );
  } else if (item == 'Struk Transparansi') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const StrukTransparansiPage(),
      ),
    );
  } else if (item == 'Laporan Keuangan') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminLaporanKeuanganPage(),
      ),
    );
  }
}

  // ================= DROPDOWN =================

  Widget _dropdown(
  String text, {
  required double width,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    mouseCursor: SystemMouseCursors.click,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      width: width,
      height: 27,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(
          color: const Color(0xFF8D9BAD),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Color(0xFF60738F),
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            size: 15,
            color: Color(0xFF60738F),
          ),
        ],
      ),
    ),
  );
}

  // ================= TABLE HEADER =================

  static Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 3,
        bottom: 7,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // ================= TABLE TEXT =================

  static Widget _tableText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 7,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // ================= STATUS =================

  static Widget _statusText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 7,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00A64F),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Yakin ingin keluar?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Anda akan keluar dari akun FoodFlow saat ini.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B00),
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