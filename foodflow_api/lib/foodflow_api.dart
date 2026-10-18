import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'package:foodflow_api/database.dart';
import 'package:foodflow_api/auth_api.dart';

Future<void> main() async {
  final connection = await Database.connect();
  final auth = AuthApi(connection);

  final router = Router();

  // Endpoint untuk memeriksa API.
  router.get('/', (Request request) {
    return Response.ok(
      jsonEncode({
        'success': true,
        'message': 'FoodFlow API berjalan!',
      }),
      headers: {
        'content-type': 'application/json; charset=utf-8',
      },
    );
  });

  // Endpoint registrasi.
  router.post('/register', (Request request) async {
    print('REGISTER ENDPOINT DIPANGGIL');

    return await auth.register(request);
  });

  // Endpoint login.
  router.post('/login', (Request request) async {
    print('LOGIN ENDPOINT DIPANGGIL');

    return await auth.login(request);
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(
    handler,
    '0.0.0.0',
    8080,
  );

  print('MySQL foodflow_db terhubung!');
  print(
    'FoodFlow API berjalan di '
    'http://${server.address.host}:${server.port}',
  );
}