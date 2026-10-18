import 'package:dotenv/dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Database {
  static Future<MySqlConnection> connect() async {
    // Membaca konfigurasi dari file .env
    final env = DotEnv(includePlatformEnvironment: true)
      ..load(['.env']);

    final String host = env['DB_HOST'] ?? '127.0.0.1';
    final int port = int.tryParse(env['DB_PORT'] ?? '3306') ?? 3306;
    final String user = env['DB_USER'] ?? 'root';
    final String password = env['DB_PASSWORD'] ?? '';
    final String database = env['DB_NAME'] ?? 'foodflow_db';

    final settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: database,
    );

    final connection = await MySqlConnection.connect(settings);

    print('Berhasil terhubung ke MySQL!');
    print('Database aktif: $database');

    return connection;
  }
}