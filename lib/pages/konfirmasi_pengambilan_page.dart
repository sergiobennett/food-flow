import 'package:flutter/material.dart';
import 'struk_transparansi_page.dart';

const Color orange = Color(0xFFFF7518);
const Color peach = Color(0xFFFFF0E5);
const Color background = Color(0xFFF1F6FA);
const Color darkText = Color(0xFF26354A);
const Color greyText = Color(0xFF65758B);

class KonfirmasiPengambilanPage extends StatefulWidget {
  final List<Map<String, dynamic>> menu;
  final DateTime tanggal;

  const KonfirmasiPengambilanPage({
    super.key,
    required this.menu,
    required this.tanggal,
  });

  @override
  State<KonfirmasiPengambilanPage> createState() =>
      _KonfirmasiPengambilanPageState();
}

class _KonfirmasiPengambilanPageState
    extends State<KonfirmasiPengambilanPage> {
  bool setuju = false;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'KONFIRMASI PENGAMBILAN',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Tanggal: ${formatTanggal(widget.tanggal)}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: greyText,
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildGreeting(),

                        const SizedBox(height: 22),

                        _buildTable(),

                        const SizedBox(height: 18),

                        _buildCheckbox(),

                        const SizedBox(height: 20),

                        _buildButtons(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          // HEADER
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
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
              ],
            ),
          ),

          // DATA MENU
          ...List.generate(
            widget.menu.length,
            (index) {
              final item = widget.menu[index];

              return _buildTableRow(
                item['nama'].toString(),
                item['jumlah'].toString(),
              );
            },
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TABLE ROW
  // =========================================================

  Widget _buildTableRow(
    String nama,
    String jumlah,
  ) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
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
              nama,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),

          Expanded(
            child: Text(
              jumlah,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CHECKBOX
  // =========================================================

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: setuju,
          activeColor: orange,
          onChanged: (value) {
            setState(() {
              setuju = value ?? false;
            });
          },
        ),

        const Expanded(
          child: Text(
            'Saya mengonfirmasi bahwa stok telah diterima.',
            style: TextStyle(
              fontSize: 10,
              color: darkText,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BUTTONS
  // =========================================================

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 110,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(width: 15),

        SizedBox(
          width: 125,
          height: 40,
          child: ElevatedButton(
            onPressed: setuju ? _konfirmasi : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
                  const Color(0xFFBDBDBD),
              disabledForegroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Konfirmasi',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // KONFIRMASI
  // =========================================================

  void _konfirmasi() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Konfirmasi Berhasil',
          ),

          content: const Text(
            'Pengambilan stok berhasil dikonfirmasi.',
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pop(
                  context,
                  true,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(6),
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
  // SIDEBAR
  // =========================================================

  Widget _buildSidebar() {
    return Container(
      width: 193,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              onTap: () {
                Navigator.pop(context);
              },
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
                      menu: widget.menu,
                      tanggal: widget.tanggal,
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
                _showInfo('Profil');
              },
            ),

            _sidebarItem(
              'Logout',
              logout: true,
              onTap: _showLogoutDialog,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SIDEBAR SECTION
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

  // =========================================================
  // SIDEBAR ITEM
  // =========================================================

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
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
          ),
          decoration: BoxDecoration(
            color: selected
                ? peach
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
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

  // =========================================================
  // INFO
  // =========================================================

  void _showInfo(String menu) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$menu akan dibuka pada halaman berikutnya.',
        ),
      ),
    );
  }

  // =========================================================
  // LOGOUT
  // =========================================================

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
              child: const Text(
                'Batal',
              ),
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
              child: const Text(
                'Ya',
              ),
            ),
          ],
        );
      },
    );
  }
}