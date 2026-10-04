import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_setoran_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_struk_page.dart';
import 'admin_laporan_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FB),
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 155,
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

                // MAIN MENU
                _sideBox(
                  context: context,
                  title: 'MAIN MENU',
                  items: const ['Dashboard'],
                  activeIndex: 0,
                ),

                const SizedBox(height: 12),

                // KEUANGAN
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

                // LAPORAN
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
                // HEADER
                Container(
                  height: 105,
                  color: const Color(0xFFF2F6FB),
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 35,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DASHBOARD ADMIN KEUANGAN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2D42),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Kelola data setoran, bagi hasil, dan struk transparansi',
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 60,
                      right: 60,
                      top: 40,
                    ),
                    child: Column(
                      children: [
                        // ================= STAT CARDS =================
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            _statCard(
                              'Total Setoran',
                              'Rp 4.250.000',
                            ),

                            const SizedBox(width: 38),

                            _statCard(
                              'Bagi Hasil',
                              'Rp 1.275.000',
                            ),

                            const SizedBox(width: 38),

                            _statCard(
                              'Struk Terbit',
                              '38',
                            ),
                          ],
                        ),

                        const SizedBox(height: 65),

                        // ================= SETORAN TERBARU =================
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 520,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Setoran Terbaru',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(7),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Rungkut',
                                              '+ Rp 150.000',
                                              '11:15',
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Sukolilo',
                                              '+ Rp 120.000',
                                              '12:30',
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Wonokromo',
                                              '+ Rp 200.000',
                                              '13:00',
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: _historyItem(
                                              'Outlet Rungkut',
                                              '+ Rp 100.000',
                                              '14:45',
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
                    _navigateAdmin(
                      context,
                      items[index],
                    );
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

static void _navigateAdmin(
  BuildContext context,
  String item,
) {
  if (item == 'Dashboard') {
    return;
  }

  if (item == 'Setoran') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminSetoranPage(),
      ),
    );
  }

  if (item == 'Bagi Hasil') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminBagiHasilPage(),
      ),
    );
  }

  if (item == 'Struk Transparansi') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const StrukTransparansiPage(),
      ),
    );
  }

  if (item == 'Laporan Keuangan') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminLaporanKeuanganPage(),
      ),
    );
  }
}

  // ================= STAT CARD =================

  static Widget _statCard(
    String title,
    String value,
  ) {
    return Container(
      width: 175,
      height: 75,
      padding: const EdgeInsets.all(12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF60738F),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ================= HISTORY ITEM =================

  static Widget _historyItem(
    String outlet,
    String amount,
    String time,
  ) {
    return Container(
      height: 37,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EBF4),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '• $outlet',
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF32629A),
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A64F),
                  ),
                ),
              ],
            ),
          ),

          Text(
            time,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00A64F),
            ),
          ),
        ],
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