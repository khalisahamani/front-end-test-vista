import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/company.dart';

class ApiService {
  // Android emulator reaches your PC via 10.0.2.2; everything else uses localhost
  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  Future<List<Company>> getCompanies() async {
    final res = await http.get(Uri.parse('$baseUrl/companies'));
    _check(res);
    final data = jsonDecode(res.body) as List;
    return data.map((c) => Company.fromJson(c)).toList();
  }

  Future<void> createCompany(String name, String regNo) async {
    final res = await http.post(
      Uri.parse('$baseUrl/companies'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'registrationNumber': regNo}),
    );
    _check(res);
  }

  Future<void> createService({
    required int companyId,
    required String name,
    required String description,
    required double price,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/services'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'companyId': companyId,
        'name': name,
        'description': description,
        'price': price,
      }),
    );
    _check(res);
  }

  void _check(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) return;
    String msg = 'Request failed (${res.statusCode})';
    try {
      final body = jsonDecode(res.body);
      msg = body['message'] ?? body['error'] ?? msg;
    } catch (_) {}
    throw Exception(msg);
  }
}