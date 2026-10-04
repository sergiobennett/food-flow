import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'retur_page.dart';
import 'distribusi_page.dart';
import 'bagihasil_page.dart';
import 'laporan_page.dart';

class SetoranPage extends StatelessWidget {
  const SetoranPage({super.key});

  final List<Map<String, String>> data = const [
    {"kode":"S001","tgl":"21","outlet":"A","penjual":"Andi","penjualan":"500.000","setoran":"500.000","status":"Lunas"},
    {"kode":"S002","tgl":"21","outlet":"B","penjual":"Budi","penjualan":"450.000","setoran":"450.000","status":"Lunas"},
    {"kode":"S003","tgl":"20","outlet":"C","penjual":"Citra","penjualan":"600.000","setoran":"550.000","status":"Selisih"},
    {"kode":"S004","tgl":"23","outlet":"B","penjual":"Budi","penjualan":"550.000","setoran":"550.000","status":"Lunas"},
    {"kode":"S005","tgl":"23","outlet":"C","penjual":"Citra","penjualan":"200.000","setoran":"150.000","status":"Selisih"},
    {"kode":"S006","tgl":"24","outlet":"B","penjual":"Budi","penjualan":"450.000","setoran":"450.000","status":"Lunas"},
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      context,
      title: "SETORAN",
      subtitle: "Kelola penerimaan setoran uang harian dari penjual.",
      search: "Cari setoran...",
      actionText: "Proses Setoran",
      onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailSetoranPage())),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: _card(),
        child: Column(children: [
          _header(["KODE","TGL","OUTLET","PENJUAL","PENJUALAN","SETORAN","STATUS","AKSI"]),
          ...data.map((e) => Container(
            height: 43,
            color: data.indexOf(e).isEven ? Colors.white : const Color(0xFFF7F9FC),
            child: Row(children: [
              _cell(e["kode"]!, 1),
              _cell(e["tgl"]!, 1),
              _cell(e["outlet"]!, 1),
              _cell(e["penjual"]!, 1.5),
              _cell(e["penjualan"]!, 1.5),
              _cell(e["setoran"]!, 1.5),
              _status(e["status"]!, 1.5),
              Expanded(flex: 1, child: Center(child: TextButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailSetoranPage())),
                icon: const Icon(Icons.description_outlined, size: 14),
                label: const Text("Detail", style: TextStyle(fontSize: 9)),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFFFF6B00), backgroundColor: const Color(0xFFFFF0E7)),
              ))),
            ]),
          )),
        ]),
      ),
    );
  }
}

class DetailSetoranPage extends StatefulWidget {
  const DetailSetoranPage({super.key});

  @override
  State<DetailSetoranPage> createState() => _DetailSetoranPageState();
}

class _DetailSetoranPageState extends State<DetailSetoranPage> {
  String outlet = "Outlet A";
  String penjual = "Andi";
  String status = "Lunas";

  @override
  Widget build(BuildContext context) {
    return _page(
      context,
      title: "DETAIL SETORAN",
      subtitle: "Rincian penerimaan setoran uang harian.",
      search: "Cari setoran...",
      actionText: "Proses Setoran",
      onAction: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: _card(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _fieldLabel(Icons.sell_outlined, "Kode Setoran"),
          _field("S001"),
          _fieldLabel(Icons.calendar_today_outlined, "Tanggal"),
          _field("21 Sep 2026"),
          _fieldLabel(Icons.store_outlined, "Outlet"),
          _drop(outlet, ["Outlet A","Outlet B","Outlet C"], (v) => setState(() => outlet = v!)),
          _fieldLabel(Icons.person_outline, "Penjual"),
          _drop(penjual, ["Andi","Budi","Citra"], (v) => setState(() => penjual = v!)),
          _fieldLabel(Icons.payments_outlined, "Total Penjualan"),
          _field("Rp500.000"),
          _fieldLabel(Icons.account_balance_wallet_outlined, "Jumlah Setoran"),
          _field("Rp500.000"),
          _fieldLabel(Icons.check_circle_outline, "Status"),
          _drop(status, ["Lunas","Selisih"], (v) => setState(() => status = v!)),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _blueButton("⊗ Batal", () => Navigator.pop(context))),
            const SizedBox(width: 8),
            Expanded(child: _blueButton("▣ Simpan Setoran", () => Navigator.pop(context))),
          ]),
        ]),
      ),
    );
  }
}

Widget _page(BuildContext context, {required String title, required String subtitle, required String search, required String actionText, required VoidCallback onAction, required Widget child}) => Scaffold(
  backgroundColor: const Color(0xFFF1F5F9),
  body: Row(children: [
    _sidebar(context),
    Expanded(child: Padding(
      padding: const EdgeInsets.fromLTRB(30,28,40,20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color(0xFF1E293B))),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(fontSize: 10,color: Color(0xFF64748B))),
          ]),
          _owner(),
        ]),
        const SizedBox(height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(width:255,height:28,padding:const EdgeInsets.symmetric(horizontal:10),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(5)),child:Row(children:[const Icon(Icons.search,size:13,color:Color(0xFF64748B)),const SizedBox(width:5),Text(search,style:const TextStyle(fontSize:9,color:Color(0xFF94A3B8)))])),
          _orangeButton(actionText,onAction),
        ]),
        const SizedBox(height:22),
        child,
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _orangeButton(
              "KEMBALI",
              () => Navigator.pop(context),
            ),
          ],
        ),
      ]),
    )),
  ]),
);

Widget _sidebar(BuildContext context) {
  return Container(
    width: 155,
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(15, 25, 10, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 17),
          child: Text(
            "FOOD FLOW",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6B00),
            ),
          ),
        ),

        const SizedBox(height: 28),

        _sideBox(
          context,
          "MAIN MENU",
          ["Dashboard"],
        ),

        _sideBox(
          context,
          "MASTER DATA",
          ["Produk", "Outlet", "Penjual"],
        ),

        _sideBox(
          context,
          "TRANSAKSI",
          ["Distribusi", "Retur", "Setoran", "Bagi Hasil"],
        ),

        _sideBox(
          context,
          "LAPORAN",
          ["Laporan"],
        ),

        _sideBox(
          context,
          "AKUN",
          ["Profil", "LogOut"],
        ),
      ],
    ),
  );
}

void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Yakin ingin keluar?', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Anda akan keluar dari akun FoodFlow saat ini.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF7518), foregroundColor: Colors.white),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

Widget _sideBox(
  BuildContext context,
  String title,
  List<String> items,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.fromLTRB(10, 5, 5, 6),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7EF),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (title == "MASTER DATA") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MasterDataPage(),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ),

        ...items.map(
          (item) => InkWell(
            onTap: () {
              if (item == "Distribusi") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DistribusiPage(),
                  ),
                );
              } else if (item == "Retur") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReturPage(),
                  ),
                );
              } else if (item == "Setoran") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SetoranPage(),
                  ),
                );
              } else if (item == "Bagi Hasil") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BagiHasilPage(),
                  ),
                );
              } else if (item == "LogOut") {
                _showLogoutDialog(context);
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
              ),
              child: Text(
                "• $item",
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFFF6B00),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _owner() => Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 7,
  ),
  decoration: BoxDecoration(
    color: const Color(0xFFFF6B00),
    borderRadius: BorderRadius.circular(7),
  ),
  child: const Row(
    children: [
      Text(
        "Owner",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 5),
      Icon(
        Icons.arrow_drop_down,
        size: 20,
      ),
    ],
  ),
);

Widget _orangeButton(
  String t,
  VoidCallback f,
) => ElevatedButton(
  onPressed: f,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFF6B00),
    foregroundColor: Colors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: 17,
      vertical: 8,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
  ),
  child: Text(
    t,
    style: const TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.bold,
    ),
  ),
);

BoxDecoration _card() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      blurRadius: 7,
      color: Colors.black12,
    ),
  ],
);

Widget _header(List<String> l) => Container(
  height: 32,
  decoration: BoxDecoration(
    color: const Color(0xFFFF6B00),
    borderRadius: BorderRadius.circular(7),
  ),
  child: Row(
    children: l
        .map(
          (x) => Expanded(
            child: Center(
              child: Text(
                x,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
        .toList(),
  ),
);

Widget _cell(
  String t,
  double f,
) => Expanded(
  flex: f.round(),
  child: Center(
    child: Text(
      t,
      style: const TextStyle(
        fontSize: 9,
      ),
    ),
  ),
);

Widget _status(String text, double flex) {
  return Expanded(
    flex: flex.round(),
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: text == "Lunas"
              ? const Color(0xFFE1F7EC)
              : const Color(0xFFFFE4E4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: text == "Lunas"
                ? const Color(0xFF00A86B)
                : const Color(0xFFE53935),
          ),
        ),
      ),
    ),
  );
}

Widget _fieldLabel(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 6,
      bottom: 4,
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 13,
          color: const Color(0xFF243B64),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF243B64),
          ),
        ),
      ],
    ),
  );
}

Widget _field(String text) {
  return Container(
    height: 22,
    width: double.infinity,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F4F8),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xFF243B64),
      ),
    ),
  );
}

Widget _drop(
  String value,
  List<String> items,
  ValueChanged<String?>? onChanged,
) {
  return Container(
    height: 22,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F4F8),
      borderRadius: BorderRadius.circular(5),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 14,
          color: Color(0xFF243B64),
        ),
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF243B64),
        ),
        items: items.map(
          (item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          },
        ).toList(),
        onChanged: onChanged,
      ),
    ),
  );
}

Widget _blueButton(
  String text,
  VoidCallback onPressed,
) {
  return Expanded(
    child: SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2867D7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}