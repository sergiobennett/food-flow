import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8080';

  // =====================================================
  // LOGIN
  // =====================================================

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _post('/login', {
      'email': email.trim().toLowerCase(),
      'password': password,
    });

    return _handleResponse(response);
  }

  // =====================================================
  // REGISTER
  // =====================================================

  static Future<Map<String, dynamic>> register({
    required String namaLengkap,
    required String email,
    required String password,
  }) async {
    final response = await _post('/register', {
      'nama_lengkap': namaLengkap.trim(),
      'email': email.trim().toLowerCase(),
      'password': password,
    });

    return _handleResponse(response);
  }

  // =====================================================
  // GET SEMUA PRODUK
  // =====================================================

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await _get('/products');
    final data = _handleResponse(response);

    final products = data['data'];

    if (products is! List) {
      throw Exception('Format data produk dari server tidak valid.');
    }

    return products.map<Map<String, dynamic>>((item) {
      return Map<String, dynamic>.from(item as Map);
    }).toList();
  }

  // =====================================================
  // TAMBAH PRODUK
  // =====================================================

  static Future<Map<String, dynamic>> createProduct({
    required String kode,
    required String nama,
    required String kategori,
    required String harga,
    required String status,
  }) async {
    final response = await _post('/products', {
      'kode': kode.trim(),
      'nama': nama.trim(),
      'kategori': kategori,
      'harga': harga.trim(),
      'status': status,
    });

    return _handleResponse(response);
  }

  // =====================================================
  // EDIT PRODUK
  // =====================================================

  static Future<Map<String, dynamic>> updateProduct({
    required int id,
    required String kode,
    required String nama,
    required String kategori,
    required String harga,
    required String status,
  }) async {
    final response = await _put('/products/$id', {
      'kode': kode.trim(),
      'nama': nama.trim(),
      'kategori': kategori,
      'harga': harga.trim(),
      'status': status,
    });

    return _handleResponse(response);
  }

  // =====================================================
  // HAPUS PRODUK
  // =====================================================

  static Future<Map<String, dynamic>> deleteProduct({
    required int id,
  }) async {
    final response = await _delete('/products/$id');

    return _handleResponse(response);
  }

  // =====================================================
  // HTTP REQUEST
  // =====================================================

  static Future<http.Response> _get(String endpoint) async {
    return _request(() {
      return http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Accept': 'application/json'},
      );
    });
  }

  static Future<http.Response> _post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    return _request(() {
      return http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
    });
  }

  static Future<http.Response> _put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    return _request(() {
      return http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
    });
  }

  static Future<http.Response> _delete(String endpoint) async {
    return _request(() {
      return http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Accept': 'application/json'},
      );
    });
  }

  static Future<http.Response> _request(
    Future<http.Response> Function() send,
  ) async {
    try {
      final response = await send().timeout(
        const Duration(seconds: 15),
      );

      print('API STATUS: ${response.statusCode}');
      print('API RESPONSE: ${response.body}');

      return response;
    } on TimeoutException {
      throw Exception(
        'Server terlalu lama merespons. Coba lagi.',
      );
    } on http.ClientException catch (e) {
      print('API CONNECTION ERROR: $e');

      throw Exception(
        'Gagal menghubungi server FoodFlow. Pastikan backend aktif.',
      );
    } on FormatException {
      throw Exception('Alamat endpoint backend tidak valid.');
    }
  }

  // =====================================================
  // HANDLE RESPONSE
  // =====================================================

  static Map<String, dynamic> _handleResponse(
    http.Response response,
  ) {
    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } on FormatException {
      print('RESPONS SERVER BUKAN JSON: ${response.body}');

      throw Exception(
        'Respons server tidak valid. Periksa backend FoodFlow.',
      );
    }

    if (decoded is! Map) {
      throw Exception('Format respons backend tidak sesuai.');
    }

    final data = Map<String, dynamic>.from(decoded);

    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        data['success'] == true) {
      return data;
    }

    throw Exception(
      data['message']?.toString() ??
          'Permintaan gagal dengan status ${response.statusCode}.',
    );
  }
}