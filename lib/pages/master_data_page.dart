import 'package:flutter/material.dart';

import 'produk_page.dart';
import 'outlet_page.dart';
import 'penjual_page.dart' as penjual;
import 'dashboard_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'login_page.dart';
import 'owner_sidebar.dart';

// =========================================================
// MASTER DATA OWNER
// =========================================================

class MasterDataPage extends StatelessWidget {
  const MasterDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =================================================
          // SIDEBAR OWNER
          // Menggunakan komponen yang sama dengan Dashboard.
          // =================================================

          OwnerSidebar(
            activeItem: '',
            onSelected: (item) {
              _handleSidebarTap(context, item);
            },
          ),

          // =================================================
          // KONTEN UTAMA
          // =================================================

          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(30),
              child: Stack(
                children: [
                  // KONTEN MASTER DATA

                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // HEADER

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MASTER DATA',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          Color(0xFF17243A),
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  Text(
                                    'Kelola data utama yang digunakan dalam proses distribusi.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color(0xFF718096),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            // BADGE OWNER

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFFF7100,
                                ),
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  Text(
                                    'Owner',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.black,
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

                        const SizedBox(height: 40),

                        // =====================================
                        // KARTU MASTER DATA
                        // =====================================

                        LayoutBuilder(
                          builder: (
                            context,
                            constraints,
                          ) {
                            final bool layarSempit =
                                constraints.maxWidth < 850;

                            // TAMPILAN LAYAR SEMPIT

                            if (layarSempit) {
                              return Column(
                                children: [
                                  _masterCard(
                                    icon:
                                        Icons.inventory_2,
                                    title: 'Master Produk',
                                    description:
                                        'Kelola data produk yang didistribusikan.',
                                    total: '15',
                                    label: 'Data Produk',
                                    color: const Color(
                                      0xFFFF7100,
                                    ),
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

                                  const SizedBox(height: 20),

                                  _masterCard(
                                    icon:
                                        Icons.storefront,
                                    title: 'Master Outlet',
                                    description:
                                        'Kelola data outlet tempat produk didistribusikan.',
                                    total: '8',
                                    label: 'Data Outlet',
                                    color: const Color(
                                      0xFF3B82F6,
                                    ),
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

                                  const SizedBox(height: 20),

                                  _masterCard(
                                    icon:
                                        Icons.person_outline,
                                    title: 'Master Penjual',
                                    description:
                                        'Kelola data penjual yang terhubung dengan outlet.',
                                    total: '10',
                                    label: 'Data Penjual',
                                    color: const Color(
                                      0xFF10B981,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              penjual.PenjualPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }

                            // TAMPILAN LAYAR LEBAR

                            return Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _masterCard(
                                    icon:
                                        Icons.inventory_2,
                                    title: 'Master Produk',
                                    description:
                                        'Kelola data produk yang didistribusikan.',
                                    total: '15',
                                    label: 'Data Produk',
                                    color: const Color(
                                      0xFFFF7100,
                                    ),
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
                                ),

                                const SizedBox(width: 20),

                                Expanded(
                                  child: _masterCard(
                                    icon:
                                        Icons.storefront,
                                    title: 'Master Outlet',
                                    description:
                                        'Kelola data outlet tempat produk didistribusikan.',
                                    total: '8',
                                    label: 'Data Outlet',
                                    color: const Color(
                                      0xFF3B82F6,
                                    ),
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
                                ),

                                const SizedBox(width: 20),

                                Expanded(
                                  child: _masterCard(
                                    icon:
                                        Icons.person_outline,
                                    title: 'Master Penjual',
                                    description:
                                        'Kelola data penjual yang terhubung dengan outlet.',
                                    total: '10',
                                    label: 'Data Penjual',
                                    color: const Color(
                                      0xFF10B981,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              penjual.PenjualPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        // JARAK BAGIAN BAWAH

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),

                  // =========================================
                  // TOMBOL KEMBALI
                  // =========================================

                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const DashboardPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFFF7100),
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'KEMBALI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
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

  // =====================================================
  // NAVIGASI SIDEBAR OWNER
  // =====================================================

  void _handleSidebarTap(
    BuildContext context,
    String item,
  ) {
    switch (item) {
      // DASHBOARD

      case 'Dashboard':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const DashboardPage(),
          ),
        );
        break;

      // MASTER DATA: PRODUK

      case 'Produk':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ProdukPage(),
          ),
        );
        break;

      // MASTER DATA: OUTLET

      case 'Outlet':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const OutletPage(),
          ),
        );
        break;

      // MASTER DATA: PENJUAL

      case 'Penjual':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                penjual.PenjualPage(),
          ),
        );
        break;

      // TRANSAKSI: DISTRIBUSI

      case 'Distribusi':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const DistribusiPage(),
          ),
        );
        break;

      // TRANSAKSI: RETUR

      case 'Retur':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ReturPage(),
          ),
        );
        break;

      // TRANSAKSI: SETORAN

      case 'Setoran':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const SetoranPage(),
          ),
        );
        break;

      // TRANSAKSI: BAGI HASIL

      case 'Bagi Hasil':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const BagiHasilPage(),
          ),
        );
        break;

      // LAPORAN

      case 'Laporan':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const LaporanPage(),
          ),
        );
        break;

      // LOGOUT

      case 'Logout':
        _showLogoutDialog(context);
        break;
    }
  }

  // =====================================================
  // KARTU MASTER DATA
  // =====================================================

  static Widget _masterCard({
    required IconData icon,
    required String title,
    required String description,
    required String total,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // ICON KARTU

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 35,
              color: color,
            ),
          ),

          const SizedBox(height: 25),

          // JUDUL

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17243A),
            ),
          ),

          const SizedBox(height: 8),

          // DESKRIPSI

          SizedBox(
            height: 40,
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // TOTAL DATA

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FB),
              borderRadius:
                  BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),

                const SizedBox(width: 12),

                Text(
                  total,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17243A),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF718096),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // TOMBOL KELOLA DATA

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    'Kelola Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(width: 8),

                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // DIALOG LOGOUT
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
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