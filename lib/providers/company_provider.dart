import 'package:flutter/material.dart';
import '../models/company.dart';
import '../services/api_service.dart';

class CompanyProvider extends ChangeNotifier {
  final _api = ApiService();

  List<Company> companies = [];
  bool isLoading = false;
  String? error;

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');

  Future<void> fetchCompanies() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      companies = await _api.getCompanies();
    } catch (e) {
      error = _clean(e);
    }
    isLoading = false;
    notifyListeners();
  }

  /// Returns null on success, or an error message.
  Future<String?> createCompany(String name, String regNo) async {
    try {
      await _api.createCompany(name, regNo);
      await fetchCompanies();
      return null;
    } catch (e) {
      return _clean(e);
    }
  }

  Future<String?> createService({
    required int companyId,
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      await _api.createService(
        companyId: companyId,
        name: name,
        description: description,
        price: price,
      );
      await fetchCompanies();
      return null;
    } catch (e) {
      return _clean(e);
    }
  }
}