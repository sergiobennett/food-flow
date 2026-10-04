import 'package:flutter/material.dart';

class PenjualPage extends StatefulWidget {
  const PenjualPage({super.key});

  @override
  State<PenjualPage> createState() => _PenjualPageState();
}

class _PenjualPageState extends State<PenjualPage> {
  final List<Map<String, dynamic>> penjual = [
    {
      "kode": "P001",
      "nama": "Andi",
      "outlet": "Outlet A",
      "kontak": "0812xxxx",
      "status": "Aktif",
    },
    {
      "kode": "P002",
      "nama": "Budi",
      "outlet": "Outlet B",
      "kontak": "0813xxxx",
      "status": "Aktif",
    },
    {
      "kode": "P003",
      "nama": "Citra",
      "outlet": "Outlet C",
      "kontak": "0815xxxx",
      "status": "Aktif",
    },
  ];

  void tambahPenjual() {
    final kodeController = TextEditingController(
      text: "P00${penjual.length + 1}",
    );
    final namaController = TextEditingController();
    final kontakController = TextEditingController();

    String outlet = "Outlet A";
    String status = "Aktif";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Tambah Penjual"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: kodeController,
                      decoration: const InputDecoration(
                        labelText: "Kode Penjual",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: namaController,
                      decoration: const InputDecoration(
                        labelText: "Nama Penjual",
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: outlet,
                      decoration: const InputDecoration(
                        labelText: "Outlet",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Outlet A",
                          child: Text("Outlet A"),
                        ),
                        DropdownMenuItem(
                          value: "Outlet B",
                          child: Text("Outlet B"),
                        ),
                        DropdownMenuItem(
                          value: "Outlet C",
                          child: Text("Outlet C"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          outlet = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: kontakController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "No. Telepon",
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
                    if (namaController.text.isEmpty) {
                      return;
                    }

                    setState(() {
                      penjual.add({
                        "kode": kodeController.text,
                        "nama": namaController.text,
                        "outlet": outlet,
                        "kontak": kontakController.text,
                        "status": status,
                      });
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

  void editPenjual(int index) {
    final item = penjual[index];

    final kodeController =
        TextEditingController(text: item["kode"]);
    final namaController =
        TextEditingController(text: item["nama"]);
    final kontakController =
        TextEditingController(text: item["kontak"]);

    String outlet = item["outlet"];
    String status = item["status"];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Edit Penjual"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: kodeController,
                      decoration: const InputDecoration(
                        labelText: "Kode Penjual",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: namaController,
                      decoration: const InputDecoration(
                        labelText: "Nama Penjual",
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: outlet,
                      decoration: const InputDecoration(
                        labelText: "Outlet",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Outlet A",
                          child: Text("Outlet A"),
                        ),
                        DropdownMenuItem(
                          value: "Outlet B",
                          child: Text("Outlet B"),
                        ),
                        DropdownMenuItem(
                          value: "Outlet C",
                          child: Text("Outlet C"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          outlet = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: kontakController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "No. Telepon",
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
                      penjual[index] = {
                        "kode": kodeController.text,
                        "nama": namaController.text,
                        "outlet": outlet,
                        "kontak": kontakController.text,
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

  void hapusPenjual(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Penjual"),
          content: const Text(
            "Apakah kamu yakin ingin menghapus penjual ini?",
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
                  penjual.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text("Master Penjual"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MASTER PENJUAL",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Kelola data penjual yang terhubung dengan outlet.",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                ElevatedButton.icon(
                  onPressed: tambahPenjual,
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah Penjual"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Container(
              width: 260,
              height: 42,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari penjual...",
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: ListView(
                  padding: const EdgeInsets.all(15),

                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Kode",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Nama Penjual",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Outlet",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Kontak",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Aksi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Divider(),

                    ...List.generate(
                      penjual.length,
                      (index) {
                        final item = penjual[index];

                        final bool aktif =
                            item["status"] == "Aktif";

                        return Container(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 12,
                          ),

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
                                child: Text(
                                  item["kode"],
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  item["nama"],
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  item["outlet"],
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  item["kontak"],
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color: aktif
                                        ? Colors.green
                                            .withOpacity(
                                                0.12)
                                        : Colors.red
                                            .withOpacity(
                                                0.12),
                                    borderRadius:
                                        BorderRadius
                                            .circular(20),
                                  ),
                                  child: Text(
                                    item["status"],
                                    textAlign:
                                        TextAlign.center,
                                    style: TextStyle(
                                      color: aktif
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        editPenjual(index);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        hapusPenjual(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
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
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text("Kembali"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}