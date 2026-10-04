import 'package:flutter/material.dart';

class OutletPage extends StatefulWidget {
  const OutletPage({super.key});

  @override
  State<OutletPage> createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  final List<Map<String, String>> outlet = [
    {
      "kode": "001",
      "nama": "Outlet A",
      "alamat": "Rungkut",
      "penjual": "Andi",
      "status": "Aktif",
    },
    {
      "kode": "002",
      "nama": "Outlet B",
      "alamat": "Sukolilo",
      "penjual": "Budi",
      "status": "Aktif",
    },
    {
      "kode": "003",
      "nama": "Outlet C",
      "alamat": "Wonokromo",
      "penjual": "Citra",
      "status": "Aktif",
    },
  ];

  void tambahOutlet() {
    final kodeController = TextEditingController();
    final namaController = TextEditingController();
    final alamatController = TextEditingController();
    final penjualController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Outlet"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: kodeController,
                decoration: const InputDecoration(
                  labelText: "Kode Outlet",
                ),
              ),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Outlet",
                ),
              ),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                ),
              ),
              TextField(
                controller: penjualController,
                decoration: const InputDecoration(
                  labelText: "Penjual",
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
                if (namaController.text.isNotEmpty) {
                  setState(() {
                    outlet.add({
                      "kode": kodeController.text,
                      "nama": namaController.text,
                      "alamat": alamatController.text,
                      "penjual": penjualController.text,
                      "status": "Aktif",
                    });
                  });

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void editOutlet(int index) {
    final namaController =
        TextEditingController(text: outlet[index]["nama"]);

    final alamatController =
        TextEditingController(text: outlet[index]["alamat"]);

    final penjualController =
        TextEditingController(text: outlet[index]["penjual"]);

    String status = outlet[index]["status"] ?? "Aktif";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Edit Outlet"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: "Nama Outlet",
                    ),
                  ),
                  TextField(
                    controller: alamatController,
                    decoration: const InputDecoration(
                      labelText: "Alamat",
                    ),
                  ),
                  TextField(
                    controller: penjualController,
                    decoration: const InputDecoration(
                      labelText: "Penjual",
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: const InputDecoration(
                      labelText: "Status",
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Aktif",
                        child: Text("Aktif"),
                      ),
                      DropdownMenuItem(
                        value: "Nonaktif",
                        child: Text("Nonaktif"),
                      ),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        status = value!;
                      });
                    },
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
                      outlet[index] = {
                        "kode": outlet[index]["kode"]!,
                        "nama": namaController.text,
                        "alamat": alamatController.text,
                        "penjual": penjualController.text,
                        "status": status,
                      };
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void hapusOutlet(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Outlet"),
          content: const Text(
            "Apakah kamu yakin ingin menghapus outlet ini?",
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
                  outlet.removeAt(index);
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  Widget menuItem(
    IconData icon,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.orange,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF20232D),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuBox(
    String title,
    List<Widget> children,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6EC),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF667085),
              ),
            ),
          ),
          const SizedBox(height: 2),
          ...children,
        ],
      ),
    );
  }

  Widget statusWidget(String status) {
    final aktif = status == "Aktif";

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: aktif
            ? const Color(0xFFDDF5E3)
            : const Color(0xFFFFDADA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "• ${aktif ? "Aktif" : "Nonaktif"}",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: aktif
              ? const Color(0xFF27AE60)
              : Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),

      body: Row(
        children: [

          // ================= SIDEBAR =================
          Container(
            width: 155,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: Colors.orange,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                menuBox(
                  "MAIN MENU",
                  [
                    menuItem(
                      Icons.dashboard_outlined,
                      "Dashboard",
                    ),
                  ],
                ),

                menuBox(
                  "MASTER DATA",
                  [
                    menuItem(
                      Icons.inventory_2_outlined,
                      "Produk",
                    ),
                    menuItem(
                      Icons.store_outlined,
                      "Outlet",
                    ),
                    menuItem(
                      Icons.people_outline,
                      "Penjual",
                    ),
                  ],
                ),

                menuBox(
                  "TRANSAKSI",
                  [
                    menuItem(
                      Icons.local_shipping_outlined,
                      "Distribusi",
                    ),
                    menuItem(
                      Icons.assignment_return_outlined,
                      "Retur",
                    ),
                    menuItem(
                      Icons.payments_outlined,
                      "Setoran",
                    ),
                    menuItem(
                      Icons.share_outlined,
                      "Bagi Hasil",
                    ),
                  ],
                ),

                menuBox(
                  "LAPORAN",
                  [
                    menuItem(
                      Icons.description_outlined,
                      "Laporan",
                    ),
                  ],
                ),

                menuBox(
                  "AKUN",
                  [
                    menuItem(
                      Icons.person_outline,
                      "Profil",
                    ),
                    menuItem(
                      Icons.logout,
                      "LogOut",
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================= CONTENT =================
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

                  // HEADER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MASTER OUTLET",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF20232D),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Kelola data outlet tempat produk didistribusikan.",
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  Color(0xFF667085),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              BorderRadius.circular(7),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
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

                  // SEARCH + TAMBAH
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
                              size: 14,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 7),
                            Text(
                              "Cari outlet...",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        onPressed: tambahOutlet,
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.orange,
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
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
                          "Tambah Outlet",
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

                  // ================= TABLE =================
                  Container(
                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 45,
                    ),
                    padding:
                        const EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: [

                        // TABLE HEADER
                        Container(
                          height: 27,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "KODE",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    "NAMA OUTLET",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    "ALAMAT",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    "PENJUAL",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "STATUS",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "AKSI",
                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                      fontSize: 8,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // TABLE DATA
                        ...List.generate(
                          outlet.length,
                          (index) {
                            final item =
                                outlet[index];

                            return Container(
                              height: 43,
                              decoration:
                                  const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        Color(0xFFE5E7EB),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [

                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                          horizontal: 18,
                                          vertical: 6,
                                        ),
                                        decoration:
                                            BoxDecoration(
                                          color:
                                              const Color(
                                                  0xFFE8EDF3),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          item["kode"]!,
                                          style:
                                              const TextStyle(
                                            fontSize: 8,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        item["nama"]!,
                                        style:
                                            const TextStyle(
                                          fontSize: 10,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets
                                                    .all(7),
                                            decoration:
                                                BoxDecoration(
                                              color:
                                                  const Color(
                                                      0xFFFFE5D1),
                                              shape:
                                                  BoxShape
                                                      .circle,
                                            ),
                                            child:
                                                const Icon(
                                              Icons
                                                  .location_on,
                                              size: 14,
                                              color:
                                                  Colors
                                                      .orange,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            item["alamat"]!,
                                            style:
                                                const TextStyle(
                                              fontSize: 9,
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Container(
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                          horizontal: 13,
                                          vertical: 5,
                                        ),
                                        decoration:
                                            BoxDecoration(
                                          color:
                                              const Color(
                                                  0xFFE0E0E0),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            15,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                          children: [
                                            const Icon(
                                              Icons.person,
                                              size: 14,
                                              color:
                                                  Colors
                                                      .black,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              item[
                                                  "penjual"]!,
                                              style:
                                                  const TextStyle(
                                                fontSize: 9,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child:
                                          statusWidget(
                                        item["status"]!,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                      children: [

                                        IconButton(
                                          onPressed: () {
                                            editOutlet(
                                              index,
                                            );
                                          },
                                          icon:
                                              const Icon(
                                            Icons.edit,
                                            size: 18,
                                            color:
                                                Color(
                                                    0xFF263238),
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            hapusOutlet(
                                              index,
                                            );
                                          },
                                          icon:
                                              const Icon(
                                            Icons.delete,
                                            size: 18,
                                            color:
                                                Colors.red,
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
                        // ================= TOMBOL KEMBALI =================
                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                            ),
                            child: const Text("Kembali"),
                          ),
                        ),
                      ],
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
}