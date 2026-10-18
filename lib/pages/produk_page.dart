import 'package:flutter/material.dart';
import '../api_service.dart';
import 'owner_sidebar.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'outlet_page.dart';
import 'penjual_page.dart' as penjual;
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';

// =========================================================
// HALAMAN MASTER PRODUK
// =========================================================

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  static const Color orange = Color(0xFFFF7100);

  final List<Map<String, dynamic>> produk = [];

  bool _loading = false;
  String? _loadError;
  String search = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    if (mounted) {
      setState(() {
        _loading = true;
        _loadError = null;
      });
    }

    try {
      final data = await ApiService.getProducts();
      if (!mounted) return;

      setState(() {
        produk
          ..clear()
          ..addAll(data);
        _loading = false;
        _loadError = null;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _loadError = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void _showMessage(String message, {bool error = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  String _formatHarga(dynamic value) {
    final harga = double.tryParse(value.toString());
    if (harga == null) return value.toString();

    return harga % 1 == 0
        ? harga.toStringAsFixed(0)
        : harga.toStringAsFixed(2);
  }

  List<Map<String, dynamic>> get produkFilter {
    final query = search.trim().toLowerCase();
    if (query.isEmpty) return produk;

    return produk.where((item) {
      final kode = (item['kode'] ?? '').toString().toLowerCase();
      final nama = (item['nama'] ?? '').toString().toLowerCase();
      return kode.contains(query) || nama.contains(query);
    }).toList();
  }

  // =====================================================
  // NAVIGASI KE HALAMAN TAMBAH PRODUK
  // =====================================================

  Future<void> bukaHalamanTambahProduk() async {
    int nomorTerbesar = 0;

    for (final item in produk) {
      final kode = (item['kode'] ?? '').toString();
      final match = RegExp(r'^P(\d+)$').firstMatch(kode);

      if (match != null) {
        final nomor = int.tryParse(match.group(1)!) ?? 0;
        if (nomor > nomorTerbesar) nomorTerbesar = nomor;
      }
    }

    final kodeBaru =
        'P${(nomorTerbesar + 1).toString().padLeft(3, '0')}';

    final berhasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => TambahProdukPage(kodeProduk: kodeBaru),
      ),
    );

    if (!mounted || berhasil != true) return;

    await _loadProducts();
    _showMessage('Produk berhasil ditambahkan.');
  }

  // =====================================================
  // EDIT PRODUK
  // =====================================================

  void editProduk(int filteredIndex) {
    final item = produkFilter[filteredIndex];
    final id = int.tryParse((item['id'] ?? '').toString());

    if (id == null) {
      _showMessage('ID produk tidak ditemukan. Muat ulang halaman.', error: true);
      return;
    }

    final kodeController =
        TextEditingController(text: (item['kode'] ?? '').toString());
    final namaController =
        TextEditingController(text: (item['nama'] ?? '').toString());
    final hargaController =
        TextEditingController(text: _formatHarga(item['harga'] ?? '0'));

    String kategoriEdit = (item['kategori'] ?? 'Makanan').toString();
    String statusEdit = (item['status'] ?? 'Aktif').toString();
    bool saving = false;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: Container(
                width: 1000,
                decoration: BoxDecoration(
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
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                      child: const Row(
                        children: [
                          Icon(Icons.edit_note, color: Colors.white, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Edit Produk',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDarkInput(
                            'KODE PRODUK',
                            child: _darkTextField(
                              kodeController,
                              '',
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(width: 15),
                          _buildDarkInput(
                            'NAMA PRODUK',
                            flex: 2,
                            child: _darkTextField(
                              namaController,
                              'Masukkan nama produk',
                            ),
                          ),
                          const SizedBox(width: 15),
                          _buildDarkInput(
                            'KATEGORI',
                            flex: 2,
                            child: _darkDropdown(
                              kategoriEdit,
                              ['Makanan', 'Minuman'],
                              (value) {
                                if (value != null) {
                                  setDialogState(() => kategoriEdit = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          _buildDarkInput(
                            'HARGA',
                            child: _darkTextField(
                              hargaController,
                              'Contoh: 10000',
                              isNumber: true,
                            ),
                          ),
                          const SizedBox(width: 15),
                          _buildDarkInput(
                            'STATUS',
                            child: _darkDropdown(
                              statusEdit,
                              ['Aktif', 'Nonaktif'],
                              (value) {
                                if (value != null) {
                                  setDialogState(() => statusEdit = value);
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
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: saving
                                ? null
                                : () => Navigator.pop(dialogContext),
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
                            onPressed: saving
                                ? null
                                : () async {
                                    final nama = namaController.text.trim();
                                    final hargaText =
                                        hargaController.text.trim().replaceAll(',', '.');
                                    final harga = double.tryParse(hargaText);

                                    if (nama.isEmpty) {
                                      _showMessage('Nama produk wajib diisi.', error: true);
                                      return;
                                    }
                                    if (harga == null || !harga.isFinite || harga < 0) {
                                      _showMessage('Harga harus berupa angka nol atau lebih.', error: true);
                                      return;
                                    }

                                    setDialogState(() => saving = true);
                                    try {
                                      await ApiService.updateProduct(
                                        id: id,
                                        kode: kodeController.text.trim(),
                                        nama: nama,
                                        kategori: kategoriEdit,
                                        harga: hargaText,
                                        status: statusEdit,
                                      );

                                      if (!mounted) return;
                                      Navigator.pop(dialogContext);
                                      await _loadProducts();
                                      _showMessage('Produk berhasil diperbarui.');
                                    } catch (e) {
                                      setDialogState(() => saving = false);
                                      _showMessage(
                                        e.toString().replaceFirst('Exception: ', ''),
                                        error: true,
                                      );
                                    }
                                  },
                            icon: const Icon(Icons.save, size: 16, color: Colors.white),
                            label: Text(
                              saving ? 'Menyimpan...' : 'Simpan Produk',
                              style: const TextStyle(
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
    ).then((_) {
      kodeController.dispose();
      namaController.dispose();
      hargaController.dispose();
    });
  }

  // =====================================================
  // HAPUS PRODUK
  // =====================================================

  void hapusProduk(int filteredIndex) {
    final item = produkFilter[filteredIndex];
    final id = int.tryParse((item['id'] ?? '').toString());

    if (id == null) {
      _showMessage('ID produk tidak ditemukan. Muat ulang halaman.', error: true);
      return;
    }

    bool deleting = false;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Hapus Produk',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Apakah kamu yakin ingin menghapus produk ${item['nama']}?',
              ),
              actions: [
                TextButton(
                  onPressed: deleting ? null : () => Navigator.pop(dialogContext),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: deleting
                      ? null
                      : () async {
                          setDialogState(() => deleting = true);
                          try {
                            await ApiService.deleteProduct(id: id);
                            if (!mounted) return;
                            Navigator.pop(dialogContext);
                            await _loadProducts();
                            _showMessage('Produk berhasil dihapus.');
                          } catch (e) {
                            setDialogState(() => deleting = false);
                            _showMessage(
                              e.toString().replaceFirst('Exception: ', ''),
                              error: true,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(deleting ? 'Menghapus...' : 'Hapus'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // =====================================================
  // BUILD MASTER PRODUK
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          FoodFlowSidebar(
            onProdukTap: () {},
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
                            'MASTER PRODUK',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF17243A),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Kelola data produk yang tersedia.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      const OwnerBadge(
                        blackText: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // SEARCH DAN TAMBAH PRODUK

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
                            hintText: 'Cari produk...',
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
                        onPressed: bukaHalamanTambahProduk,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF97316),
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
                          'Tambah Produk',
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

                  // TABEL PRODUK

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
                              color: const Color(0xFFF97316),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                _headerCell('KODE', flex: 2),
                                _verticalDivider(),
                                _headerCell('NAMA PRODUK', flex: 3),
                                _verticalDivider(),
                                _headerCell('KATEGORI', flex: 2),
                                _verticalDivider(),
                                _headerCell('HARGA', flex: 2),
                                _verticalDivider(),
                                _headerCell('STATUS', flex: 2),
                                _verticalDivider(),
                                _headerCell('AKSI', flex: 2),
                              ],
                            ),
                          ),

                          Expanded(
                            child: _loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFF97316),
                                    ),
                                  )
                                : _loadError != null
                                    ? Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.cloud_off,
                                                size: 36,
                                                color: Colors.redAccent,
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                'Gagal memuat produk\\n$_loadError',
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 12),
                                              ElevatedButton.icon(
                                                onPressed: _loadProducts,
                                                icon: const Icon(Icons.refresh),
                                                label: const Text('Coba Lagi'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : produkFilter.isEmpty
                                        ? Center(
                                            child: Text(
                                              search.isEmpty
                                                  ? 'Belum ada data produk.'
                                                  : 'Produk tidak ditemukan.',
                                              style: const TextStyle(
                                                color: Color(0xFF718096),
                                              ),
                                            ),
                                          )
                                        : ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              itemCount: produkFilter.length,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  height: 1,
                                  color: Colors.grey.shade200,
                                );
                              },
                              itemBuilder: (context, index) {
                                final item = produkFilter[index];
                                final bool isAktif =
                                    item['status'] == 'Aktif';

                                return SizedBox(
                                  height: 60,
                                  child: Row(
                                    children: [
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

                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: item['kategori'] ==
                                                        'Makanan'
                                                    ? Colors.orange
                                                    : Colors.green,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              item['kategori'].toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: item['kategori'] ==
                                                        'Makanan'
                                                    ? Colors.orange
                                                    : Colors.green,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            'Rp ${_formatHarga(item['harga'])}',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF1E293B),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isAktif
                                                  ? const Color(0xFFDCFCE7)
                                                  : const Color(0xFFFEE2E2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  size: 6,
                                                  color: isAktif
                                                      ? const Color(0xFF22C55E)
                                                      : const Color(0xFFEF4444),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  item['status'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: isAktif
                                                        ? const Color(
                                                            0xFF22C55E,
                                                          )
                                                        : const Color(
                                                            0xFFEF4444,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () => editProduk(index),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFE2E8F0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 16,
                                                  color: Color(0xFF334155),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(width: 8),

                                            InkWell(
                                              onTap: () => hapusProduk(index),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFEF4444,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
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

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF97316),
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
  // WIDGET HEADER TABEL
  // =====================================================

  Widget _headerCell(String text, {required int flex}) {
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

  // =====================================================
  // WIDGET DIALOG EDIT PRODUK
  // =====================================================

  Widget _buildDarkInput(
    String label, {
    required Widget child,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Column(
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
      ),
    );
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
          ? TextInputType.number
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
        fillColor: readOnly
            ? const Color(0xFF1E293B).withOpacity(0.5)
            : const Color(0xFF1E293B),
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
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: item == 'Aktif'
                        ? Colors.green
                        : item == 'Nonaktif'
                            ? Colors.red
                            : Colors.orange,
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
}

// =========================================================
// HALAMAN TAMBAH PRODUK
// DALAM FILE YANG SAMA
// =========================================================

class TambahProdukPage extends StatefulWidget {
  final String kodeProduk;

  const TambahProdukPage({
    super.key,
    required this.kodeProduk,
  });

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  static const Color orange = Color(0xFFFF7100);

  final TextEditingController kodeController =
      TextEditingController();

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController hargaController =
      TextEditingController();

  final FocusNode namaFocusNode = FocusNode();

  String kategori = 'Makanan';
  String status = 'Aktif';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    kodeController.text = widget.kodeProduk;
  }

  @override
  void dispose() {
    kodeController.dispose();
    namaController.dispose();
    hargaController.dispose();
    namaFocusNode.dispose();
    super.dispose();
  }

  // =====================================================
  // SIMPAN PRODUK
  // =====================================================

  Future<void> _simpanProduk() async {
    final String nama = namaController.text.trim();
    final String hargaText =
        hargaController.text.trim().replaceAll(',', '.');
    final double? harga = double.tryParse(hargaText);

    if (nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama produk wajib diisi.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (hargaText.isEmpty || harga == null || !harga.isFinite || harga < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harga harus berupa angka nol atau lebih.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ApiService.createProduct(
        kode: kodeController.text.trim(),
        nama: nama,
        kategori: kategori,
        harga: hargaText,
        status: status,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk berhasil ditambahkan.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop<bool>(context, true);
    } catch (e) {
      if (!mounted) return;

      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // =====================================================
  // RESET FORM
  // =====================================================

  void _resetForm() {
    setState(() {
      namaController.clear();
      hargaController.clear();
      kategori = 'Makanan';
      status = 'Aktif';
    });

    FocusScope.of(context).requestFocus(namaFocusNode);
  }

  // =====================================================
  // BUILD HALAMAN TAMBAH PRODUK
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F5FA),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR OWNER

          FoodFlowSidebar(
            onProdukTap: () => Navigator.pop(context),
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
                              'TAMBAH PRODUK',
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF263238),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Tambahkan produk baru ke dalam master data.',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const OwnerBadge(),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // PENCARIAN DAN TOMBOL TAMBAH

                  Row(
                    children: [
                      Container(
                        width: 245,
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
                              size: 15,
                              color: Color(0xFF94A3B8),
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Cari produk...',
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
                          FocusScope.of(context).requestFocus(
                            namaFocusNode,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Tambah Produk',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // FORM BESAR DAN TETAP DI SEBELAH KIRI

                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double formWidth =
                            constraints.maxWidth >= 808
                                ? 760
                                : (constraints.maxWidth - 48)
                                    .clamp(320.0, 760.0)
                                    .toDouble();

                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                              top: 10,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: _buildFormCard(formWidth),
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
                      onPressed: () => Navigator.pop(context),
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
  // KARTU FORM
  // =====================================================

  Widget _buildFormCard(double formWidth) {
    return Container(
      width: formWidth,
      height: 270,
      decoration: BoxDecoration(
        color: const Color(0xFF080D13),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF263445),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER KARTU

          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF111F2B),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(9),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 26,
                  color: Colors.white,
                ),
                SizedBox(width: 14),
                Text(
                  'Tambah Produk',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // ISI FORM

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                20,
                18,
                16,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _formField(
                        'KODE PRODUK',
                        flex: 9,
                        child: _formTextField(
                          controller: kodeController,
                          hint: '',
                          readOnly: true,
                        ),
                      ),

                      const SizedBox(width: 8),

                      _formField(
                        'NAMA PRODUK',
                        flex: 13,
                        child: _formTextField(
                          controller: namaController,
                          hint: 'Masukkan nama produk',
                          focusNode: namaFocusNode,
                        ),
                      ),

                      const SizedBox(width: 8),

                      _formField(
                        'KATEGORI',
                        flex: 13,
                        child: _formDropdown(
                          value: kategori,
                          items: const ['Makanan', 'Minuman'],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => kategori = value);
                            }
                          },
                        ),
                      ),

                      const SizedBox(width: 8),

                      _formField(
                        'HARGA',
                        flex: 9,
                        child: _formTextField(
                          controller: hargaController,
                          hint: 'Contoh: 10000',
                          isNumber: true,
                        ),
                      ),

                      const SizedBox(width: 8),

                      _formField(
                        'STATUS',
                        flex: 9,
                        child: _formDropdown(
                          value: status,
                          items: const ['Aktif', 'Nonaktif'],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => status = value);
                            }
                          },
                        ),
                      ),

                      const SizedBox(width: 8),

                      // AKSI: tombol edit dan hapus seperti referensi.
                      _formField(
                        'AKSI',
                        flex: 8,
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Tooltip(
                                message: 'Edit produk',
                                child: InkWell(
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(
                                      namaFocusNode,
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF263445),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: const Color(0xFF334155),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 14,
                                      color: Color(0xFFCBD5E1),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 5),

                              Tooltip(
                                message: 'Hapus isian',
                                child: InkWell(
                                  onTap: _resetForm,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7F2D20),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      size: 14,
                                      color: Colors.white,
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

                  const Spacer(),

                  // TOMBOL BATAL DAN SIMPAN

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Color(0xFF94A3B8),
                        ),
                        label: const Text(
                          'Batal',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton.icon(
                        onPressed: _isSaving ? null : _simpanProduk,
                        icon: const Icon(
                          Icons.save,
                          size: 15,
                          color: Colors.white,
                        ),
                        label: Text(
                          _isSaving ? 'Menyimpan...' : 'Simpan Produk',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF97316),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
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

  // =====================================================
  // LABEL FORM
  // =====================================================

  Widget _formField(
    String label, {
    required int flex,
    required Widget child,
  }) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF94A3B8),
              ),
            ),
          ),

          const SizedBox(height: 8),

          child,
        ],
      ),
    );
  }

  // =====================================================
  // TEXT FIELD FORM
  // =====================================================

  Widget _formTextField({
    required TextEditingController controller,
    required String hint,
    bool readOnly = false,
    bool isNumber = false,
    FocusNode? focusNode,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        keyboardType: isNumber
            ? TextInputType.number
            : TextInputType.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 9,
          ),
          filled: true,
          fillColor: const Color(0xFF182435),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 10,
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
  // DROPDOWN FORM
  // =====================================================

  Widget _formDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF182435),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF263445),
          width: 0.8,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          isDense: true,
          menuMaxHeight: 180,
          dropdownColor: const Color(0xFF182435),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 15,
            color: Color(0xFF94A3B8),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          items: items.map((item) {
            final Color dotColor = item == 'Aktif'
                ? const Color(0xFF22C55E)
                : item == 'Nonaktif'
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFFF7100);

            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 7,
                    color: dotColor,
                  ),
                  const SizedBox(width: 6),
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
// SIDEBAR FOOD FLOW
// MENGGUNAKAN OWNER SIDEBAR BERSAMA
// =========================================================

class FoodFlowSidebar extends StatelessWidget {
  final VoidCallback? onProdukTap;

  const FoodFlowSidebar({
    super.key,
    this.onProdukTap,
  });

  @override
  Widget build(BuildContext context) {
    return OwnerSidebar(
      activeItem: 'Produk',
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
        // Di halaman Produk, menu ini tidak melakukan navigasi.
        // Di halaman Tambah Produk, menu ini kembali ke daftar Produk.
        onProdukTap?.call();
        break;

      case 'Outlet':
        _goTo(context, const OutletPage());
        break;

      case 'Penjual':
        _goTo(context, penjual.PenjualPage());
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
        );
      },
    );
  }
}

// =========================================================
// TOMBOL OWNER
// =========================================================

class OwnerBadge extends StatelessWidget {
  final bool blackText;

  const OwnerBadge({
    super.key,
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