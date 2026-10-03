import 'package:flutter/material.dart';
import 'database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// 1. connect ke database
// await dipakai ketika memerlukan proses kode program yang perlu diselesaikan
    final databaseConnection =await Database.connect();

// 2. perform a sql query
// menyimpan proses query sql ke sebuah variabel bernama 'studentQuery'
//'mahasiswa' dapat diganti sesuai nama tabel yang dipakai
    final studentQuery = await 
                  databaseConnection.execute('SELECT * FROM actor');

// 3. processing the query result into a variable
for (final data in studentQuery.rows) {
  print(data.assoc());
}
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(child: Text('Database Connection Test')),
    ),
  ));
}