import 'package:flutter/material.dart';
import 'konfirmasi_pengambilan_page.dart';
import 'struk_transparansi_page.dart';
import 'profil_penjual_page.dart';
import 'penjual_dashboard_page.dart';

const Color orange = Color(0xFFFF7518);
const Color peach = Color(0xFFFFF0E5);
const Color background = Color(0xFFF1F6FA);
const Color darkText = Color(0xFF26354A);
const Color greyText = Color(0xFF65758B);

class PengambilanStokPage extends StatefulWidget {
  const PengambilanStokPage({super.key});

  @override
  State<PengambilanStokPage> createState() =>
      _PengambilanStokPageState();
}

class _PengambilanStokPageState
    extends State<PengambilanStokPage> {

  DateTime tanggal = DateTime.now();

  final List<Map<String, dynamic>> menu = [
    {
      'nama': 'Udang Keju',
      'jumlah': '10',
    },
    {
      'nama': 'Tahu Crispy',
      'jumlah': '15',
    },
    {
      'nama': 'Es Teh',
      'jumlah': '20',
    },
  ];

  // =========================================================
  // FORMAT TANGGAL
  // =========================================================

  String formatTanggal(DateTime date) {
    const bulan = [
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

    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
  }

  // =========================================================
  // PILIH TANGGAL
  // =========================================================

  Future<void> pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (hasil != null) {
      setState(() {
        tanggal = hasil;
      });
    }
  }

  // =========================================================
  // TAMBAH MENU
  // =========================================================

  void tambahMenu() {
    final namaController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tambah Menu'),

          content: TextField(
            controller: namaController,
            decoration: const InputDecoration(
              labelText: 'Nama Menu',
              hintText: 'Contoh: Cireng',
              border: OutlineInputBorder(),
            ),
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
                final nama = namaController.text.trim();

                if (nama.isEmpty) return;

                setState(() {
                  menu.add({
                    'nama': nama,
                    'jumlah': '0',
                  });
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // HAPUS MENU
  // =========================================================

  void hapusMenu(int index) {
    setState(() {
      menu.removeAt(index);
    });
  }

  // =========================================================
  // KONFIRMASI
  // =========================================================

  Future<void> bukaKonfirmasi() async {
    if (menu.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Minimal harus ada satu menu.'),
        ),
      );
      return;
    }

    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return KonfirmasiPengambilanPage(
            menu: menu,
            tanggal: tanggal,
          );
        },
      ),
    );

    if (hasil == true && mounted) {
      Navigator.pop(
        context,
        {
          'menu': menu,
          'tanggal': tanggal,
        },
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: Row(
        children: [
          _buildSidebar(),

          Expanded(
            child: Column(
              children: [
                _buildTopBar(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      28,
                      18,
                      28,
                      28,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PENGAMBILAN STOK',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          'Kelola menu, jumlah stok, dan tanggal pengambilan.',
                          style: TextStyle(
                            fontSize: 10,
                            color: greyText,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildGreeting(),

                        const SizedBox(height: 20),

                        _buildDateCard(),

                        const SizedBox(height: 15),

                        _buildTable(),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton.icon(
                              onPressed: tambahMenu,
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                              ),
                              label: const Text(
                                'Tambah Menu',
                              ),
                              style:
                                  OutlinedButton.styleFrom(
                                foregroundColor: orange,
                                side: const BorderSide(
                                  color: orange,
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 110,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.grey,
                                      foregroundColor:
                                          Colors.white,
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                          6,
                                        ),
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

                                const SizedBox(width: 15),

                                SizedBox(
                                  width: 190,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed:
                                        bukaKonfirmasi,
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          orange,
                                      foregroundColor:
                                          Colors.white,
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Konfirmasi Pengambilan',
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

  // =========================================================
  // DATE CARD
  // =========================================================

  Widget _buildDateCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today,
            size: 18,
            color: orange,
          ),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Tanggal Pengambilan',
                style: TextStyle(
                  fontSize: 9,
                  color: greyText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                formatTanggal(tanggal),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ],
          ),

          const Spacer(),

          TextButton(
            onPressed: pilihTanggal,
            child: const Text(
              'Ubah Tanggal',
              style: TextStyle(
                fontSize: 10,
                color: orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TABLE
  // =========================================================

  Widget _buildTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 43,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Produk',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    'Jumlah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(
                  width: 40,
                  child: Text(''),
                ),
              ],
            ),
          ),

          ...List.generate(
            menu.length,
            (index) {
              return _menuRow(index);
            },
          ),
        ],
      ),
    );
  }

  // =========================================================
  // MENU ROW
  // =========================================================

  Widget _menuRow(int index) {
    final item = menu[index];

    final controller = TextEditingController(
      text: item['jumlah'].toString(),
    );

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 0.8,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              item['nama'].toString(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),

          Expanded(
            child: SizedBox(
              height: 38,
              child: TextField(
                controller: controller,
                keyboardType:
                    TextInputType.number,
                onChanged: (value) {
                  item['jumlah'] = value;
                },
                decoration:
                    const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              hapusMenu(index);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SIDEBAR
  // =========================================================

  Widget _buildSidebar() {
    return Container(
      width: 193,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                28,
                30,
                20,
                25,
              ),
              child: Text(
                'FOOD FLOW',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: orange,
                ),
              ),
            ),

            _sectionTitle('MAIN MENU'),
            _sidebarItem(
              'Dashboard',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('STOK'),

            _sidebarItem(
              'Pengambilan Stok',
              selected: true,
              onTap: () {},
            ),

            _sidebarItem(
              'Stok',
              onTap: () {
                _showInfo('Stok');
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('TRANSAKSI'),

            _sidebarItem(
              'Struk Transparansi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StrukTransparansiPage(
                      menu: menu,
                      tanggal: tanggal,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('AKUN'),

            _sidebarItem(
              'Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfilPenjualPage(),
                  ),
                );
              },
            ),

            _sidebarItem(
              'Logout',
              logout: true,
              onTap: () {
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // TOP BAR
  // =========================================================

  Widget _buildTopBar() {
    return Container(
      height: 65,
      color: background,
      padding: const EdgeInsets.only(
        left: 28,
        right: 28,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius:
                  BorderRadius.circular(6),
            ),
            child: const Text(
              'Penjual ▼',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // GREETING
  // =========================================================

  Widget _buildGreeting() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: peach,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, Bimuy 👋',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'OUTLET RUNGKUT',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HELPER
  // =========================================================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 2,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 6,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _sidebarItem(
    String title, {
    bool selected = false,
    bool logout = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 27,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 9,
          ),
          decoration: BoxDecoration(
            color: selected
                ? peach
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(5),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                '•',
                style: TextStyle(
                  fontSize: 10,
                  color: logout
                      ? Colors.red
                      : selected
                          ? orange
                          : greyText,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 8,
                    color: logout
                        ? Colors.red
                        : selected
                            ? orange
                            : greyText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfo(String menu) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$menu akan dibuka pada halaman berikutnya.',
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Yakin ingin keluar?',
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
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
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