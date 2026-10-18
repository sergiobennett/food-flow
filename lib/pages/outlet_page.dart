import 'package:flutter/material.dart';
import 'owner_sidebar.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'produk_page.dart';
import 'penjual_page.dart' as penjual;
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';

// =========================================================
// HALAMAN MASTER OUTLET
// =========================================================

class OutletPage extends StatefulWidget {
  const OutletPage({super.key});

  @override
  State<OutletPage> createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  static const Color orange = Color(0xFFFF7100);

  final List<Map<String, dynamic>> outlet = [
    {
      'kode': '001',
      'nama': 'Outlet A',
      'alamat': 'Rungkut',
      'penjual': 'Andi',
      'status': 'Aktif',
    },
    {
      'kode': '002',
      'nama': 'Outlet B',
      'alamat': 'Sukolilo',
      'penjual': 'Budi',
      'status': 'Aktif',
    },
    {
      'kode': '003',
      'nama': 'Outlet C',
      'alamat': 'Wonokromo',
      'penjual': 'Citra',
      'status': 'Aktif',
    },
  ];

  final List<String> daftarPenjual = [
    'Andi',
    'Budi',
    'Citra',
  ];

  String search = '';

  List<Map<String, dynamic>> get outletFilter {
    if (search.isEmpty) return outlet;

    return outlet.where((item) {
      final nama = item['nama'].toString().toLowerCase();
      final alamat = item['alamat'].toString().toLowerCase();

      return nama.contains(search.toLowerCase()) ||
          alamat.contains(search.toLowerCase());
    }).toList();
  }

  // =====================================================
  // NAVIGASI KE HALAMAN TAMBAH OUTLET
  // =====================================================

  Future<void> bukaHalamanTambahOutlet() async {
    int nomorTerbesar = 0;

    for (final item in outlet) {
      final String kode = item['kode'].toString();
      final int? nomor = int.tryParse(kode);

      if (nomor != null && nomor > nomorTerbesar) {
        nomorTerbesar = nomor;
      }
    }

    final String kodeBaru =
        (nomorTerbesar + 1).toString().padLeft(3, '0');

    final List<String> penjualTersedia = {
      ...daftarPenjual,
      ...outlet.map((item) => item['penjual'].toString()),
    }.toList();

    final hasil = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => TambahOutletPage(
          kodeOutlet: kodeBaru,
          daftarPenjual: penjualTersedia,
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    setState(() {
      outlet.add(hasil);

      final namaPenjual = hasil['penjual'].toString();

      if (!daftarPenjual.contains(namaPenjual)) {
        daftarPenjual.add(namaPenjual);
      }
    });
  }

  // =====================================================
  // EDIT OUTLET
  // =====================================================

  void editOutlet(int filteredIndex) {
    final item = outletFilter[filteredIndex];
    final indexAsli = outlet.indexOf(item);

    final kodeController = TextEditingController(
      text: item['kode'].toString(),
    );

    final namaController = TextEditingController(
      text: item['nama'].toString(),
    );

    final alamatController = TextEditingController(
      text: item['alamat'].toString(),
    );

    final penjualController = TextEditingController(
      text: item['penjual'].toString(),
    );

    String statusEdit = item['status'] ?? 'Aktif';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: Container(
                width: 700,
                decoration: _dialogDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _dialogHeader(
                      'Edit Outlet',
                      Icons.edit_note,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDarkInput(
                            'KODE OUTLET',
                            child: _darkTextField(
                              kodeController,
                              '',
                              readOnly: true,
                            ),
                          ),

                          const SizedBox(height: 20),

                          _buildDarkInput(
                            'NAMA OUTLET',
                            child: _darkTextField(
                              namaController,
                              'Masukkan nama outlet',
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              _buildDarkInput(
                                'ALAMAT',
                                flex: 1,
                                child: _darkTextField(
                                  alamatController,
                                  'Masukkan alamat outlet',
                                ),
                              ),

                              const SizedBox(width: 15),

                              _buildDarkInput(
                                'PENJUAL',
                                flex: 1,
                                child: _darkTextField(
                                  penjualController,
                                  'Masukkan nama penjual',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          _buildDarkInput(
                            'STATUS',
                            child: _darkDropdownStatus(
                              statusEdit,
                              ['Aktif', 'Nonaktif'],
                              (value) {
                                if (value != null) {
                                  setDialogState(() {
                                    statusEdit = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white54,
                              size: 16,
                            ),
                            label: const Text(
                              'Batal',
                              style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          ElevatedButton.icon(
                            onPressed: () {
                              if (namaController.text.trim().isEmpty) {
                                _pesan('Nama outlet wajib diisi.');
                                return;
                              }

                              if (alamatController.text.trim().isEmpty) {
                                _pesan('Alamat outlet wajib diisi.');
                                return;
                              }

                              setState(() {
                                outlet[indexAsli] = {
                                  'kode': kodeController.text,
                                  'nama': namaController.text.trim(),
                                  'alamat': alamatController.text.trim(),
                                  'penjual':
                                      penjualController.text.trim(),
                                  'status': statusEdit,
                                };
                              });

                              Navigator.pop(dialogContext);
                            },
                            icon: const Icon(
                              Icons.save,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Simpan Outlet',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orange,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // =====================================================
  // HAPUS OUTLET
  // =====================================================

  void hapusOutlet(int filteredIndex) {
    final item = outletFilter[filteredIndex];
    final indexAsli = outlet.indexOf(item);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Hapus Outlet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus outlet ${item['nama']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  outlet.removeAt(indexAsli);
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ),
    );
  }

  // =====================================================
  // BUILD MASTER OUTLET
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          OwnerSidebar(
            activeItem: 'Outlet',
            onSelected: _handleSidebarTap,
          ),

          // KONTEN UTAMA

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MASTER OUTLET',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17243A),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Kelola data outlet tempat produk didistribusikan.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      const _OutletOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // SEARCH DAN TAMBAH OUTLET

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari outlet...',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 20,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 35,
                            ),
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: bukaHalamanTambahOutlet,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Tambah Outlet',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // TABEL OUTLET

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 45,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                _headerCell('KODE', flex: 2),
                                _verticalDivider(),
                                _headerCell('NAMA OUTLET', flex: 3),
                                _verticalDivider(),
                                _headerCell('ALAMAT', flex: 3),
                                _verticalDivider(),
                                _headerCell('PENJUAL', flex: 3),
                                _verticalDivider(),
                                _headerCell('STATUS', flex: 2),
                                _verticalDivider(),
                                _headerCell('AKSI', flex: 2),
                              ],
                            ),
                          ),

                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              itemCount: outletFilter.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 1,
                                  color: Colors.grey.shade200,
                                );
                              },
                              itemBuilder: (context, index) {
                                final item = outletFilter[index];
                                final bool isAktif =
                                    item['status'] == 'Aktif';

                                return SizedBox(
                                  height: 60,
                                  child: Row(
                                    children: [
                                      // KODE

                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8EDF3),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              item['kode'].toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // NAMA OUTLET

                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Text(
                                            item['nama'].toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // ALAMAT

                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFE5D1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.location_on,
                                                  size: 14,
                                                  color: Color(0xFFF97316),
                                                ),
                                              ),

                                              const SizedBox(width: 8),

                                              Flexible(
                                                child: Text(
                                                  item['alamat'].toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF1E293B),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // PENJUAL

                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE2E8F0),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  size: 14,
                                                  color: Color(0xFF1E293B),
                                                ),

                                                const SizedBox(width: 6),

                                                Flexible(
                                                  child: Text(
                                                    item['penjual'].toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF1E293B),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // STATUS

                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: _statusBadge(isAktif),
                                        ),
                                      ),

                                      // AKSI

                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _actionButton(
                                              icon: Icons.edit,
                                              color: const Color(0xFFE2E8F0),
                                              iconColor: const Color(
                                                0xFF334155,
                                              ),
                                              onTap: () => editOutlet(index),
                                            ),

                                            const SizedBox(width: 8),

                                            _actionButton(
                                              icon: Icons.delete,
                                              color: const Color(0xFFEF4444),
                                              iconColor: Colors.white,
                                              onTap: () => hapusOutlet(index),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // KEMBALI

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'KEMBALI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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
  // WIDGET TABEL
  // =====================================================

  Widget _headerCell(
    String text, {
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 20,
      color: Colors.white.withOpacity(0.4),
    );
  }

  Widget _statusBadge(bool isAktif) {
    final Color color = isAktif
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isAktif
            ? const Color(0xFFDCFCE7)
            : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 6, color: color),
          const SizedBox(width: 6),
          Text(
            isAktif ? 'Aktif' : 'Nonaktif',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
    );
  }

  // =====================================================
  // WIDGET DIALOG EDIT
  // =====================================================

  Widget _buildDarkInput(
    String label, {
    required Widget child,
    int flex = 0,
  }) {
    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );

    return flex > 0
        ? Expanded(flex: flex, child: content)
        : content;
  }

  Widget _darkTextField(
    TextEditingController controller,
    String hint, {
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 13,
        ),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _darkDropdownStatus(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E293B),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF94A3B8),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
          items: items.map((item) {
            final Color color =
                item == 'Aktif' ? Colors.green : Colors.red;

            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: color),
                  const SizedBox(width: 8),
                  Text(item),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  BoxDecoration _dialogDecoration() {
    return BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xFF1E293B),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _dialogHeader(
    String title,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF162032),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR OWNER
  // =====================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        _goTo(const DashboardPage());
        break;
      case 'Produk':
        _goTo(const ProdukPage());
        break;
      case 'Outlet':
        // Sudah berada di halaman Master Outlet.
        break;
      case 'Penjual':
        _goTo(penjual.PenjualPage());
        break;
      case 'Distribusi':
        _goTo(const DistribusiPage());
        break;
      case 'Retur':
        _goTo(const ReturPage());
        break;
      case 'Setoran':
        _goTo(const SetoranPage());
        break;
      case 'Bagi Hasil':
        _goTo(const BagiHasilPage());
        break;
      case 'Laporan':
        _goTo(const LaporanPage());
        break;
      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7100),
              foregroundColor: Colors.white,
            ),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  void _goTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}

// =========================================================
// HALAMAN TAMBAH OUTLET
// =========================================================

class TambahOutletPage extends StatefulWidget {
  final String kodeOutlet;
  final List<String> daftarPenjual;

  const TambahOutletPage({
    super.key,
    required this.kodeOutlet,
    required this.daftarPenjual,
  });

  @override
  State<TambahOutletPage> createState() => _TambahOutletPageState();
}

class _TambahOutletPageState extends State<TambahOutletPage> {
  static const Color orange = Color(0xFFFF7100);

  final TextEditingController kodeController =
      TextEditingController();

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController alamatController =
      TextEditingController();

  String? penjualPilihan;

  @override
  void initState() {
    super.initState();
    kodeController.text = widget.kodeOutlet;
  }

  @override
  void dispose() {
    kodeController.dispose();
    namaController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  // =====================================================
  // SIMPAN OUTLET
  // =====================================================

  void _simpanOutlet() {
    if (namaController.text.trim().isEmpty) {
      _pesan('Nama outlet wajib diisi.');
      return;
    }

    if (alamatController.text.trim().isEmpty) {
      _pesan('Alamat outlet wajib diisi.');
      return;
    }

    if (penjualPilihan == null) {
      _pesan('Silakan pilih penjual.');
      return;
    }

    Navigator.pop<Map<String, dynamic>>(
      context,
      {
        'kode': kodeController.text,
        'nama': namaController.text.trim(),
        'alamat': alamatController.text.trim(),
        'penjual': penjualPilihan,
        'status': 'Aktif',
      },
    );
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ),
    );
  }

  // =====================================================
  // BUILD HALAMAN TAMBAH OUTLET
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          OwnerSidebar(
            activeItem: 'Outlet',
            onSelected: _handleSidebarTap,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                30,
                35,
                35,
                25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TAMBAH OUTLET',
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF263238),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tambahkan outlet baru ke dalam master data.',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const _OutletOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // PENCARIAN DAN TOMBOL TAMBAH

                  Row(
                    children: [
                      Container(
                        width: 265,
                        height: 32,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 14,
                              color: Color(0xFF94A3B8),
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Cari outlet...',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 19,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Tambah Outlet',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // FORM DI SEBELAH KIRI

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double formWidth =
                            constraints.maxWidth >= 808
                                ? 760.0
                                : (constraints.maxWidth - 48)
                                    .clamp(320.0, 760.0)
                                    .toDouble();

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 25,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: _buildForm(formWidth),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // TOMBOL KEMBALI

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'KEMBALI',
                        style: TextStyle(
                          fontSize: 10,
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

  // =====================================================
  // FORM TAMBAH OUTLET
  // =====================================================

  Widget _buildForm(double width) {
    final double longFieldWidth = width * 0.73;
    final double smallFieldWidth = width * 0.305;

    return Container(
      width: width,
      height: 334,
      decoration: BoxDecoration(
        color: const Color(0xFF080D13),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: const Color(0xFF263445),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER FORM

          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              13,
              12,
              0,
            ),
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF111F2B),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: const Color(0xFF263445),
                  width: 0.7,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.widgets_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(width: 12),

                  VerticalDivider(
                    width: 12,
                    indent: 7,
                    endIndent: 7,
                    color: Color(0xFF263445),
                  ),

                  SizedBox(width: 8),

                  Text(
                    'Tambah Outlet',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // PANEL INPUT

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                0,
                10,
                12,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF080D13),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: const Color(0xFF1C2A37),
                    width: 0.8,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    14,
                    0,
                    14,
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // KODE OUTLET

                      SizedBox(
                        width: longFieldWidth,
                        child: _field(
                          'KODE OUTLET',
                          _textField(
                            kodeController,
                            '',
                            readOnly: true,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // NAMA OUTLET

                      SizedBox(
                        width: longFieldWidth,
                        child: _field(
                          'NAMA OUTLET',
                          _textField(
                            namaController,
                            'Masukkan nama outlet',
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ALAMAT DAN PENJUAL

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: smallFieldWidth,
                            child: _field(
                              'ALAMAT',
                              _textField(
                                alamatController,
                                'Masukkan alamat outlet',
                              ),
                            ),
                          ),

                          const SizedBox(width: 22),

                          SizedBox(
                            width: smallFieldWidth,
                            child: _field(
                              'PENJUAL',
                              _dropdownPenjual(),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // TOMBOL BATAL DAN SIMPAN

                      SizedBox(
                        width: longFieldWidth + 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 12,
                                color: Color(0xFF94A3B8),
                              ),
                              label: const Text(
                                'Batal',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF94A3B8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 7,
                                ),
                              ),
                            ),

                            const SizedBox(width: 7),

                            ElevatedButton.icon(
                              onPressed: _simpanOutlet,
                              icon: const Icon(
                                Icons.save,
                                size: 13,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Simpan Outlet',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF97316),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // LABEL FORM
  // =====================================================

  Widget _field(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 11,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              height: 1,
              fontWeight: FontWeight.bold,
              color: Color(0xFFCBD5E1),
            ),
          ),
        ),

        const SizedBox(height: 4),

        child,
      ],
    );
  }

  // =====================================================
  // TEXT FIELD
  // =====================================================

  Widget _textField(
    TextEditingController controller,
    String hint, {
    bool readOnly = false,
  }) {
    return SizedBox(
      height: 26,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 8,
            color: Color(0xFF64748B),
          ),
          filled: true,
          fillColor: const Color(0xFF111B26),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFF263445),
              width: 0.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFF263445),
              width: 0.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFFFF7100),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // DROPDOWN PENJUAL
  // =====================================================

  Widget _dropdownPenjual() {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF111B26),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF263445),
          width: 0.8,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: penjualPilihan,
          isExpanded: true,
          isDense: true,
          menuMaxHeight: 180,
          dropdownColor: const Color(0xFF182435),
          hint: const Text(
            'Pilih penjual',
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF64748B),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 12,
            color: Color(0xFF64748B),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
          items: widget.daftarPenjual.map((penjual) {
            return DropdownMenuItem<String>(
              value: penjual,
              child: Text(
                penjual,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              penjualPilihan = value;
            });
          },
        ),
      ),
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR OWNER - HALAMAN TAMBAH OUTLET
  // =====================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        _goTo(const DashboardPage());
        break;
      case 'Produk':
        _goTo(const ProdukPage());
        break;
      case 'Outlet':
        Navigator.pop(context);
        break;
      case 'Penjual':
        _goTo(penjual.PenjualPage());
        break;
      case 'Distribusi':
        _goTo(const DistribusiPage());
        break;
      case 'Retur':
        _goTo(const ReturPage());
        break;
      case 'Setoran':
        _goTo(const SetoranPage());
        break;
      case 'Bagi Hasil':
        _goTo(const BagiHasilPage());
        break;
      case 'Laporan':
        _goTo(const LaporanPage());
        break;
      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  void _goTo(Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7100),
              foregroundColor: Colors.white,
            ),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// OWNER BADGE OUTLET
// =========================================================

class _OutletOwnerBadge extends StatelessWidget {
  const _OutletOwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF7100),
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Owner',
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
    );
  }
}