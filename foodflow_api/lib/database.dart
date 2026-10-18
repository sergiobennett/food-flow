import 'package:mysql1/mysql1.dart';

class Database {
  static Future<MySqlConnection> connect() async {
    final settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: '12345',
      db: 'foodflow_db',
    );

    final connection = await MySqlConnection.connect(settings);

    print('Berhasil terhubung ke MySQL foodflow_db!');

    return connection;
  }
}