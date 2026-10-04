import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'master_data_page.dart';
import 'distribusi_page.dart';
import 'retur_page.dart';
import 'setoran_page.dart';
import 'laporan_page.dart';

class BagiHasilPage extends StatelessWidget {
  const BagiHasilPage({super.key});

  final List<Map<String,String>> data = const [
    {"kode":"BH001","tgl":"21 Sep 2026","outlet":"A","penjual":"Andi","penjualan":"500.000","bagi":"500.000","status":"Proses"},
    {"kode":"BH002","tgl":"21 Sep 2026","outlet":"B","penjual":"Budi","penjualan":"450.000","bagi":"200.000","status":"Selesai"},
    {"kode":"BH003","tgl":"22 Sep 2026","outlet":"C","penjual":"Citra","penjualan":"600.000","bagi":"90.000","status":"Selesai"},
    {"kode":"BH004","tgl":"22 Sep 2026","outlet":"D","penjual":"Bnnet","penjualan":"500.000","bagi":"100.000","status":"Proses"},
    {"kode":"BH005","tgl":"23 Sep 2026","outlet":"C","penjual":"Citra","penjualan":"600.000","bagi":"90.000","status":"Selesai"},
    {"kode":"BH006","tgl":"23 Sep 2026","outlet":"D","penjual":"Bnnet","penjualan":"500.000","bagi":"100.000","status":"Proses"},
    {"kode":"BH007","tgl":"24 Sep 2026","outlet":"A","penjual":"Andi","penjualan":"500.000","bagi":"500.000","status":"Proses"},
  ];

  @override
  Widget build(BuildContext context) {
    return _page(
      context,
      title:"BAGI HASIL",
      subtitle:"Kelola dan pantau pembagian hasil penjualan harian.",
      search:"Cari bagi hasil...",
      actionText:"Proses Bagi Hasil",
      onAction:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const DetailBagiHasilPage())),
      child:Container(
        padding:const EdgeInsets.all(10),
        decoration:_card(),
        child:Column(children:[
          _header(["KODE","TGL","OUTLET","PENJUAL","PENJUALAN","BAGI HASIL","STATUS","AKSI"]),
          ...data.map((e)=>Container(height:40,color:data.indexOf(e).isEven?Colors.white:const Color(0xFFF7F9FC),child:Row(children:[
            _pill(e["kode"]!,1.1),_cell(e["tgl"]!,1.3),_cell(e["outlet"]!,1),_cell(e["penjual"]!,1.3),_cell(e["penjualan"]!,1.5),_cell(e["bagi"]!,1.5),_bhStatus(e["status"]!,1.3),
            Expanded(flex:1,child:Center(child:TextButton.icon(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const DetailBagiHasilPage())),icon:const Icon(Icons.description_outlined,size:13),label:const Text("Detail",style:TextStyle(fontSize:8)),style:TextButton.styleFrom(foregroundColor:const Color(0xFFFF6B00),backgroundColor:const Color(0xFFFFF0E7)))))
          ])))
        ]),
      ),
    );
  }
}

class DetailBagiHasilPage extends StatefulWidget {
  const DetailBagiHasilPage({super.key});
  @override State<DetailBagiHasilPage> createState()=>_DetailBagiHasilPageState();
}

class _DetailBagiHasilPageState extends State<DetailBagiHasilPage>{
  String tanggal="21 Sep 2026",outlet="Outlet A",penjual="Andi";
  @override
  Widget build(BuildContext context){
    return _page(context,title:"DETAIL BAGI HASIL",subtitle:"Rincian pembagian hasil penjualan harian.",search:"Cari bagi hasil...",actionText:"Proses Bagi Hasil",onAction:(){},child:Container(
      padding:const EdgeInsets.all(10),
      decoration:BoxDecoration(color:const Color(0xFF031D2B),borderRadius:BorderRadius.circular(9),boxShadow:const[BoxShadow(blurRadius:7,color:Colors.black26)]),
      child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(height:25,width:double.infinity,padding:const EdgeInsets.symmetric(horizontal:12),alignment:Alignment.centerLeft,decoration:BoxDecoration(color:const Color(0xFFFF8738),borderRadius:BorderRadius.circular(14)),child:const Text("Proses Bagi Hasil",style:TextStyle(color:Colors.white,fontSize:10,fontWeight:FontWeight.bold))),
        _darkLabel("TANGGAL"),_darkDrop(tanggal,["21 Sep 2026","22 Sep 2026","23 Sep 2026"],(v)=>setState(()=>tanggal=v!)),
        _darkLabel("OUTLET"),_darkDrop(outlet,["Outlet A","Outlet B","Outlet C"],(v)=>setState(()=>outlet=v!)),
        _darkLabel("PENJUAL"),_darkDrop(penjual,["Andi","Budi","Citra","Bnnet"],(v)=>setState(()=>penjual=v!)),
        _darkLabel("TOTAL PENJUALAN"),_darkField(""),
        _darkLabel("TOTAL RETUR"),_darkField(""),
        _darkLabel("PENJUALAN BERSIH"),_darkField(""),
        _darkLabel("BAGI HASIL"),_darkField(""),
        const SizedBox(height:12),
        Align(alignment:Alignment.centerRight,child:Row(mainAxisSize:MainAxisSize.min,children:[_darkBtn("BATAL",()=>Navigator.pop(context),false),const SizedBox(width:8),_darkBtn("SIMPAN BAGI HASIL",()=>Navigator.pop(context),true)]))
      ]),
    ));
  }
}

Widget _page(BuildContext context,{required String title,required String subtitle,required String search,required String actionText,required VoidCallback onAction,required Widget child})=>Scaffold(
  backgroundColor:const Color(0xFFF1F5F9),
  body:Row(children:[_sidebar(context),Expanded(child:Padding(padding:const EdgeInsets.fromLTRB(30,28,40,20),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold,color:Color(0xFF1E293B))),const SizedBox(height:5),Text(subtitle,style:const TextStyle(fontSize:10,color:Color(0xFF64748B)))]),_owner()]),
    const SizedBox(height:40),
    Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Container(width:255,height:28,padding:const EdgeInsets.symmetric(horizontal:10),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(5)),child:Row(children:[const Icon(Icons.search,size:13,color:Color(0xFF64748B)),const SizedBox(width:5),Text(search,style:const TextStyle(fontSize:9,color:Color(0xFF94A3B8)))])),_orangeButton(actionText,onAction)]),
    const SizedBox(height:22),child,const Spacer(),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _orangeButton(
          "KEMBALI",
          () => Navigator.pop(context),
        ),
      ],
    )
  ])))]),
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
              padding: const EdgeInsets.symmetric(vertical: 3),
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
                padding: const EdgeInsets.symmetric(vertical: 3),
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

Widget _owner() {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 7,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFFF6B00),
      borderRadius: BorderRadius.circular(7),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
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
}
Widget _orangeButton(String t,VoidCallback f)=>ElevatedButton(onPressed:f,style:ElevatedButton.styleFrom(backgroundColor:const Color(0xFFFF6B00),foregroundColor:Colors.white,elevation:0,padding:const EdgeInsets.symmetric(horizontal:17,vertical:8),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(6))),child:Text(t,style:const TextStyle(fontSize:9,fontWeight:FontWeight.bold)));
BoxDecoration _card()=>BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(10),boxShadow:const[BoxShadow(blurRadius:7,color:Colors.black12)]);
Widget _header(List<String> x)=>Container(height:32,decoration:BoxDecoration(color:const Color(0xFFFF6B00),borderRadius:BorderRadius.circular(7)),child:Row(children:x.map((e)=>Expanded(child:Center(child:Text(e,style:const TextStyle(fontSize:8,color:Colors.white,fontWeight:FontWeight.bold))))).toList()));
Widget _cell(String t,double f)=>Expanded(flex:f.round(),child:Center(child:Text(t,style:const TextStyle(fontSize:8))));
Widget _pill(String t, double f) {
  return Expanded(
    flex: f.round(),
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE8EEF5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
Widget _bhStatus(String text, double flex) {
  return Expanded(
    flex: flex.round(),
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: text == "Selesai"
              ? const Color(0xFFE1F7EC)
              : const Color(0xFFFFE4E4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: text == "Selesai"
                ? const Color(0xFF00A86B)
                : const Color(0xFFE53935),
          ),
        ),
      ),
    ),
  );
}

Widget _darkLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 6,
      bottom: 4,
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _darkField(String hint) {
  return Container(
    height: 22,
    width: double.infinity,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFF08283A),
      border: Border.all(
        color: const Color(0xFF31566A),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      hint,
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xFF8FA8B8),
      ),
    ),
  );
}

Widget _darkDrop(
  String value,
  List<String> items,
  ValueChanged<String?>? onChanged,
) {
  return Container(
    height: 22,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFF08283A),
      border: Border.all(
        color: const Color(0xFF31566A),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 14,
          color: Colors.white,
        ),
        dropdownColor: const Color(0xFF08283A),
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
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

Widget _darkBtn(
  String text,
  VoidCallback onPressed,
  bool orange,
) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: orange
          ? const Color(0xFFFF6500)
          : const Color(0xFF08283A),
      foregroundColor: Colors.white,
      side: orange
          ? BorderSide.none
          : const BorderSide(
              color: Color(0xFF31566A),
            ),
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
  );
}