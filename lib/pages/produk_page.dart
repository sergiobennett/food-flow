import 'package:flutter/material.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final List<Map<String, dynamic>> produk = [
    {
      "kode": "P001",
      "nama": "Produk A",
      "kategori": "Makanan",
      "harga": "10000",
      "status": "Aktif",
    },
    {
      "kode": "P002",
      "nama": "Produk B",
      "kategori": "Makanan",
      "harga": "12000",
      "status": "Aktif",
    },
    {
      "kode": "P003",
      "nama": "Produk C",
      "kategori": "Minuman",
      "harga": "8000",
      "status": "Aktif",
    },
    {
      "kode": "P004",
      "nama": "Produk D",
      "kategori": "Makanan",
      "harga": "15000",
      "status": "Nonaktif",
    },
  ];

  String search = "";

  List<Map<String, dynamic>> get produkFilter {
    if (search.isEmpty) {
      return produk;
    }

    return produk.where((item) {
      return item["nama"]
          .toString()
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();
  }

  void hapusProduk(int index) {
    final item = produkFilter[index];

    final indexAsli = produk.indexOf(item);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Produk"),
          content: Text(
            "Yakin ingin menghapus ${item["nama"]}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  produk.removeAt(indexAsli);
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void editProduk(int index) {
    final item = produkFilter[index];

    final indexAsli = produk.indexOf(item);

    final namaController =
        TextEditingController(text: item["nama"]);

    final hargaController =
        TextEditingController(text: item["harga"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Produk"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Harga",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  produk[indexAsli]["nama"] =
                      namaController.text;

                  produk[indexAsli]["harga"] =
                      hargaController.text;
                });

                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void tambahProduk(Map<String, dynamic> data) {
    setState(() {
      produk.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      body: Row(
        children: [
          // =========================
          // SIDEBAR
          // =========================
          Container(
            width: 155,
            color: Colors.white,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "FOOD FLOW",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                _sectionTitle("MAIN MENU"),

                _menuItem(
                  Icons.dashboard_outlined,
                  "Dashboard",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 15),

                _sectionTitle("MASTER DATA"),

                _menuItem(
                  Icons.inventory_2_outlined,
                  "Produk",
                  active: true,
                ),

                _menuItem(
                  Icons.store_outlined,
                  "Outlet",
                  onTap: () {},
                ),

                _menuItem(
                  Icons.person_outline,
                  "Penjual",
                  onTap: () {},
                ),

                const SizedBox(height: 15),

                _sectionTitle("TRANSAKSI"),

                _menuItem(
                  Icons.local_shipping_outlined,
                  "Distribusi",
                  onTap: () {},
                ),

                _menuItem(
                  Icons.assignment_return_outlined,
                  "Retur",
                  onTap: () {},
                ),

                _menuItem(
                  Icons.payments_outlined,
                  "Setoran",
                  onTap: () {},
                ),

                _menuItem(
                  Icons.account_balance_wallet_outlined,
                  "Bagi Hasil",
                  onTap: () {},
                ),

                const SizedBox(height: 15),

                _sectionTitle("LAPORAN"),

                _menuItem(
                  Icons.bar_chart_outlined,
                  "Laporan",
                  onTap: () {},
                ),

                const SizedBox(height: 15),

                _sectionTitle("AKUN"),

                _menuItem(
                  Icons.person_outline,
                  "Profil",
                  onTap: () {},
                ),

                _menuItem(
                  Icons.logout_outlined,
                  "LogOut",
                  onTap: () {},
                ),
              ],
            ),
          ),

          // =========================
          // CONTENT
          // =========================
          Expanded(
            child: Column(
              children: [
                // TOP BAR
                Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "MASTER PRODUK",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF243247),
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // CONTENT
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "MASTER PRODUK",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF243247),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Kelola data produk yang didistribusikan.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // SEARCH + BUTTON
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 255,
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                  color:
                                      const Color(0xFFE0E5EB),
                                ),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    search = value;
                                  });
                                },
                                decoration:
                                    const InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "Cari produk...",
                                  hintStyle: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                final data =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TambahProdukPage(),
                                  ),
                                );

                                if (data != null) {
                                  tambahProduk(data);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orange,
                                foregroundColor:
                                    Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                              ),
                              child: const Text(
                                "Tambah Produk",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // TABLE
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                // HEADER
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  child: const Row(
                                    children: [
                                      _HeaderCell(
                                        "KODE",
                                        flex: 1,
                                      ),
                                      _HeaderCell(
                                        "NAMA PRODUK",
                                        flex: 2,
                                      ),
                                      _HeaderCell(
                                        "KATEGORI",
                                        flex: 2,
                                      ),
                                      _HeaderCell(
                                        "HARGA",
                                        flex: 1,
                                      ),
                                      _HeaderCell(
                                        "STATUS",
                                        flex: 1,
                                      ),
                                      _HeaderCell(
                                        "AKSI",
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        produkFilter.length,
                                    itemBuilder:
                                        (context, index) {
                                      final item =
                                          produkFilter[index];

                                      return SizedBox(
                                        height: 42,
                                        child: Row(
                                          children: [
                                            _bodyCell(
                                              item["kode"],
                                              flex: 1,
                                              child:
                                                  _kodeBadge(
                                                item["kode"],
                                              ),
                                            ),

                                            _bodyCell(
                                              item["nama"],
                                              flex: 2,
                                            ),

                                            _bodyCell(
                                              item["kategori"],
                                              flex: 2,
                                              child:
                                                  _kategoriBadge(
                                                item["kategori"],
                                              ),
                                            ),

                                            _bodyCell(
                                              item["harga"],
                                              flex: 1,
                                              child: Text(
                                                " ${item["harga"]}",
                                                style:
                                                    const TextStyle(
                                                  fontSize: 10,
                                                  color:
                                                      Colors.grey,
                                                ),
                                              ),
                                            ),

                                            _bodyCell(
                                              item["status"],
                                              flex: 1,
                                              child:
                                                  _statusBadge(
                                                item["status"],
                                              ),
                                            ),

                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  IconButton(
                                                    onPressed:
                                                        () {
                                                      editProduk(
                                                        index,
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(
                                                      Icons.edit,
                                                      size: 17,
                                                    ),
                                                    color:
                                                        Colors.black87,
                                                  ),
                                                  IconButton(
                                                    onPressed:
                                                        () {
                                                      hapusProduk(
                                                        index,
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(
                                                      Icons
                                                          .delete,
                                                      size: 17,
                                                    ),
                                                    color:
                                                        Colors.red,
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
                          alignment:
                              Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.orange,
                              foregroundColor:
                                  Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              "Kembali",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),
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

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 5,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  static Widget _menuItem(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    bool active = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFFFF2E8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.orange,
            ),
            const SizedBox(width: 7),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: active
                    ? Colors.orange
                    : Colors.black87,
                fontWeight: active
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _bodyCell(
    String value, {
    required int flex,
    Widget? child,
  }) {
    return Expanded(
      flex: flex,
      child: Center(
        child: child ??
            Text(
              value,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
      ),
    );
  }

  static Widget _kodeBadge(String value) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 9,
        ),
      ),
    );
  }

  static Widget _kategoriBadge(String value) {
    final bool makanan =
        value == "Makanan";

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: makanan
            ? const Color(0xFFFFC28A)
            : const Color(0xFFD8F5DD),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 9,
          color: makanan
              ? Colors.deepOrange
              : Colors.green,
        ),
      ),
    );
  }

  static Widget _statusBadge(String value) {
    final bool aktif =
        value == "Aktif";

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: aktif
            ? const Color(0xFFD9F6DF)
            : const Color(0xFFFFB3B3),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        aktif ? "• Aktif" : "• Nonaktif",
        style: TextStyle(
          fontSize: 9,
          color: aktif
              ? Colors.green
              : Colors.red,
        ),
      ),
    );
  }
}

// =====================================================
// HEADER TABLE
// =====================================================

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _HeaderCell(
    this.text, {
    required this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// TAMBAH PRODUK
// =====================================================

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() =>
      _TambahProdukPageState();
}

class _TambahProdukPageState
    extends State<TambahProdukPage> {
  final kodeController =
      TextEditingController();

  final namaController =
      TextEditingController();

  final hargaController =
      TextEditingController();

  String kategori = "Makanan";
  String status = "Aktif";

  void simpanProduk() {
    if (kodeController.text.isEmpty ||
        namaController.text.isEmpty ||
        hargaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Lengkapi data produk terlebih dahulu."),
        ),
      );

      return;
    }

    Navigator.pop(
      context,
      {
        "kode": kodeController.text,
        "nama": namaController.text,
        "kategori": kategori,
        "harga": hargaController.text,
        "status": status,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF3F6FA),
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 155,
            color: Colors.white,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "FOOD FLOW",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                _sidebarTitle("MAIN MENU"),

                _sidebarItem(
                  Icons.dashboard_outlined,
                  "Dashboard",
                ),

                const SizedBox(height: 15),

                _sidebarTitle("MASTER DATA"),

                _sidebarItem(
                  Icons.inventory_2_outlined,
                  "Produk",
                  active: true,
                ),

                _sidebarItem(
                  Icons.store_outlined,
                  "Outlet",
                ),

                _sidebarItem(
                  Icons.person_outline,
                  "Penjual",
                ),

                const SizedBox(height: 15),

                _sidebarTitle("TRANSAKSI"),

                _sidebarItem(
                  Icons.local_shipping_outlined,
                  "Distribusi",
                ),

                _sidebarItem(
                  Icons.assignment_return_outlined,
                  "Retur",
                ),

                _sidebarItem(
                  Icons.payments_outlined,
                  "Setoran",
                ),

                _sidebarItem(
                  Icons.account_balance_wallet_outlined,
                  "Bagi Hasil",
                ),

                const SizedBox(height: 15),

                _sidebarTitle("LAPORAN"),

                _sidebarItem(
                  Icons.bar_chart_outlined,
                  "Laporan",
                ),

                const SizedBox(height: 15),

                _sidebarTitle("AKUN"),

                _sidebarItem(
                  Icons.person_outline,
                  "Profil",
                ),

                _sidebarItem(
                  Icons.logout_outlined,
                  "LogOut",
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                // TOP BAR
                Container(
                  height: 90,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TAMBAH PRODUK",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF243247),
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration:
                            BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "TAMBAH PRODUK",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Color(0xFF243247),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          "Tambahkan produk baru ke dalam master data.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 35),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Container(
                              width: 255,
                              height: 40,
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 12,
                              ),
                              decoration:
                                  BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(
                                        6),
                              ),
                              child:
                                  const TextField(
                                decoration:
                                    InputDecoration(
                                  border:
                                      InputBorder.none,
                                  hintText:
                                      "Cari produk...",
                                  hintStyle:
                                      TextStyle(
                                    fontSize: 11,
                                  ),
                                  prefixIcon:
                                      Icon(
                                    Icons.search,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () {},
                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    Colors.orange,
                                foregroundColor:
                                    Colors.white,
                              ),
                              child:
                                  const Text(
                                "Tambah Produk",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // FORM HITAM
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 560,
                              height: 225,
                              padding:
                                  const EdgeInsets
                                      .all(15),
                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFF080D12,
                                ),
                                borderRadius:
                                    BorderRadius
                                        .circular(8),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration:
                                        BoxDecoration(
                                      color:
                                          const Color(
                                        0xFF14202B,
                                      ),
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        6,
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons
                                              .inventory_2_outlined,
                                          color:
                                              Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Tambah Produk",
                                          style:
                                              TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: 11,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),

                                  Row(
                                    children: [
                                      _formField(
                                        "KODE PRODUK",
                                        kodeController,
                                        "P001",
                                      ),

                                      _formField(
                                        "NAMA PRODUK",
                                        namaController,
                                        "Masukkan nama produk",
                                      ),

                                      _dropdown(
                                        "KATEGORI",
                                        kategori,
                                        [
                                          "Makanan",
                                          "Minuman",
                                        ],
                                        (value) {
                                          setState(() {
                                            kategori =
                                                value!;
                                          });
                                        },
                                      ),

                                      _formField(
                                        "HARGA",
                                        hargaController,
                                        "Contoh: 10000",
                                      ),

                                      _dropdown(
                                        "STATUS",
                                        status,
                                        [
                                          "Aktif",
                                          "Nonaktif",
                                        ],
                                        (value) {
                                          setState(() {
                                            status =
                                                value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  const Spacer(),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                        style:
                                            TextButton
                                                .styleFrom(
                                          foregroundColor:
                                              Colors.white,
                                        ),
                                        child:
                                            const Text(
                                          "Batal",
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      ElevatedButton(
                                        onPressed:
                                            simpanProduk,
                                        style:
                                            ElevatedButton
                                                .styleFrom(
                                          backgroundColor:
                                              Colors.orange,
                                          foregroundColor:
                                              Colors.white,
                                        ),
                                        child:
                                            const Text(
                                          "Simpan Produk",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment:
                              Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.orange,
                              foregroundColor:
                                  Colors.white,
                            ),
                            child:
                                const Text("KEMBALI"),
                          ),
                        ),

                        const SizedBox(height: 20),
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

  static Widget _sidebarTitle(
      String text) {
    return Padding(
      padding:
          const EdgeInsets.only(
        left: 15,
        bottom: 5,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight:
              FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  static Widget _sidebarItem(
    IconData icon,
    String text, {
    bool active = false,
  }) {
    return Container(
      margin:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration:
          BoxDecoration(
        color: active
            ? const Color(0xFFFFF2E8)
            : Colors.transparent,
        borderRadius:
            BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.orange,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: active
                  ? Colors.orange
                  : Colors.black87,
              fontWeight: active
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _formField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 30,
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                decoration:
                    InputDecoration(
                  hintText: hint,
                  hintStyle:
                      const TextStyle(
                    color: Colors.grey,
                    fontSize: 7,
                  ),
                  filled: true,
                  fillColor:
                      const Color(0xFF111B25),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                            5),
                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?>
        onChanged,
  ) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 7,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 30,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              decoration:
                  BoxDecoration(
                color:
                    const Color(0xFF111B25),
                borderRadius:
                    BorderRadius.circular(5),
              ),
              child:
                  DropdownButtonHideUnderline(
                child:
                    DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  dropdownColor:
                      const Color(0xFF111B25),
                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                  ),
                  icon:
                      const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 15,
                  ),
                  items: items
                      .map(
                        (item) =>
                            DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}