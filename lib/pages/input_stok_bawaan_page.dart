import 'package:flutter/material.dart';
import 'login_page.dart';

class InputStokBawaanPage extends StatefulWidget {
  const InputStokBawaanPage({super.key});

  @override
  State<InputStokBawaanPage> createState() => _InputStokBawaanPageState();
}

class _InputStokBawaanPageState extends State<InputStokBawaanPage> {
  DateTime selectedDate = DateTime(2026, 9, 20);
  String? selectedOutlet;
  String? selectedProduk;
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  @override
  void dispose() {
    jumlahController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FC),
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
                  padding: EdgeInsets.only(left: 12),
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
                  "MAIN MENU",
                  ["Dashboard"],
                ),

                _sideBox(
                  "STOK GUDANG",
                  ["Stok Bawaan", "Stok Retur"],
                ),

                _sideBox(
                  "DISTRIBUSI",
                  ["Distribusi Produk"],
                ),

                _sideBox(
                  "LAPORAN",
                  ["Riwayat Stok"],
                ),

                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, top: 2),
                    child: Text(
                      '• Logout',
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================= CONTENT =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 45, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "INPUT STOK BAWAAN",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26354D),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Masukkan data stok awal sebelum distribusi",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      // ROLE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B00),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Checker",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
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

                  const SizedBox(height: 25),

                  // ================= FORM =================
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 530,
                        padding: const EdgeInsets.fromLTRB(
                          92,
                          18,
                          92,
                          18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label("Tanggal"),
                            _field(
                              child: InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime(2025),
                                    lastDate: DateTime(2030),
                                  );

                                  if (picked != null) {
                                    setState(() {
                                      selectedDate = picked;
                                    });
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "${selectedDate.day} ${_monthName(selectedDate.month)} ${selectedDate.year}",
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFFB0B8C4),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 9),

                            _label('Outlet'),
                            _field(
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 9),
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan nama outlet...',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 9),

                            _label('Produk'),
                            _field(
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 9),
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan nama produk...',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 9),

                            _label("Jumlah Stok"),
                            _field(
                              child: TextField(
                                controller: jumlahController,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 9),
                                decoration: const InputDecoration(
                                  hintText: "Masukkan jumlah stok...",
                                  hintStyle: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFB0B8C4),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),

                            const SizedBox(height: 9),

                            _label("Keterangan"),
                            _field(
                              height: 44,
                              child: TextField(
                                controller: keteranganController,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 9),
                                decoration: const InputDecoration(
                                  hintText:
                                      "Catatan tambahan (opsional)...",
                                  hintStyle: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFFB0B8C4),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),

                            const Spacer(),

                            // BUTTON
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 110,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD5D8DD),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Batal",
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 9),

                                Container(
                                  width: 110,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF6B00),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Data stok bawaan berhasil disimpan",
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Simpan",
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  String _monthName(int month) {
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  return months[month - 1];
  } 

  // ================= SIDEBAR BOX =================


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

  Widget _sideBox(String title, List<String> items) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(10, 6, 5, 7),
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
          const SizedBox(height: 3),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                "• $item",
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= LABEL =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // ================= FIELD =================

  Widget _field({
    required Widget child,
    double height = 44,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFD8DDE4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}