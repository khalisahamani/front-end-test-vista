import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import 'create_company_screen.dart';
import 'create_service_screen.dart';

class CompanyListScreen extends StatelessWidget {
  const CompanyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<CompanyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
        actions: [
          IconButton(
            tooltip: 'Add service',
            icon: const Icon(Icons.design_services),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CreateServiceScreen())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Company'),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CreateCompanyScreen())),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: _body(context, p),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, CompanyProvider p) {
    if (p.isLoading && p.companies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (p.error != null && p.companies.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(p.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: p.fetchCompanies,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (p.companies.isEmpty) {
      return const Center(child: Text('No companies yet'));
    }
    return RefreshIndicator(
      onRefresh: p.fetchCompanies,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: p.companies.length,
        itemBuilder: (_, i) {
          final c = p.companies[i];
          return Card(
            child: ExpansionTile(
              title: Text(c.name),
              subtitle: Text('Reg No: ${c.registrationNumber}'),
              children: c.services.isEmpty
                  ? [const ListTile(title: Text('No services'))]
                  : c.services
                      .map((s) => ListTile(
                            title: Text(s.name),
                            subtitle: Text(s.description),
                            trailing: Text('RM ${s.price.toStringAsFixed(2)}'),
                          ))
                      .toList(),
            ),
          );
        },
      ),
    );
  }
}