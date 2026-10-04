import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';

class ReturPage extends StatefulWidget {
  const ReturPage({super.key});

  @override
  State<ReturPage> createState() => _ReturPageState();
}

class _ReturPageState extends State<ReturPage> {
  final List<Map<String, String>> data = [
    {
      "kode": "R001",
      "tanggal": "21 Sep 2026",
      "outlet": "A",
      "penjual": "Andi",
      "total": "5",
      "status": "Diterima",
    },
    {
      "kode": "R002",
      "tanggal": "21 Sep 2026",
      "outlet": "B",
      "penjual": "Budi",
      "total": "3",
      "status": "Diterima",
    },
    {
      "kode": "R003",
      "tanggal": "20 Sep 2026",
      "outlet": "C",
      "penjual": "Citra",
      "total": "7",
      "status": "Diproses",
    },
    {
      "kode": "R004",
      "tanggal": "22 Sep 2026",
      "outlet": "B",
      "penjual": "Budi",
      "total": "3",
      "status": "Diterima",
    },
    {
      "kode": "R005",
      "tanggal": "23 Sep 2026",
      "outlet": "C",
      "penjual": "Citra",
      "total": "5",
      "status": "Diterima",
    },
    {
      "kode": "R006",
      "tanggal": "24 Sep 2026",
      "outlet": "B",
      "penjual": "Budi",
      "total": "7",
      "status": "Diterima",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          _sidebar(context),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "RETUR",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Kelola pencatatan stok retur dari outlet dan penjual.",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7100),
                          borderRadius:
                              BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 7),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 255,
                        height: 28,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 13,
                              color: Color(0xFF64748B),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Cari retur...",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const InputReturPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFF7100),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Input Retur",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _table(context),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFF7100),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _table(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _header(),

          ...data.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final e = entry.value;

              return Container(
                height: 42,
                color: index.isEven
                    ? Colors.white
                    : const Color(0xFFF7F9FC),
                child: Row(
                  children: [
                    _cell(
                      e["kode"]!,
                      1,
                      pill: true,
                    ),
                    _cell(
                      e["tanggal"]!,
                      2,
                    ),
                    _cell(
                      e["outlet"]!,
                      1,
                    ),
                    _cell(
                      e["penjual"]!,
                      1,
                    ),
                    _cell(
                      e["total"]!,
                      1,
                    ),
                    _status(
                      e["status"]!,
                      2,
                    ),

                    Expanded(
                      flex: 1,
                      child: Center(
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const InputReturPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.description_outlined,
                            size: 14,
                          ),
                          label: const Text(
                            "Detail",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color(0xFF24364B),
                            backgroundColor:
                                const Color(0xFFEAF0F6),
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
    );
  }

  Widget _header() {
    final labels = [
      "KODE",
      "TANGGAL",
      "OUTLET",
      "PENJUAL",
      "TOTAL RETUR",
      "STATUS",
      "AKSI",
    ];

    final flexes = [
      1,
      2,
      1,
      1,
      1,
      2,
      1,
    ];

    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(
          labels.length,
          (index) => Expanded(
            flex: flexes[index],
            child: Center(
              child: Text(
                labels[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cell(
    String text,
    int flex, {
    bool pill = false,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: pill
            ? Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEF5),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 9,
                ),
              ),
      ),
    );
  }

  Widget _status(
    String text,
    int flex,
  ) {
    final bool diterima = text == "Diterima";

    return Expanded(
      flex: flex,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: diterima
                ? const Color(0xFFDDF6EC)
                : const Color(0xFFFFEAD8),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                diterima
                    ? Icons.check_circle
                    : Icons.access_time,
                size: 12,
                color: diterima
                    ? Colors.green
                    : Colors.orange,
              ),
              const SizedBox(width: 4),
              Text(
                text,
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: diterima
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sidebar(BuildContext context) {
  return Container(
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

        _sideBox(context, "MAIN MENU", ["Dashboard"]),
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
        _sideBox(context, "LAPORAN", ["Laporan"]),
        _sideBox(context, "AKUN", ["Profil", "LogOut"]),
      ],
    ),
  );
}

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
}

// =====================================================
// INPUT RETUR
// =====================================================

class InputReturPage extends StatefulWidget {
  const InputReturPage({super.key});

  @override
  State<InputReturPage> createState() =>
      _InputReturPageState();
}

class _InputReturPageState
    extends State<InputReturPage> {
  String? outlet;
  String? penjual;
  String? produk;

  final TextEditingController jumlahController =
      TextEditingController();

  final TextEditingController catatanController =
      TextEditingController();

  @override
  void dispose() {
    jumlahController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          _sidebarInput(context),

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
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "INPUT RETUR",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Catat stok retur dari outlet pada akhir hari.",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      _ownerButton(),
                    ],
                  ),

                  const SizedBox(height: 35),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 255,
                        height: 28,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 13,
                              color: Color(0xFF64748B),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Cari retur...",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFF7100),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Input Retur",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001B29),
                      borderRadius:
                          BorderRadius.circular(9),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 7,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 25,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF09283A),
                            borderRadius:
                                BorderRadius.circular(5),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Input Retur",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        _darkLabel("TANGGAL"),
                        _darkField("21 Sep 2026"),

                        _darkLabel("OUTLET"),
                        _dropdown(
                          outlet,
                          "Pilih Outlet",
                          [
                            "Outlet A",
                            "Outlet B",
                            "Outlet C",
                          ],
                          (value) {
                            setState(() {
                              outlet = value;
                            });
                          },
                        ),

                        _darkLabel("PENJUAL"),
                        _dropdown(
                          penjual,
                          "Pilih Penjual",
                          [
                            "Andi",
                            "Budi",
                            "Citra",
                          ],
                          (value) {
                            setState(() {
                              penjual = value;
                            });
                          },
                        ),

                        _darkLabel("PRODUK"),
                        _dropdown(
                          produk,
                          "Pilih Produk",
                          [
                            "Produk A",
                            "Produk B",
                            "Produk C",
                          ],
                          (value) {
                            setState(() {
                              produk = value;
                            });
                          },
                        ),

                        _darkLabel("JUMLAH RETUR"),
                        _darkInput(
                          jumlahController,
                          "Masukkan jumlah",
                        ),

                        _darkLabel("CATATAN"),
                        _darkInput(
                          catatanController,
                          "Opsional",
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style:
                                  OutlinedButton.styleFrom(
                                foregroundColor:
                                    Colors.white,
                                side: const BorderSide(
                                  color: Color(
                                    0xFF355467,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Batal",
                                style: TextStyle(
                                  fontSize: 9,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Retur berhasil disimpan",
                                    ),
                                  ),
                                );
                              },
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFFFF6B00),
                                foregroundColor:
                                    Colors.white,
                              ),
                              child: const Text(
                                "Simpan Retur",
                                style: TextStyle(
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFF7100),
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: const Text(
                          "KEMBALI",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFF7100),
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: const Text(
                          "SELANJUTNYA",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ownerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF7100),
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Row(
        children: [
          Text(
            "Owner",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 7),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _darkLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _darkField(String text) {
    return Container(
      width: double.infinity,
      height: 21,
      padding:
          const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFF08283A),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF1B4053),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFA8B9C5),
          fontSize: 8,
        ),
      ),
    );
  }

  Widget _darkInput(
    TextEditingController controller,
    String hint,
  ) {
    return SizedBox(
      height: 21,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFA8B9C5),
            fontSize: 8,
          ),
          filled: true,
          fillColor: const Color(0xFF08283A),
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Color(0xFF1B4053),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdown(
    String? value,
    String hint,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      height: 21,
      decoration: BoxDecoration(
        color: const Color(0xFF08283A),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFF1B4053),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Text(
              hint,
              style: const TextStyle(
                color: Color(0xFFA8B9C5),
                fontSize: 8,
              ),
            ),
          ),
          isExpanded: true,
          dropdownColor:
              const Color(0xFF08283A),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 14,
          ),
          items: items.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(item),
                ),
              );
            },
          ).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _sidebarInput(BuildContext context) {
    return Container(
      width: 155,
      color: Colors.white,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),

          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Text(
              "FOOD FLOW",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF7100),
              ),
            ),
          ),

          const SizedBox(height: 25),

          _inputMenu(
            "MAIN MENU",
            ["Dashboard"],
          ),

          _inputMenu(
            "MASTER DATA",
            ["Produk", "Outlet", "Penjual"],
          ),

          _inputMenu(
            "TRANSAKSI",
            [
              "Distribusi",
              "Retur",
              "Setoran",
              "Bagi Hasil",
            ],
          ),

          _inputMenu(
            "LAPORAN",
            ["Laporan"],
          ),

          _inputMenu(
            "AKUN",
            ["Profil", "LogOut"],
          ),
        ],
      ),
    );
  }

  Widget _inputMenu(
    String title,
    List<String> items,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          ...items.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              child: Text(
                "• $item",
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFFF7100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}