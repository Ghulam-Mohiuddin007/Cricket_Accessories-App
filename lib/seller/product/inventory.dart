// lib/seller/product/inventory_check.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/product_provider.dart';

class InventoryCheckScreen extends StatelessWidget {
  const InventoryCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(title: const Text("Inventory Check")),
      body: products.isEmpty
          ? const Center(child: Text("No products in inventory"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, i) {
                final p = products[i];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: Text(p.name),
                    subtitle: Text("Price: \$${p.price} • Stock: ${p.stock}"),
                  ),
                );
              },
            ),
    );
  }
}
