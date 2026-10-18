import 'package:flutter/material.dart';

import 'checker_sidebar.dart';
import 'login_page.dart';
import 'input_stok_bawaan_page.dart';
import 'input_stok_retur_page.dart';
import 'distribusi_produk_page.dart';
import 'laporan_riwayat_stok_page.dart';

// =========================================================
// WARNA DASHBOARD CHECKER
// =========================================================

const Color checkerOrange = Color(0xFFFF7100);
const Color checkerBackground = Color(0xFFF0F5FA);
const Color checkerDark = Color(0xFF263238);
const Color checkerMuted = Color(0xFF718096);

// =========================================================
// DASHBOARD CHECKER
// =========================================================

class CheckerDashboardPage extends StatelessWidget {
  const CheckerDashboardPage({super.key});

  // =====================================================
  // LOGOUT
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
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

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: checkerOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR
  // =====================================================

  void _handleMenuTap(
    BuildContext context,
    String item,
  ) {
    switch (item) {
      case 'Dashboard':
        // Sudah berada di Dashboard Checker.
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const DistribusiPage(),
          ),
        );
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
        _showLogoutDialog(context);
        break;
    }
  }

  // =====================================================
  // BUILD DASHBOARD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: checkerBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR CHECKER
          // Menggunakan komponen sidebar yang sama
          // dengan halaman Distribusi dan Riwayat Stok.

          CheckerSidebar(
            activeItem: 'Dashboard',
            onSelected: (item) =>
                _handleMenuTap(context, item),
          ),

          // KONTEN UTAMA

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                26,
                42,
                40,
                24,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // HEADER DASHBOARD

                          _buildHeader(),

                          const SizedBox(height: 25),

                          // KARTU STOK

                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 6,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(
                                  maxWidth: 840,
                                ),
                                child: LayoutBuilder(
                                  builder: (
                                    context,
                                    boxConstraints,
                                  ) {
                                    // LAYOUT UNTUK LAYAR SEMPIT

                                    if (boxConstraints.maxWidth <
                                        500) {
                                      return Column(
                                        children: [
                                          _stockCard(
                                            title: 'Stok Bawaan',
                                            subtitle:
                                                'Input Stok Pagi',
                                            buttonText:
                                                '+ Input Stok',
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

                                          const SizedBox(
                                            height: 16,
                                          ),

                                          _stockCard(
                                            title: 'Stok Retur',
                                            subtitle:
                                                'Input stok retur sore',
                                            buttonText:
                                                '+ Input Retur',
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
                                        ],
                                      );
                                    }

                                    // LAYOUT UNTUK LAYAR LEBAR

                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // KARTU STOK BAWAAN

                                        Expanded(
                                          child: _stockCard(
                                            title: 'Stok Bawaan',
                                            subtitle:
                                                'Input Stok Pagi',
                                            buttonText:
                                                '+ Input Stok',
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

                                        const SizedBox(
                                          width: 18,
                                        ),

                                        // KARTU STOK RETUR

                                        Expanded(
                                          child: _stockCard(
                                            title: 'Stok Retur',
                                            subtitle:
                                                'Input stok retur sore',
                                            buttonText:
                                                '+ Input Retur',
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
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 36),

                          // JUDUL RIWAYAT INPUT

                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Riwayat Input Hari Ini',
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // KARTU RIWAYAT INPUT

                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 6,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(
                                  maxWidth: 840,
                                ),
                                child: _buildHistoryCard(),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // HEADER DASHBOARD + BADGE AKTOR CHECKER
  // Badge statis, tidak memiliki aksi untuk mengganti aktor.
  // =====================================================

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DASHBOARD CHECKER',
                style: TextStyle(
                  fontSize: 19,
                  height: 1.2,
                  fontWeight: FontWeight.w900,
                  color: checkerDark,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Kelola pencatatan stok bawaan dan retur harian',
                style: TextStyle(
                  fontSize: 9,
                  color: checkerMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: checkerOrange,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Checker',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.arrow_drop_down,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =====================================================
  // KARTU STOK BAWAAN DAN STOK RETUR
  // =====================================================

  Widget _stockCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 230,
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE8EDF3),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL

          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 5),

          // DESKRIPSI

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: checkerMuted,
              fontWeight: FontWeight.w500,
            ),
          ),

          // RUANG KOSONG

          const Spacer(),

          // TOMBOL INPUT

          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: checkerOrange,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // KARTU RIWAYAT INPUT
  // =====================================================

  Widget _buildHistoryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        15,
        16,
        17,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFF0F1F4),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // BARIS PERTAMA

          Row(
            children: [
              Expanded(
                child: _historyItem(
                  title: 'Input Stok Bawaan',
                  outlet: 'Outlet Rungkut',
                  time: '07:15',
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: _historyItem(
                  title: 'Input Stok Retur',
                  outlet: 'Outlet Sukolilo',
                  time: '16:30',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // BARIS KEDUA

          Row(
            children: [
              Expanded(
                child: _historyItem(
                  title: 'Input Stok Bawaan',
                  outlet: 'Outlet Wonokromo',
                  time: '07:30',
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: _historyItem(
                  title: 'Input Stok Retur',
                  outlet: 'Outlet Rungkut',
                  time: '17:30',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // ITEM RIWAYAT INPUT
  // =====================================================

  Widget _historyItem({
    required String title,
    required String outlet,
    required String time,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // INFORMASI AKTIVITAS

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• $title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5276A6),
                  ),
                ),

                const SizedBox(height: 4),

                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    outlet,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.1,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF16A34A),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          // WAKTU

          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFF16A34A),
            ),
          ),
        ],
      ),
    );
  }
}