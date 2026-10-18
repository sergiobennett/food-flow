import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

class AuthApi {
  final MySqlConnection connection;

  AuthApi(this.connection);

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<Response> register(Request request) async {
    print('=== FUNGSI REGISTER TERPANGGIL ===');
    try {
      final body = jsonDecode(await request.readAsString());

      final nama = (body['nama_lengkap'] ?? '').toString().trim();
      final email = (body['email'] ?? '').toString().trim().toLowerCase();
      final password = (body['password'] ?? '').toString();

      if (nama.isEmpty || email.isEmpty || password.isEmpty) {
        return _jsonResponse(400, {
          'success': false,
          'message': 'Nama, email, dan password wajib diisi.',
        });
      }

      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
        return _jsonResponse(400, {
          'success': false,
          'message': 'Format email tidak valid.',
        });
      }

      if (password.length < 8) {
        return _jsonResponse(400, {
          'success': false,
          'message': 'Password minimal 8 karakter.',
        });
      }

      final existing = await connection.query(
        'SELECT id FROM users WHERE email = ?',
        [email],
      );

      if (existing.isNotEmpty) {
        return _jsonResponse(409, {
          'success': false,
          'message': 'Email sudah terdaftar.',
        });
      }

      await connection.query(
        'INSERT INTO users '
        '(nama_lengkap, email, password_hash) VALUES (?, ?, ?)',
        [nama, email, _hashPassword(password)],
      );

      return _jsonResponse(201, {
        'success': true,
        'message': 'Registrasi berhasil.',
      });
    } catch (_) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Data registrasi tidak valid atau gagal diproses.',
      });
    }
  }

  Future<Response> login(Request request) async {
    print('ENDPOINT LOGIN TERPANGGIL');
    try {
      final body = jsonDecode(await request.readAsString());

      final email = (body['email'] ?? '').toString().trim().toLowerCase();
      final password = (body['password'] ?? '').toString();

      if (email.isEmpty || password.isEmpty) {
        return _jsonResponse(400, {
          'success': false,
          'message': 'Email dan password wajib diisi.',
        });
      }

      final results = await connection.query(
        'SELECT id, nama_lengkap, email, password_hash '
        'FROM users WHERE email = ?',
        [email],
      );

      if (results.isEmpty) {
        return _jsonResponse(401, {
          'success': false,
          'message': 'Email atau password salah.',
        });
      }

      final user = results.first;
      final storedHash = user['password_hash'].toString();

      if (_hashPassword(password) != storedHash) {
        return _jsonResponse(401, {
          'success': false,
          'message': 'Email atau password salah.',
        });
      }

      return _jsonResponse(200, {
        'success': true,
        'message': 'Login berhasil.',
        'user': {
          'id': user['id'],
          'nama_lengkap': user['nama_lengkap'],
          'email': user['email'],
        },
      });
    } catch (_) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Permintaan login tidak valid.',
      });
    }
  }

  Response _jsonResponse(int status, Map<String, dynamic> data) {
    return Response(
      status,
      body: jsonEncode(data),
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  }
}