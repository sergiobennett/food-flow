import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'package:foodflow_api/database.dart';
import 'package:foodflow_api/auth_api.dart';
import 'package:foodflow_api/product_api.dart';

Future<void> main() async {
  // =====================================================
  // KONEKSI DATABASE
  // =====================================================

  final connection = await Database.connect();

  final result = await connection.query(
    'SELECT DATABASE() AS nama_database',
  );

  print('Database aktif: ${result.first['nama_database']}');

  // =====================================================
  // INISIALISASI API
  // =====================================================

  final auth = AuthApi(connection);
  final product = ProductApi(connection);

  final router = Router();

  // =====================================================
  // ROUTE UTAMA
  // =====================================================

  router.get('/', (Request request) {
    return Response.ok(
      jsonEncode({
        'success': true,
        'message': 'FoodFlow API berjalan!',
      }),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  });

  // =====================================================
  // REGISTER
  // =====================================================

  router.post('/register', (Request request) async {
    print('REGISTER ENDPOINT DIPANGGIL');
    return await auth.register(request);
  });

  // =====================================================
  // LOGIN
  // =====================================================

  router.post('/login', (Request request) async {
    print('LOGIN ENDPOINT DIPANGGIL');
    return await auth.login(request);
  });

  // =====================================================
  // MASTER PRODUK - GET SEMUA PRODUK
  // =====================================================

  router.get('/products', (Request request) async {
    print('GET PRODUCTS ENDPOINT DIPANGGIL');
    return await product.getAll(request);
  });

  // =====================================================
  // MASTER PRODUK - TAMBAH PRODUK
  // =====================================================

  router.post('/products', (Request request) async {
    print('CREATE PRODUCT ENDPOINT DIPANGGIL');
    return await product.create(request);
  });

  // =====================================================
  // MASTER PRODUK - EDIT PRODUK
  // =====================================================

  router.put('/products/<id>', (Request request, String id) async {
    print('UPDATE PRODUCT ENDPOINT DIPANGGIL: $id');
    return await product.update(request, id);
  });

  // =====================================================
  // MASTER PRODUK - HAPUS PRODUK
  // =====================================================

  router.delete('/products/<id>', (Request request, String id) async {
    print('DELETE PRODUCT ENDPOINT DIPANGGIL: $id');
    return await product.delete(request, id);
  });

  // =====================================================
  // JALANKAN SERVER
  // =====================================================

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(
    handler,
    '127.0.0.1',
    8080,
  );

  print('========================================');
  print('MySQL foodflow_db terhubung!');
  print(
    'FoodFlow API berjalan di '
    'http://${server.address.host}:${server.port}',
  );
  print('Endpoint Login    : POST /login');
  print('Endpoint Register : POST /register');
  print('Endpoint Produk   : GET /products');
  print('Endpoint Produk   : POST /products');
  print('Endpoint Produk   : PUT /products/<id>');
  print('Endpoint Produk   : DELETE /products/<id>');
  print('========================================');
}