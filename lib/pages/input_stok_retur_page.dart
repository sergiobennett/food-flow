import 'package:flutter/material.dart';
import 'login_page.dart';

class InputStokReturPage extends StatefulWidget {
  const InputStokReturPage({super.key});

  @override
  State<InputStokReturPage> createState() => _InputStokReturPageState();
}

class _InputStokReturPageState extends State<InputStokReturPage> {
  DateTime selectedDate = DateTime(2026, 9, 20);

  final TextEditingController outletController =
      TextEditingController();

  final TextEditingController produkController =
      TextEditingController();

  final TextEditingController jumlahReturController =
      TextEditingController();

  final TextEditingController alasanController =
      TextEditingController();

  @override
  void dispose() {
    outletController.dispose();
    produkController.dispose();
    jumlahReturController.dispose();
    alasanController.dispose();
    super.dispose();
  }

  String monthName(int month) {
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
              padding: const EdgeInsets.fromLTRB(
                28,
                28,
                45,
                25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= HEADER =================
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'INPUT STOK RETUR',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26354D),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Masukkan data stok retur',
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
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Checker',
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

                  const SizedBox(height: 18),

                  // ================= FORM CARD =================
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 570,
                        padding: const EdgeInsets.fromLTRB(
                          35,
                          25,
                          35,
                          20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            // TANGGAL
                            _label('Tanggal'),
                            _field(
                              '${selectedDate.day} '
                              '${monthName(selectedDate.month)} '
                              '${selectedDate.year}',
                              readOnly: true,
                              onTap: () async {
                                final picked =
                                    await showDatePicker(
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
                            ),

                            const SizedBox(height: 18),

                            // OUTLET
                            _label('Outlet'),
                            _field(
                              'Masukkan nama outlet...',
                              controller:
                                  outletController,
                            ),

                            const SizedBox(height: 18),

                            // PRODUK
                            _label('Produk'),
                            _field(
                              'Masukkan nama produk...',
                              controller:
                                  produkController,
                            ),

                            const SizedBox(height: 18),

                            // JUMLAH RETUR
                            _label('Jumlah Retur'),
                            _field(
                              'Masukkan jumlah retur...',
                              controller:
                                  jumlahReturController,
                              keyboardType:
                                  TextInputType.number,
                            ),

                            const SizedBox(height: 18),

                            // ALASAN RETUR
                            _label('Alasan Retur'),
                            _field(
                              'Masukkan alasan retur...',
                              controller:
                                  alasanController,
                              maxLines: 2,
                            ),

                            const Spacer(),

                            // BUTTON
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(
                                              0xFFD1D5DB),
                                      foregroundColor:
                                          const Color(
                                              0xFF64748B),
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                7),
                                      ),
                                    ),
                                    child: const Text(
                                      'Batal',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                              context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Stok retur berhasil disimpan',
                                          ),
                                        ),
                                      );
                                    },
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(
                                              0xFFFF6B00),
                                      foregroundColor:
                                          Colors.white,
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                7),
                                      ),
                                    ),
                                    child: const Text(
                                      'Simpan',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight.bold,
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

  Widget _sideBox(
    String title,
    List<String> items,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(
        10,
        5,
        5,
        6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7EF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
              padding:
                  const EdgeInsets.symmetric(
                vertical: 3,
              ),
              child: Text(
                '• $item',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                  height: 1.5,
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
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // ================= FIELD =================

  Widget _field(
    String hint, {
    TextEditingController? controller,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 9,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 9,
            color: Color(0xFFB0B8C4),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFFD1D5DB),
            ),
          ),
          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFFD1D5DB),
            ),
          ),
          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFFFF6B00),
            ),
          ),
        ),
      ),
    );
  }
}