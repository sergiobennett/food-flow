import 'package:flutter/material.dart';
import 'owner_sidebar.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'produk_page.dart';
import 'outlet_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';

// =========================================================
// HALAMAN MASTER PENJUAL
// =========================================================

class PenjualPage extends StatefulWidget {
  const PenjualPage({super.key});

  @override
  State<PenjualPage> createState() => _PenjualPageState();
}

class _PenjualPageState extends State<PenjualPage> {
  static const Color orange = Color(0xFFFF7100);

  final List<Map<String, dynamic>> penjual = [
    {
      'kode': 'P001',
      'nama': 'Andi',
      'outlet': 'Outlet A',
      'kontak': '0812xxxx',
      'status': 'Aktif',
    },
    {
      'kode': 'P002',
      'nama': 'Budi',
      'outlet': 'Outlet B',
      'kontak': '0813xxxx',
      'status': 'Aktif',
    },
    {
      'kode': 'P003',
      'nama': 'Citra',
      'outlet': 'Outlet C',
      'kontak': '0815xxxx',
      'status': 'Aktif',
    },
  ];

  final List<String> daftarOutlet = [
    'Outlet A',
    'Outlet B',
    'Outlet C',
  ];

  String search = '';

  List<Map<String, dynamic>> get penjualFilter {
    if (search.isEmpty) return penjual;

    return penjual.where((item) {
      final nama = item['nama'].toString().toLowerCase();
      final outlet = item['outlet'].toString().toLowerCase();
      final kontak = item['kontak'].toString().toLowerCase();
      final query = search.toLowerCase();

      return nama.contains(query) ||
          outlet.contains(query) ||
          kontak.contains(query);
    }).toList();
  }

  // =====================================================
  // BUKA HALAMAN TAMBAH PENJUAL
  // =====================================================

  Future<void> bukaHalamanTambahPenjual() async {
    int nomorTerbesar = 0;

    for (final item in penjual) {
      final String kode = item['kode'].toString();
      final match = RegExp(r'^P(\d+)$').firstMatch(kode);

      if (match != null) {
        final int nomor = int.parse(match.group(1)!);

        if (nomor > nomorTerbesar) {
          nomorTerbesar = nomor;
        }
      }
    }

    final String kodeBaru =
        'P${(nomorTerbesar + 1).toString().padLeft(3, '0')}';

    final hasil = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => TambahPenjualPage(
          kodePenjual: kodeBaru,
          daftarOutlet: daftarOutlet,
        ),
      ),
    );

    if (!mounted || hasil == null) return;

    setState(() {
      penjual.add(hasil);
    });
  }

  // =====================================================
  // EDIT PENJUAL
  // =====================================================

  void editPenjual(int filteredIndex) {
    final item = penjualFilter[filteredIndex];
    final indexAsli = penjual.indexOf(item);

    final kodeController = TextEditingController(
      text: item['kode'].toString(),
    );

    final namaController = TextEditingController(
      text: item['nama'].toString(),
    );

    final kontakController = TextEditingController(
      text: item['kontak'].toString(),
    );

    String outletEdit = item['outlet'].toString();
    String statusEdit = item['status'] ?? 'Aktif';

    final List<String> outletOptions = [
      ...daftarOutlet,
    ];

    if (!outletOptions.contains(outletEdit)) {
      outletOptions.add(outletEdit);
    }

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
                      'Edit Penjual',
                      Icons.edit_note,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDarkInput(
                            'KODE PENJUAL',
                            child: _darkTextField(
                              kodeController,
                              '',
                              readOnly: true,
                            ),
                          ),

                          const SizedBox(height: 20),

                          _buildDarkInput(
                            'NAMA PENJUAL',
                            child: _darkTextField(
                              namaController,
                              'Masukkan nama penjual',
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [
                              _buildDarkInput(
                                'OUTLET',
                                flex: 1,
                                child: _darkDropdown(
                                  outletEdit,
                                  outletOptions,
                                  'Pilih Outlet',
                                  (value) {
                                    if (value != null) {
                                      setDialogState(() {
                                        outletEdit = value;
                                      });
                                    }
                                  },
                                ),
                              ),

                              const SizedBox(width: 15),

                              _buildDarkInput(
                                'NO. TELEPON',
                                flex: 1,
                                child: _darkTextField(
                                  kontakController,
                                  'Masukkan nomor telepon',
                                  isNumber: true,
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
                                _pesan('Nama penjual wajib diisi.');
                                return;
                              }

                              setState(() {
                                penjual[indexAsli] = {
                                  'kode': kodeController.text,
                                  'nama': namaController.text.trim(),
                                  'outlet': outletEdit,
                                  'kontak': kontakController.text.trim(),
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
                              'Simpan',
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
  // HAPUS PENJUAL
  // =====================================================

  void hapusPenjual(int filteredIndex) {
    final item = penjualFilter[filteredIndex];
    final indexAsli = penjual.indexOf(item);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Hapus Penjual',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus penjual ${item['nama']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  penjual.removeAt(indexAsli);
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

  // =====================================================
  // BUILD MASTER PENJUAL
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          _PenjualSidebar(
            onPenjualTap: () {},
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
                            'MASTER PENJUAL',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17243A),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Kelola data penjual yang terhubung dengan outlet.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      const _PenjualOwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // PENCARIAN DAN TAMBAH PENJUAL

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
                            hintText: 'Cari penjual...',
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
                        onPressed: bukaHalamanTambahPenjual,
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
                          'Tambah Penjual',
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

                  // TABEL PENJUAL

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
                                _headerCell('NAMA PENJUAL', flex: 3),
                                _verticalDivider(),
                                _headerCell('OUTLET', flex: 3),
                                _verticalDivider(),
                                _headerCell('KONTAK', flex: 3),
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
                              itemCount: penjualFilter.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 1,
                                  color: Colors.grey.shade200,
                                );
                              },
                              itemBuilder: (context, index) {
                                final item = penjualFilter[index];
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

                                      // NAMA PENJUAL

                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Text(
                                            item['nama'].toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // OUTLET

                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Text(
                                            item['outlet'].toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // KONTAK

                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Text(
                                            item['kontak'].toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1E293B),
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
                                              onTap: () => editPenjual(index),
                                            ),

                                            const SizedBox(width: 8),

                                            _actionButton(
                                              icon: Icons.delete,
                                              color: const Color(0xFFFEE2E2),
                                              iconColor: const Color(
                                                0xFFEF4444,
                                              ),
                                              onTap: () => hapusPenjual(index),
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
  // KOMPONEN TABEL
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
          Icon(
            Icons.circle,
            size: 6,
            color: color,
          ),
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
  // INPUT DIALOG EDIT
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
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: isNumber
          ? TextInputType.phone
          : TextInputType.text,
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

  Widget _darkDropdown(
    String? value,
    List<String> items,
    String hint,
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
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
            ),
          ),
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
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
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
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: color,
                  ),
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
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
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

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
      ),
    );
  }
}

// =========================================================
// HALAMAN TAMBAH PENJUAL
// =========================================================

class TambahPenjualPage extends StatefulWidget {
  final String kodePenjual;
  final List<String> daftarOutlet;

  const TambahPenjualPage({
    super.key,
    required this.kodePenjual,
    required this.daftarOutlet,
  });

  @override
  State<TambahPenjualPage> createState() => _TambahPenjualPageState();
}

class _TambahPenjualPageState extends State<TambahPenjualPage> {
  static const Color orange = Color(0xFFFF7100);

  final TextEditingController kodeController =
      TextEditingController();

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController kontakController =
      TextEditingController();

  String? outletPilihan;
  String statusTambah = 'Aktif';

  @override
  void initState() {
    super.initState();
    kodeController.text = widget.kodePenjual;
  }

  @override
  void dispose() {
    kodeController.dispose();
    namaController.dispose();
    kontakController.dispose();
    super.dispose();
  }

  // =====================================================
  // SIMPAN PENJUAL
  // =====================================================

  void _simpanPenjual() {
    if (namaController.text.trim().isEmpty) {
      _pesan('Nama penjual wajib diisi.');
      return;
    }

    if (outletPilihan == null) {
      _pesan('Silakan pilih outlet.');
      return;
    }

    if (kontakController.text.trim().isEmpty) {
      _pesan('Nomor telepon wajib diisi.');
      return;
    }

    Navigator.pop<Map<String, dynamic>>(
      context,
      {
        'kode': kodeController.text,
        'nama': namaController.text.trim(),
        'outlet': outletPilihan,
        'kontak': kontakController.text.trim(),
        'status': statusTambah,
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
  // BUILD HALAMAN TAMBAH PENJUAL
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          _PenjualSidebar(
            onPenjualTap: () {
              Navigator.pop(context);
            },
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
                  // HEADER HALAMAN

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TAMBAH PENJUAL',
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF263238),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tambahkan penjual baru ke dalam master data.',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const _PenjualOwnerBadge(
                        blackText: true,
                      ),
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
                              'Cari penjual...',
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
                          'Tambah Penjual',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // FORM TAMBAH PENJUAL

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double formWidth =
                            (constraints.maxWidth - 24)
                                .clamp(280.0, 760.0)
                                .toDouble();

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
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
  // KARTU FORM TAMBAH PENJUAL
  // =====================================================

  Widget _buildForm(double width) {
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
              10,
              10,
              10,
              0,
            ),
            child: Container(
              height: 29,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF111F2B),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFF263445),
                  width: 0.7,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  VerticalDivider(
                    width: 8,
                    indent: 6,
                    endIndent: 6,
                    color: Color(0xFF263445),
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Tambah Penjual',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // PANEL INPUT

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                8,
                0,
                8,
                10,
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
                    10,
                    2,
                    10,
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // KODE PENJUAL

                      _field(
                        'KODE PENJUAL',
                        _textField(
                          kodeController,
                          '',
                          readOnly: true,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // NAMA PENJUAL

                      _field(
                        'NAMA PENJUAL',
                        _textField(
                          namaController,
                          'Masukkan nama penjual',
                        ),
                      ),

                      const SizedBox(height: 5),

                      // OUTLET DAN NOMOR TELEPON

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _field(
                              'OUTLET',
                              _dropdown(
                                value: outletPilihan,
                                hint: 'Pilih Outlet',
                                items: widget.daftarOutlet,
                                onChanged: (value) {
                                  setState(() {
                                    outletPilihan = value;
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: _field(
                              'NO. TELEPON',
                              _textField(
                                kontakController,
                                'Masukkan nomor telepon',
                                isNumber: true,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      // STATUS

                      SizedBox(
                        width: width * 0.47,
                        child: _field(
                          'STATUS',
                          _dropdown(
                            value: statusTambah,
                            hint: 'Pilih status',
                            items: const [
                              'Aktif',
                              'Nonaktif',
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  statusTambah = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 7),

                      // BATAL DAN SIMPAN

                      Row(
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
                                vertical: 6,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),

                          const SizedBox(width: 6),

                          ElevatedButton.icon(
                            onPressed: _simpanPenjual,
                            icon: const Icon(
                              Icons.save,
                              size: 12,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Simpan',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF97316),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 10,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
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
          height: 10,
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
        const SizedBox(height: 3),
        child,
      ],
    );
  }

  // =====================================================
  // TEXT FIELD RINGKAS
  // =====================================================

  Widget _textField(
    TextEditingController controller,
    String hint, {
    bool readOnly = false,
    bool isNumber = false,
  }) {
    return SizedBox(
      height: 21,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: isNumber
            ? TextInputType.phone
            : TextInputType.text,
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
            horizontal: 9,
            vertical: 5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0xFF263445),
              width: 0.7,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Color(0xFF263445),
              width: 0.7,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
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
  // DROPDOWN OUTLET DAN STATUS
  // =====================================================

  Widget _dropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 21,
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF111B26),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFF263445),
          width: 0.7,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          isDense: true,
          menuMaxHeight: 180,
          hint: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF64748B),
            ),
          ),
          dropdownColor: const Color(0xFF182435),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 12,
            color: Color(0xFF64748B),
          ),
          style: const TextStyle(
            fontSize: 8,
            color: Colors.white,
          ),
          items: items.map((item) {
            final bool isStatus =
                item == 'Aktif' || item == 'Nonaktif';

            final Color dotColor = item == 'Aktif'
                ? const Color(0xFF22C55E)
                : item == 'Nonaktif'
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFFF7100);

            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  if (isStatus) ...[
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: dotColor,
                    ),
                    const SizedBox(width: 5),
                  ],
                  Flexible(
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// =========================================================
// SIDEBAR PENJUAL
// MENGGUNAKAN KOMPONEN OWNER SIDEBAR BERSAMA
// =========================================================

class _PenjualSidebar extends StatelessWidget {
  final VoidCallback onPenjualTap;

  const _PenjualSidebar({
    required this.onPenjualTap,
  });

  @override
  Widget build(BuildContext context) {
    return OwnerSidebar(
      activeItem: 'Penjual',
      onSelected: (item) => _handleMenuTap(context, item),
    );
  }

  // =====================================================
  // NAVIGASI SIDEBAR OWNER
  // =====================================================

  void _handleMenuTap(BuildContext context, String item) {
    switch (item) {
      case 'Dashboard':
        _goTo(context, const DashboardPage());
        break;

      case 'Produk':
        _goTo(context, const ProdukPage());
        break;

      case 'Outlet':
        _goTo(context, const OutletPage());
        break;

      case 'Penjual':
        onPenjualTap();
        break;

      case 'Distribusi':
        _goTo(context, const DistribusiPage());
        break;

      case 'Retur':
        _goTo(context, const ReturPage());
        break;

      case 'Setoran':
        _goTo(context, const SetoranPage());
        break;

      case 'Bagi Hasil':
        _goTo(context, const BagiHasilPage());
        break;

      case 'Laporan':
        _goTo(context, const LaporanPage());
        break;

      case 'Logout':
        _showLogoutDialog(context);
        break;
    }
  }

  // =====================================================
  // PINDAH HALAMAN
  // =====================================================

  void _goTo(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  // =====================================================
  // DIALOG LOGOUT
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
                backgroundColor: const Color(0xFFFF7100),
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

// =========================================================
// OWNER BADGE PENJUAL
// =========================================================

class _PenjualOwnerBadge extends StatelessWidget {
  final bool blackText;

  const _PenjualOwnerBadge({
    this.blackText = true,
  });

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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Owner',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: blackText ? Colors.black : Colors.white,
            ),
          ),

          const SizedBox(width: 4),

          Icon(
            Icons.arrow_drop_down,
            size: 18,
            color: blackText ? Colors.black : Colors.white,
          ),
        ],
      ),
    );
  }
}