import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:mysql1/mysql1.dart';

class ProductApi {
  final MySqlConnection connection;

  ProductApi(this.connection);

  // =====================================================
  // RESPONSE JSON
  // =====================================================

  Response _jsonResponse(
    int statusCode,
    Map<String, dynamic> data,
  ) {
    return Response(
      statusCode,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
  }

  // =====================================================
  // VALIDASI BODY REQUEST
  // =====================================================

  Future<Map<String, dynamic>?> _readBody(
    Request request,
  ) async {
    try {
      final String body = await request.readAsString();
      final dynamic decoded = jsonDecode(body);

      if (decoded is! Map) {
        return null;
      }

      return Map<String, dynamic>.from(decoded);
    } catch (_) {
      return null;
    }
  }

  // =====================================================
  // FORMAT DATA PRODUK
  // =====================================================

  Map<String, dynamic> _formatProduct(ResultRow row) {
    final dynamic rawHarga = row['harga'];

    return {
      'id': row['id'],
      'kode': row['kode'],
      'nama': row['nama'],
      'kategori': row['kategori'],
      'harga': double.tryParse(rawHarga.toString()) ?? 0,
      'status': row['status'],
      'created_at': row['created_at']?.toString(),
      'updated_at': row['updated_at']?.toString(),
    };
  }

  // =====================================================
  // GET: SEMUA PRODUK
  // GET /products
  // =====================================================

  Future<Response> getAll(Request request) async {
    try {
      final Results results = await connection.query(
        '''
        SELECT
          id,
          kode,
          nama,
          kategori,
          harga,
          status,
          created_at,
          updated_at
        FROM products
        ORDER BY id DESC
        ''',
      );

      final List<Map<String, dynamic>> products = results
          .map<Map<String, dynamic>>(_formatProduct)
          .toList();

      return _jsonResponse(200, {
        'success': true,
        'message': 'Data produk berhasil diambil.',
        'data': products,
      });
    } catch (e) {
      print('ERROR GET PRODUCTS: $e');

      return _jsonResponse(500, {
        'success': false,
        'message': 'Gagal mengambil data produk dari database.',
      });
    }
  }

  // =====================================================
  // POST: TAMBAH PRODUK
  // POST /products
  // =====================================================

  Future<Response> create(Request request) async {
    final Map<String, dynamic>? body = await _readBody(request);

    if (body == null) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Format JSON tidak valid.',
      });
    }

    final String kode = (body['kode'] ?? '').toString().trim();
    final String nama = (body['nama'] ?? '').toString().trim();
    final String kategori =
        (body['kategori'] ?? 'Makanan').toString().trim();
    final String status = (body['status'] ?? 'Aktif').toString().trim();

    final double? harga = double.tryParse(
      (body['harga'] ?? '').toString(),
    );

    if (kode.isEmpty || nama.isEmpty) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Kode dan nama produk wajib diisi.',
      });
    }

    if (harga == null || !harga.isFinite || harga < 0) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Harga produk harus berupa angka nol atau lebih.',
      });
    }

    if (!['Makanan', 'Minuman'].contains(kategori)) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Kategori harus Makanan atau Minuman.',
      });
    }

    if (!['Aktif', 'Nonaktif'].contains(status)) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Status harus Aktif atau Nonaktif.',
      });
    }

    try {
      await connection.query(
        '''
        INSERT INTO products
          (kode, nama, kategori, harga, status)
        VALUES (?, ?, ?, ?, ?)
        ''',
        [kode, nama, kategori, harga, status],
      );

      return _jsonResponse(201, {
        'success': true,
        'message': 'Produk berhasil ditambahkan.',
      });
    } catch (e) {
      print('ERROR CREATE PRODUCT: $e');

      final String error = e.toString().toLowerCase();

      if (error.contains('duplicate') ||
          error.contains('1062')) {
        return _jsonResponse(409, {
          'success': false,
          'message': 'Kode produk sudah digunakan.',
        });
      }

      return _jsonResponse(500, {
        'success': false,
        'message': 'Gagal menyimpan produk ke database.',
      });
    }
  }

  // =====================================================
  // PUT: EDIT PRODUK
  // PUT /products/<id>
  // =====================================================

  Future<Response> update(
    Request request,
    String id,
  ) async {
    final int? productId = int.tryParse(id);

    if (productId == null || productId <= 0) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'ID produk tidak valid.',
      });
    }

    final Map<String, dynamic>? body = await _readBody(request);

    if (body == null) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Format JSON tidak valid.',
      });
    }

    final String kode = (body['kode'] ?? '').toString().trim();
    final String nama = (body['nama'] ?? '').toString().trim();
    final String kategori =
        (body['kategori'] ?? '').toString().trim();
    final String status = (body['status'] ?? '').toString().trim();

    final double? harga = double.tryParse(
      (body['harga'] ?? '').toString(),
    );

    if (kode.isEmpty || nama.isEmpty) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Kode dan nama produk wajib diisi.',
      });
    }

    if (harga == null || !harga.isFinite || harga < 0) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Harga produk tidak valid.',
      });
    }

    if (!['Makanan', 'Minuman'].contains(kategori)) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Kategori produk tidak valid.',
      });
    }

    if (!['Aktif', 'Nonaktif'].contains(status)) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'Status produk tidak valid.',
      });
    }

    try {
      final Results result = await connection.query(
        '''
        UPDATE products
        SET
          kode = ?,
          nama = ?,
          kategori = ?,
          harga = ?,
          status = ?
        WHERE id = ?
        ''',
        [kode, nama, kategori, harga, status, productId],
      );

      if (result.affectedRows == 0) {
        final Results existing = await connection.query(
          'SELECT id FROM products WHERE id = ?',
          [productId],
        );

        if (existing.isEmpty) {
          return _jsonResponse(404, {
            'success': false,
            'message': 'Produk tidak ditemukan.',
          });
        }
      }

      return _jsonResponse(200, {
        'success': true,
        'message': 'Produk berhasil diperbarui.',
      });
    } catch (e) {
      print('ERROR UPDATE PRODUCT: $e');

      final String error = e.toString().toLowerCase();

      if (error.contains('duplicate') ||
          error.contains('1062')) {
        return _jsonResponse(409, {
          'success': false,
          'message': 'Kode produk sudah digunakan produk lain.',
        });
      }

      return _jsonResponse(500, {
        'success': false,
        'message': 'Gagal memperbarui produk.',
      });
    }
  }

  // =====================================================
  // DELETE: HAPUS PRODUK
  // DELETE /products/<id>
  // =====================================================

  Future<Response> delete(
    Request request,
    String id,
  ) async {
    final int? productId = int.tryParse(id);

    if (productId == null || productId <= 0) {
      return _jsonResponse(400, {
        'success': false,
        'message': 'ID produk tidak valid.',
      });
    }

    try {
      final Results result = await connection.query(
        'DELETE FROM products WHERE id = ?',
        [productId],
      );

      if (result.affectedRows == 0) {
        return _jsonResponse(404, {
          'success': false,
          'message': 'Produk tidak ditemukan.',
        });
      }

      return _jsonResponse(200, {
        'success': true,
        'message': 'Produk berhasil dihapus.',
      });
    } catch (e) {
      print('ERROR DELETE PRODUCT: $e');

      return _jsonResponse(500, {
        'success': false,
        'message': 'Gagal menghapus produk.',
      });
    }
  }
}