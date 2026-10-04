import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_setoran_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_struk_page.dart';

class AdminLaporanKeuanganPage extends StatefulWidget {
  const AdminLaporanKeuanganPage({super.key});

  @override
  State<AdminLaporanKeuanganPage> createState() =>
      _AdminLaporanKeuanganPageState();
}

class _AdminLaporanKeuanganPageState
    extends State<AdminLaporanKeuanganPage> {
      String periode = 'September 2026';
      String outlet = 'Semua Outlet';
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
                  activeIndex: -1,
                ),

                const SizedBox(height: 12),

                _sideBox(
                  context: context,
                  title: 'LAPORAN',
                  items: const ['Laporan Keuangan'],
                  activeIndex: 0,
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
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LAPORAN KEUANGAN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2D42),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Ringkasan pemasukan dan pembagian hasil',
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
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B00),
                          borderRadius:
                              BorderRadius.circular(7),
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
                      width: 620,
                      padding: const EdgeInsets.fromLTRB(
                        30,
                        25,
                        30,
                        20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // ================= FILTER =================
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Periode',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _dropdown(
                                    periode,
                                    onTap: _pilihPeriode,
                                  ),
                                ],
                              ),

                              const SizedBox(width: 30),

                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Outlet',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _dropdown(
                                    outlet,
                                    onTap: _pilihOutlet,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // ================= RINGKASAN =================
                          Row(
                            children: [
                              Expanded(
                                child: _summaryCard(
                                  'Total Setoran',
                                  'Rp 4.250.000',
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _summaryCard(
                                  'Total Bagi Hasil',
                                  'Rp 1.275.000',
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _summaryCard(
                                  'Pendapatan Bersih',
                                  'Rp 2.975.000',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // ================= TABLE =================
                          const Text(
                            'Detail Laporan',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1.2),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(1.4),
                              3: FlexColumnWidth(1.4),
                            },
                            children: [
                              TableRow(
                                decoration:
                                    const BoxDecoration(
                                  color: Color(0xFFE9EEF5),
                                ),
                                children: [
                                  _header('Outlet'),
                                  _header('Total Setoran'),
                                  _header('Bagi Hasil'),
                                  _header('Pendapatan Bersih'),
                                ],
                              ),

                              _dataRow(
                                'Rungkut',
                                'Rp 1.500.000',
                                'Rp 450.000',
                                'Rp 1.050.000',
                              ),

                              _dataRow(
                                'Sukolilo',
                                'Rp 1.250.000',
                                'Rp 375.000',
                                'Rp 875.000',
                              ),

                              _dataRow(
                                'Wonokromo',
                                'Rp 1.500.000',
                                'Rp 450.000',
                                'Rp 1.050.000',
                              ),
                            ],
                          ),

                          const Spacer(),

                          // ================= BUTTON =================
                          Align(
                            alignment:
                                Alignment.bottomRight,
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 95,
                                  height: 32,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(
                                              0xFFD9DCE0),
                                      foregroundColor:
                                          const Color(
                                              0xFF60738F),
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Kembali',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 95,
                                  height: 32,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(
                                              0xFFFF6B00),
                                      foregroundColor:
                                          Colors.white,
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                6),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cetak Laporan',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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

  // ================= SIDEBAR =================

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
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    mouseCursor: SystemMouseCursors.click,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      width: 125,
      height: 28,
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(
          color: const Color(0xFF8D9BAD),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF60738F),
              fontWeight: FontWeight.bold,
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

  // ================= SUMMARY CARD =================

  static Widget _summaryCard(
    String title,
    String value,
  ) {
    return Container(
      height: 62,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE0E5EB),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF60738F),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ================= TABLE HEADER =================

  static Widget _header(String text) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // ================= TABLE ROW =================

  static TableRow _dataRow(
    String outlet,
    String setoran,
    String bagiHasil,
    String bersih,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD5DAE0),
          ),
        ),
      ),
      children: [
        _cell(outlet),
        _cell(setoran),
        _cell(bagiHasil),
        _cell(bersih),
      ],
    );
  }

  static Widget _cell(String text) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 7,
          color: Colors.black,
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