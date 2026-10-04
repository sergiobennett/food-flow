import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF3F6FA),
    body: Row(
      children: [
        // =====================================================
        // SIDEBAR
        // =====================================================
        Container(
          width: 155,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(15, 25, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  "FOOD FLOW",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6B00),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              _sideBox(
                context,
                "MAIN MENU",
                ["Dashboard"],
              ),

              _sideBox(
                context,
                "MASTER DATA",
                ["Produk", "Outlet", "Penjual"],
              ),

              _sideBox(
                context,
                "TRANSAKSI",
                [
                  "Distribusi",
                  "Retur",
                  "Setoran",
                  "Bagi Hasil",
                ],
              ),

              _sideBox(
                context,
                "LAPORAN",
                ["Laporan"],
              ),

              _sideBox(
                context,
                "AKUN",
                ["Profil", "LogOut"],
              ),
            ],
          ),
        ),

        // =====================================================
        // CONTENT
        // =====================================================
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              25,
              30,
              30,
              25,
            ),
            child: SizedBox(
              width: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // JUDUL LAPORAN + OWNER
                  // =================================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "LAPORAN",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF243247),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Lihat rekapitulasi dan performa penjualan cabang/penjual.",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B00),
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // =================================================
                  // SEARCH
                  // =================================================
                  Container(
                    width: 255,
                    height: 32,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 15,
                          color: Color(0xFF64748B),
                        ),
                        SizedBox(width: 7),
                        Text(
                          "Cari laporan...",
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // STATISTIK
                  // =================================================
                  Row(
                    children: [
                      _statCard(
                        "PENJUALAN",
                        "3,25",
                      ),
                      _statCard(
                        "DISTRIBUSI",
                        "125",
                      ),
                      _statCard(
                        "RETUR",
                        "25",
                      ),
                      _statCard(
                        "LABA",
                        "1,2",
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // PERIODE
                  // =================================================
                  Container(
                    width: 700,
                    height: 145,
                    padding: const EdgeInsets.fromLTRB(
                      14,
                      13,
                      14,
                      10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFFF6B00),
                                borderRadius:
                                    BorderRadius.circular(7),
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),

                            const SizedBox(width: 8),

                            const Text(
                              "Periode",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Color(0xFF243247),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            _filterBox(
                              Icons.calendar_today,
                              "15 Sep",
                            ),

                            const SizedBox(width: 8),

                            _filterBox(
                              Icons.calendar_today,
                              "21 Sep",
                            ),

                            const SizedBox(width: 8),

                            _filterBox(
                              Icons.store_outlined,
                              "Semua Outlet",
                            ),
                          ],
                        ),

                        const Spacer(),

                        Align(
                          alignment:
                              Alignment.centerRight,
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  size: 13,
                                ),
                                label: const Text(
                                  "Tampilkan",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFFFF6B00,
                                  ),
                                  foregroundColor:
                                      Colors.white,
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 15,
                                    vertical: 9,
                                  ),
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      6,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 7),

                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.print_outlined,
                                  size: 13,
                                ),
                                label: const Text(
                                  "Cetak",
                                  style: TextStyle(
                                    fontSize: 9,
                                  ),
                                ),
                                style:
                                    OutlinedButton.styleFrom(
                                  foregroundColor:
                                      const Color(
                                    0xFFFF6B00,
                                  ),
                                  side:
                                      const BorderSide(
                                    color:
                                        Color(0xFFFF6B00),
                                  ),
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 15,
                                    vertical: 9,
                                  ),
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      6,
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

                  const SizedBox(height: 20),

                  // =================================================
                  // PERFORMA PENJUALAN + TABEL
                  // =================================================
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 165,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(
                            top: 12,
                          ),
                          child: const Text(
                            "Performa Penjualan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.08),
                              blurRadius: 8,
                              offset:
                                  const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 38,
                              decoration:
                                  const BoxDecoration(
                                color:
                                    Color(0xFFFF7043),
                                borderRadius:
                                    BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _tableHeader("OUTLET"),
                                  _tableHeader("PENJUAL"),
                                  _tableHeader("PENJUALAN"),
                                  _tableHeader("RETUR"),
                                ],
                              ),
                            ),

                            _tableRow(
                              "Outlet A",
                              "Andi",
                              "500.000",
                              "500.000",
                            ),

                            _tableRow(
                              "Outlet B",
                              "Budi",
                              "450.000",
                              "200.000",
                            ),

                            _tableRow(
                              "Outlet C",
                              "Citra",
                              "600.000",
                              "90.000",
                            ),

                            _tableRow(
                              "Outlet D",
                              "Bnnet",
                              "500.000",
                              "100.000",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // =================================================
                  // KEMBALI
                  // =================================================
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFFF6B00),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 11,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        "KEMBALI",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight:
                              FontWeight.bold,
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
  );
}

  // ===========================================================
  // SIDEBAR
  // ===========================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Yakin ingin keluar?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Anda akan keluar dari akun FoodFlow saat ini.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7518), foregroundColor: Colors.white),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

Widget _sideBox(
    BuildContext context,
    String title,
    List<String> items,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
              ),
            ),
          ),

          ...items.map(
            (item) => InkWell(
              onTap: () {
                if (item == "Dashboard") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardPage(),
                    ),
                  );
                } else if (item == "Distribusi") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DistribusiPage(),
                    ),
                  );
                } else if (item == "Retur") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ReturPage(),
                    ),
                  );
                } else if (item == "Setoran") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SetoranPage(),
                    ),
                  );
                } else if (item == "Bagi Hasil") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BagiHasilPage(),
                    ),
                  );
                } else if (item == "LogOut") {
                  _showLogoutDialog(context);
                }
              },
              borderRadius: BorderRadius.circular(5),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                ),
                child: Text(
                  "• $item",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFFFF6B00),
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // STAT CARD
  // ===========================================================

  static Widget _statCard(
    String title,
    String value,
  ) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202020),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // FILTER BOX
  // ===========================================================

  static Widget _filterBox(
    IconData icon,
    String text,
  ) {
    return Container(
      width: 125,
      height: 32,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12,
            color: const Color(0xFF64748B),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF334155),
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 14,
            color: Color(0xFF64748B),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // TABLE HEADER
  // ===========================================================

  static Widget _tableHeader(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // TABLE ROW
  // ===========================================================

  static Widget _tableRow(
    String outlet,
    String penjual,
    String penjualan,
    String retur,
  ) {
    return Container(
      height: 43,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          _tableCell(outlet),
          _tableCell(penjual),
          _tableCell(penjualan),
          _tableCell(retur),
        ],
      ),
    );
  }

  static Widget _tableCell(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF243247),
          ),
        ),
      ),
    );
  }
}