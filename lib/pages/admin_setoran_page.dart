import 'package:flutter/material.dart';
import 'login_page.dart';
import 'admin_dashboard_page.dart';
import 'admin_bagihasil_page.dart';
import 'admin_struk_page.dart';
import 'admin_laporan_page.dart';

class AdminSetoranPage extends StatefulWidget {
  const AdminSetoranPage({super.key});

  @override
  State<AdminSetoranPage> createState() => _AdminSetoranPageState();
}

class _AdminSetoranPageState extends State<AdminSetoranPage> {
  final TextEditingController nominalController =
    TextEditingController();

  final TextEditingController catatanController =
      TextEditingController();

  String tanggal = '20 September 2026';
  String outlet = '';
  String produk = '';
  String _namaBulan(int bulan) {
    const namaBulan = [
      '',
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

    return namaBulan[bulan];
  }

  void _pilihOutlet() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pilih Outlet'),
          children: [
            'Rungkut',
            'Sukolilo',
            'Wonokromo',
          ].map(
            (item) {
              return SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    outlet = item;
                  });
                  Navigator.pop(context);
                },
                child: Text(item),
              );
            },
          ).toList(),
        );
      },
    );
  }

  void _pilihProduk() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pilih Produk'),
          children: [
            'Produk A',
            'Produk B',
            'Produk C',
          ].map(
            (item) {
              return SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    produk = item;
                  });
                  Navigator.pop(context);
                },
                child: Text(item),
              );
            },
          ).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FB),
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 150,
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

                _sideBox(
                  context: context,
                  title: 'MAIN MENU',
                  items: const ['Dashboard'],
                  activeIndex: -1,
                ),

                const SizedBox(height: 12),

                _sideBox(
                  context: context,
                  title: 'KEUANGAN',
                  items: const [
                    'Setoran',
                    'Bagi Hasil',
                    'Struk Transparansi',
                  ],
                  activeIndex: 0,
                ),

                const SizedBox(height: 12),

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
                // ================= HEADER =================
                Container(
                  height: 105,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 50,
                  ),
                  child: Row(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INPUT SETORAN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2D42),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Masukkan data uang setoran dari outlet',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF60738F),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ADMIN
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
                  child: Center(
                    child: Container(
                      width: 520,
                      height: 465,
                      padding: const EdgeInsets.fromLTRB(
                        90,
                        15,
                        90,
                        20,
                      ),
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
                          _label('Tanggal'),

                          InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2026, 9, 20),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2035),
                              );

                              if (picked != null) {
                                setState(() {
                                  tanggal =
                                      '${picked.day} ${_namaBulan(picked.month)} ${picked.year}';
                                });
                              }
                            },
                            child: _field(tanggal),
                          ),

                          const SizedBox(height: 10),

                          _label('Outlet'),

                          InkWell(
                            onTap: () {
                              _pilihOutlet();
                            },
                            child: _field(
                              outlet.isEmpty ? 'Pilih Outlet ▼' : outlet,
                            ),
                          ),

                          const SizedBox(height: 10),

                          _label('Produk'),

                          InkWell(
                            onTap: () {
                              _pilihProduk();
                            },
                            child: _field(
                              produk.isEmpty ? 'Pilih Produk ▼' : produk,
                            ),
                          ),

                          const SizedBox(height: 10),

                          _label('Nominal Setoran'),

                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFD0D5DB),
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              controller: nominalController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan nominal uang...',
                                hintStyle: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFFB0BAC8),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 17,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          _label('Catatan Tambahan'),

                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFD0D5DB),
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              controller: catatanController,
                              decoration: const InputDecoration(
                                hintText: 'Catatan tambahan (opsional)...',
                                hintStyle: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFFB0BAC8),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 17,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // ================= TOMBOL BATAL =================
                              SizedBox(
                                width: 105,
                                height: 38,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD9DCE0),
                                    foregroundColor: const Color(0xFF60738F),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'Batal',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // ================= TOMBOL SIMPAN =================
                              SizedBox(
                                width: 105,
                                height: 38,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (outlet.isEmpty || produk.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Silakan pilih outlet dan produk terlebih dahulu.',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Data setoran berhasil disimpan.',
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF6B00),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: const Text(
                                    'Simpan',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

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

        const SizedBox(height: 5),

        ...List.generate(
          items.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SizedBox(
                width: double.infinity,
                height: 24,
                child: TextButton(
                  onPressed: () {
                    _navigate(
                      context,
                      items[index],
                    );
                  },
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      24,
                    ),
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
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
            );
          },
        ),
      ],
    ),
  );
}

// ================= NAVIGASI ADMIN =================

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
  // ================= LABEL =================

  static Widget _label(String text) {
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

  static Widget _field(String text) {
    return Container(
      width: double.infinity,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        border: Border.all(
          color: const Color(0xFFD0D5DA),
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          color: Color(0xFFB0B8C4),
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