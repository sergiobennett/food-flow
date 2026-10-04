import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_setoran_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_laporan_page.dart';

class StrukTransparansiPage extends StatelessWidget {
  const StrukTransparansiPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FC),
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 150,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 25),

                const Text(
                  'FOOD FLOW',
                  style: TextStyle(
                    color: Color(0xFFFF6F00),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                _sideBox(
                  context: context,
                  title: 'MAIN MENU',
                  items: const ['Dashboard'],
                  activeIndex: -1,
                ),

                const SizedBox(height: 15),

                _sideBox(
                  context: context,
                  title: 'KEUANGAN',
                  items: const [
                    'Setoran',
                    'Bagi Hasil',
                    'Struk Transparansi',
                  ],
                  activeIndex: 2,
                ),

                const SizedBox(height: 15),

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
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      '• Logout',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================= KONTEN =================
          Expanded(
            child: Column(
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25,
                    30,
                    50,
                    0,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'STRUK TRANSPARANSI',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263548),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Kelola dan cetak bukti transaksi untuk mitra',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF60758F),
                            ),
                          ),
                        ],
                      ),

                      // ADMIN
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6F00),
                          borderRadius:
                              BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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
                ),

                const SizedBox(height: 45),

                // JUDUL RIWAYAT
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 115,
                    ),
                    child: const Text(
                      'Riwayat Struk',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ================= RIWAYAT STRUK =================
                Container(
                  width: 520,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFCFC),
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _receiptCard(
                              context,
                              'Setoran – Outlet Rungkut',
                              '+ Rp 150.000',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _receiptCard(
                              context,
                              'Setoran – Outlet Sukolilo',
                              '+ Rp 120.000',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _receiptCard(
                              context,
                              'Setoran – Outlet Wonokromo',
                              '+ Rp 200.000',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _receiptCard(
                              context,
                              'Setoran – Outlet Rungkut',
                              '+ Rp 100.000',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // ================= BUTTON BAWAH =================
                Padding(
                  padding: const EdgeInsets.only(
                    right: 55,
                    bottom: 25,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      _orangeButton(
                        'Kembali',
                        () {
                          Navigator.pop(context);
                        },
                      ),

                      const SizedBox(width: 15),

                      _orangeButton(
                        'Cetak',
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Semua struk berhasil dipilih untuk dicetak.',
                              ),
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
  // ================= RECEIPT CARD =================
static Widget _receiptCard(
  BuildContext context,
  String title,
  String amount,
) {
  return Container(
    height: 36,
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFE3EAF3),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• $title',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF35639B),
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00A63C),
                ),
              ),
            ],
          ),
        ),

        // ================= TOMBOL CETAK =================
        SizedBox(
          height: 25,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$title berhasil dipilih untuk dicetak.',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6F00),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Cetak',
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  // ================= BUTTON =================

  static Widget _orangeButton(
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color(0xFFFF6F00),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
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

}