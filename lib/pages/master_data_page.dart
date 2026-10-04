import 'package:flutter/material.dart';
import 'produk_page.dart';
import 'outlet_page.dart';
import 'penjual_page.dart';
import 'dashboard_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'login_page.dart';

class MasterDataPage extends StatelessWidget {
  const MasterDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),

      body: Row(
        children: [

          // =========================
          // SIDEBAR
          // =========================
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

                // =========================
                // MAIN MENU
                // =========================
                _sideBox(
                  context,
                  "MAIN MENU",
                  ["Dashboard"],
                ),

                // =========================
                // MASTER DATA
                // =========================
                _sideBox(
                  context,
                  "MASTER DATA",
                  ["Produk", "Outlet", "Penjual"],
                ),

                // =========================
                // TRANSAKSI
                // =========================
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

                // =========================
                // LAPORAN
                // =========================
                _sideBox(
                  context,
                  "LAPORAN",
                  ["Laporan"],
                ),

                // =========================
                // AKUN
                // =========================
                _sideBox(
                  context,
                  "AKUN",
                  ["Profil", "LogOut"],
                ),
              ],
            ),
          ),

          // =========================
          // CONTENT MASTER DATA
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TOP BAR
                Container(
                  height: 65,
                  color: Colors.orange,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),

                  child: Row(
                    children: [

                      const Text(
                        "Master Data",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),

                        child: const Row(
                          children: [

                            Text(
                              "Owner",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(width: 5),

                            Icon(
                              Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // =========================
                // ISI
                // =========================
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "MASTER DATA",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF243247),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Kelola data utama yang digunakan dalam proses distribusi.",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // =========================
                        // MASTER CARDS
                        // =========================
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              // PRODUK
                              _masterCard(
                                icon: Icons.inventory_2_outlined,
                                title: "Master Produk",
                                description:
                                    "Kelola data produk yang didistribusikan.",
                                total: "15",
                                label: "Data Produk",
                                color: Colors.orange,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProdukPage(),
                                    ),
                                  );
                                },
                              ),

                              // OUTLET
                              _masterCard(
                                icon: Icons.store_outlined,
                                title: "Master Outlet",
                                description:
                                    "Kelola data outlet tempat produk didistribusikan.",
                                total: "8",
                                label: "Data Outlet",
                                color: Colors.blue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OutletPage(),
                                    ),
                                  );
                                },
                              ),

                              // PENJUAL
                              _masterCard(
                                icon: Icons.person_outline,
                                title: "Master Penjual",
                                description:
                                    "Kelola data penjual yang terhubung dengan outlet.",
                                total: "10",
                                label: "Data Penjual",
                                color: Colors.green,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PenjualPage(),
                                    ),
                                  );
                                },
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
          ),
        ],
      ),
    );
  }

  // =========================
  // SECTION TITLE
  // =========================

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

          // JUDUL SECTION
          InkWell(
            onTap: () {
              // MASTER DATA tetap di halaman ini
              if (title == "MASTER DATA") {
                return;
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
          ),

          // ITEM
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

                } else if (item == "Laporan") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LaporanPage(),
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
                  style: TextStyle(
                    fontSize: 10,
                    color: item == "LogOut"
                        ? Colors.red
                        : const Color(0xFFFF6B00),
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
              child: const Text(
                'Batal',
              ),
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
              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // MASTER CARD
  // =========================

  static Widget _masterCard({
    required IconData icon,
    required String title,
    required String description,
    required String total,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        height: 445,
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(25),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ICON
            Container(
              width: 65,
              height: 65,

              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Icon(
                icon,
                size: 35,
                color: color,
              ),
            ),

            const SizedBox(height: 20),

            // TITLE
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF243247),
              ),
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            SizedBox(
              height: 50,
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TOTAL
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: const Color(0xFFF3F6FA),
                borderRadius:
                    BorderRadius.circular(10),
              ),

              child: Row(
                children: [

                  Icon(
                    icon,
                    color: color,
                    size: 25,
                  ),

                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        total,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: onTap,

                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),

                child: const Text(
                  "Kelola Data  →",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}