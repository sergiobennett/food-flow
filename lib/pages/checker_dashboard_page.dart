import 'package:flutter/material.dart';
import 'login_page.dart';
import 'input_stok_bawaan_page.dart';
import 'input_stok_retur_page.dart';

class CheckerDashboardPage extends StatelessWidget {
  const CheckerDashboardPage({super.key});

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
                backgroundColor: const Color(0xFFFF7518),
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
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
                    'FOOD FLOW',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B00),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                _sideBox(
                  'MAIN MENU',
                  ['Dashboard'],
                ),

                _sideBox(
                  'STOK GUDANG',
                  ['Stok Bawaan', 'Stok Retur'],
                ),

                _sideBox(
                  'DISTRIBUSI',
                  ['Distribusi Produk'],
                ),

                _sideBox(
                  'LAPORAN',
                  ['Riwayat Stok'],
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 17, bottom: 8),
                    child: Text(
                      '• Logout',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 17, bottom: 5),
                  child: Text(
                    'Checker',
                    style: TextStyle(fontSize: 10, color: Color(0xFF718096)),
                  ),
                ),
              ],
            ),
          ),

          // =====================================================
          // MAIN CONTENT
          // =====================================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30, 28, 30, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // HEADER
                  // =================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DASHBOARD CHECKER',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17243A),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Kelola pencatatan stok bawaan dan retur harian',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      // ROLE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7100),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Checker',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 30),

                  // =================================================
                  // STOK BAWAAN + STOK RETUR
                  // =================================================
                  Row(
                    children: [
                      Expanded(
                        child: _stockCard(
                          title: 'Stok Bawaan',
                          subtitle: 'Input Stok Pagi',
                          buttonText: '+ Input Stok',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const InputStokBawaanPage(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: _stockCard(
                          title: 'Stok Retur',
                          subtitle: 'Input stok retur sore',
                          buttonText: '+ Input Retur',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const InputStokReturPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // =================================================
                  // RIWAYAT INPUT HARI INI
                  // =================================================
                  const Text(
                    'Riwayat Input Hari Ini',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF17243A),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _historyItem(
                                'Input Stok Bawaan',
                                'Outlet Rungkut',
                                '07:15',
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _historyItem(
                                'Input Stok Retur',
                                'Outlet Sukolilo',
                                '16:30',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: _historyItem(
                                'Input Stok Bawaan',
                                'Outlet Wonokromo',
                                '07:30',
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _historyItem(
                                'Input Stok Retur',
                                'Outlet Rungkut',
                                '17:30',
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

  // ===========================================================
  // STOCK CARD
  // ===========================================================

  Widget _stockCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 110,
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17243A),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF718096),
            ),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 27,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B00),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // HISTORY ITEM
  // ===========================================================

  Widget _historyItem(
    String title,
    String outlet,
    String time,
  ) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEF5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '• $title',
                  style: const TextStyle(
                    fontSize: 7,
                    color: Color(0xFF3970B5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  outlet,
                  style: const TextStyle(
                    fontSize: 7,
                    color: Color(0xFF00A651),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Text(
            time,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF00A651),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // SIDEBAR BOX
  // ===========================================================

  Widget _sideBox(
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B),
            ),
          ),

          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                '• $item',
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFFFF6B00),
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}