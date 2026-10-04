import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'produk_page.dart';
import 'outlet_page.dart';
import 'penjual_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';
import 'login_page.dart';

class DistribusiPage extends StatefulWidget {
  const DistribusiPage({super.key});

  @override
  State<DistribusiPage> createState() => _DistribusiPageState();
}

class _DistribusiPageState extends State<DistribusiPage> {
  final List<Map<String, dynamic>> distribusi = [
    {
      "kode": "D001",
      "tanggal": "21 Sep",
      "outlet": "Outlet A",
      "penjual": "Andi",
      "total": "50",
      "status": "Diproses",
    },
    {
      "kode": "D002",
      "tanggal": "21 Sep",
      "outlet": "Outlet B",
      "penjual": "Budi",
      "total": "45",
      "status": "Diterima",
    },
    {
      "kode": "D003",
      "tanggal": "20 Sep",
      "outlet": "Outlet C",
      "penjual": "Citra",
      "total": "60",
      "status": "Diterima",
    },
    {
      "kode": "D004",
      "tanggal": "20 Sep",
      "outlet": "Outlet A",
      "penjual": "Andi",
      "total": "40",
      "status": "Diproses",
    },
  ];

// ================= SIDEBAR =================
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
          InkWell(
            onTap: () {
              if (title == "MASTER DATA") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MasterDataPage(),
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Padding(
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
          ),

          ...items.map(
            (item) => InkWell(
              onTap: () {
                if (item == "Distribusi") {
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
                padding: const EdgeInsets.symmetric(vertical: 3),
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

  Widget menuItem(
  String text, {
  bool active = false,
  VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFFFF1E8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const Text(
              "• ",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFFFF6B00),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                color: const Color(0xFFFF6B00),
                fontWeight:
                    active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuBox(
    String title,
    List<Widget> children,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 14,
      ),
      padding: const EdgeInsets.fromLTRB(
        10,
        7,
        10,
        7,
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
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 2),
          ...children,
        ],
      ),
    );
  }

  Widget statusWidget(String status) {
    final bool diterima = status == "Diterima";

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: diterima
            ? const Color(0xFFE3F7EF)
            : const Color(0xFFFFECE3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            diterima
                ? Icons.check_circle
                : Icons.access_time,
            size: 13,
            color: diterima
                ? const Color(0xFF009B68)
                : const Color(0xFFFF5A1F),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: diterima
                  ? const Color(0xFF009B68)
                  : const Color(0xFFFF5A1F),
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

  void bukaBuatDistribusi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BuatDistribusiPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          // ================= SIDEBAR =================
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
                  ["Distribusi", "Retur", "Setoran", "Bagi Hasil"],
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
          // ================= CONTENT =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DISTRIBUSI",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Kelola distribusi produk ke outlet dan penjual.",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
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
                              "Owner",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 7),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // SEARCH + BUAT DISTRIBUSI
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 255,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Cari distribusi...",
                            hintStyle: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF94A3B8),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 14,
                              color: Color(0xFF64748B),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(
                              vertical: 6,
                            ),
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: bukaBuatDistribusi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFF6B00),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Buat Distribusi",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 42),

                  // ================= TABEL =================
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.12),
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // HEADER TABEL
                        Container(
                          height: 31,
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFF7142),
                            borderRadius:
                                BorderRadius.circular(7),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "KODE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "TANGGAL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "OUTLET",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "PENJUAL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "TOTAL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "STATUS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "AKSI",
                                    style: TextStyle(
                                      color: Colors.white,
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

                        // DATA
                        ...List.generate(
                          distribusi.length,
                          (index) {
                            final item =
                                distribusi[index];

                            return Container(
                              height: 39,
                              decoration:
                                  const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        Color(0xFFF1F5F9),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                          horizontal: 9,
                                          vertical: 4,
                                        ),
                                        decoration:
                                            BoxDecoration(
                                          color:
                                              const Color(
                                            0xFFE8EDF3,
                                          ),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            15,
                                          ),
                                        ),
                                        child: Text(
                                          item["kode"],
                                          style:
                                              const TextStyle(
                                            fontSize: 9,
                                            fontWeight:
                                                FontWeight.bold,
                                            color: Color(
                                              0xFF334155,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        item["tanggal"],
                                        style:
                                            const TextStyle(
                                          fontSize: 9,
                                          color:
                                              Color(0xFF334155),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        item["outlet"],
                                        style:
                                            const TextStyle(
                                          fontSize: 9,
                                          color:
                                              Color(0xFF334155),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        item["penjual"],
                                        style:
                                            const TextStyle(
                                          fontSize: 9,
                                          color:
                                              Color(0xFF334155),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        item["total"],
                                        style:
                                            const TextStyle(
                                          fontSize: 9,
                                          fontWeight:
                                              FontWeight.bold,
                                          color:
                                              Color(0xFF334155),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: statusWidget(
                                        item["status"],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Center(
                                      child:
                                          ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      BuatDistribusiPage(
                                                kode:
                                                    item["kode"],
                                                tanggal:
                                                    item["tanggal"],
                                                outlet:
                                                    item["outlet"],
                                                penjual:
                                                    item["penjual"],
                                                status:
                                                    item["status"],
                                              ),
                                            ),
                                          );
                                        },
                                        icon:
                                            const Icon(
                                          Icons
                                              .description_outlined,
                                          size: 12,
                                        ),
                                        label:
                                            const Text(
                                          "Detail",
                                          style:
                                              TextStyle(
                                            fontSize: 8,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                        style:
                                            ElevatedButton
                                                .styleFrom(
                                          backgroundColor:
                                              const Color(
                                            0xFFE9EEF4,
                                          ),
                                          foregroundColor:
                                              const Color(
                                            0xFF334155,
                                          ),
                                          elevation: 0,
                                          padding:
                                              const EdgeInsets
                                                  .symmetric(
                                            horizontal: 9,
                                            vertical: 6,
                                          ),
                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                              7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // =================================================
                  // KEMBALI HALAMAN DISTRIBUSI
                  // =================================================
                  const SizedBox(height: 20),

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
                        elevation: 0,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 9,
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
                          fontWeight: FontWeight.bold,
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
}

// =============================================================
// BUAT DISTRIBUSI
// =============================================================

class BuatDistribusiPage extends StatefulWidget {
  final String? kode;
  final String? tanggal;
  final String? outlet;
  final String? penjual;
  final String? status;

  const BuatDistribusiPage({
    super.key,
    this.kode,
    this.tanggal,
    this.outlet,
    this.penjual,
    this.status,
  });

  @override
  State<BuatDistribusiPage> createState() =>
      _BuatDistribusiPageState();
}

class _BuatDistribusiPageState
    extends State<BuatDistribusiPage> {
  late TextEditingController kodeController;
  late TextEditingController tanggalController;

  String outlet = "Outlet A";
  String penjual = "Andi";
  String status = "Diterima";

  @override
  void initState() {
    super.initState();

    kodeController = TextEditingController(
      text: widget.kode ?? "D001",
    );

    tanggalController = TextEditingController(
      text: widget.tanggal != null
          ? "${widget.tanggal} 2026"
          : "21 Sep 2026",
    );

    outlet = widget.outlet ?? "Outlet A";
    penjual = widget.penjual ?? "Andi";
    status = widget.status ?? "Diterima";
  }

  @override
  void dispose() {
    kodeController.dispose();
    tanggalController.dispose();
    super.dispose();
  }

  Widget menuItem(
    String title, {
    bool active = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFFFF3E8)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Text(
            "•",
            style: TextStyle(
              color: Color(0xFFFF6B00),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFFFF6B00),
              fontSize: 11,
              fontWeight:
                  active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
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
          InkWell(
            onTap: () {
              if (title == "MASTER DATA") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MasterDataPage(),
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Padding(
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
          ),

          ...items.map(
            (item) => InkWell(
              onTap: () {
                if (item == "Distribusi") {
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
                padding: const EdgeInsets.symmetric(vertical: 3),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
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
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          // ================= SIDEBAR =================
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
                  ["Distribusi", "Retur", "Setoran", "Bagi Hasil"],
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

          // ================= CONTENT =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 28,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BUAT DISTRIBUSI",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Kelola distribusi produk ke outlet dan penjual.",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFFF6B00),
                          borderRadius:
                              BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 7),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // ================= KARTU DETAIL =================
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF031C2B),
                      borderRadius:
                          BorderRadius.circular(13),
                      border: Border.all(
                        color: const Color(0xFF009DFF),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.20),
                          blurRadius: 7,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF0A2D40),
                            borderRadius:
                                BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.inventory_2_outlined,
                                color: Colors.white,
                                size: 17,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Detail Distribusi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // INFORMASI
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  const Color(0xFF103A4D),
                            ),
                            borderRadius:
                                BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "INFORMASI DISTRIBUSI",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Expanded(
                                    child: _field(
                                      "KODE",
                                      kodeController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: _field(
                                      "TANGGAL",
                                      tanggalController,
                                      icon:
                                          Icons.calendar_month,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child:
                                        _dropdownField(
                                      "OUTLET",
                                      outlet,
                                      [
                                        "Outlet A",
                                        "Outlet B",
                                        "Outlet C",
                                      ],
                                      (value) {
                                        setState(() {
                                          outlet =
                                              value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child:
                                        _dropdownField(
                                      "PENJUAL",
                                      penjual,
                                      [
                                        "Andi",
                                        "Budi",
                                        "Citra",
                                      ],
                                      (value) {
                                        setState(() {
                                          penjual =
                                              value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child:
                                        _dropdownField(
                                      "STATUS",
                                      status,
                                      [
                                        "Diterima",
                                        "Diproses",
                                      ],
                                      (value) {
                                        setState(() {
                                          status =
                                              value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        // PRODUK
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  const Color(0xFF103A4D),
                            ),
                            borderRadius:
                                BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "PRODUK YANG DIDISTRIBUSIKAN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF12384A),
                                  borderRadius:
                                      BorderRadius.circular(
                                    3,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Text(
                                          "KODE",
                                          style:
                                              TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: 7,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "PRODUK",
                                        style: TextStyle(
                                          color:
                                              Colors.white,
                                          fontSize: 7,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "JUMLAH",
                                        style: TextStyle(
                                          color:
                                              Colors.white,
                                          fontSize: 7,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "HARGA",
                                        style: TextStyle(
                                          color:
                                              Colors.white,
                                          fontSize: 7,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "SUBTOTAL",
                                        style: TextStyle(
                                          color:
                                              Colors.white,
                                          fontSize: 7,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              _productRow(
                                "P001",
                                "Produk A",
                                "20",
                                "10.000",
                                "200.000",
                              ),

                              _productRow(
                                "P002",
                                "Produk B",
                                "15",
                                "12.000",
                                "180.000",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // =================================================
                  // KEMBALI BUAT DISTRIBUSI
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
                        elevation: 0,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 8,
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
                          fontWeight: FontWeight.bold,
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

  Widget _field(
    String label,
    TextEditingController controller, {
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 21,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF28566B),
            ),
            borderRadius:
                BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                    ),
                    decoration:
                        const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              if (icon != null)
                Padding(
                  padding:
                      const EdgeInsets.only(right: 5),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dropdownField(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 21,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF28566B),
            ),
            borderRadius:
                BorderRadius.circular(4),
          ),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor:
                  const Color(0xFF0A2D40),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 13,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _productRow(
    String kode,
    String produk,
    String jumlah,
    String harga,
    String subtotal,
  ) {
    return Container(
      height: 25,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF103A4D),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8),
              child: Text(
                kode,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              produk,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
          ),
          Expanded(
            child: Text(
              jumlah,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
          ),
          Expanded(
            child: Text(
              harga,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
          ),
          Expanded(
            child: Text(
              subtotal,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}