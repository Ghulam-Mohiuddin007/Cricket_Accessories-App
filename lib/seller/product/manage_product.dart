// lib/seller/product/manage_products.dart
import 'package:cricket_accessories/seller/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/product_provider.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final products = provider.products;

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Products")),
      body: products.isEmpty
          ? const Center(child: Text("No products to manage"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, i) {
                final p = products[i];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.inventory),
                    title: Text(p.name),
                    subtitle: Text("Stock: ${p.stock}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showUpdateStockDialog(context, p, provider);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            provider.deleteProduct(p.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showUpdateStockDialog(
    BuildContext context,
    Product product,
    ProductProvider provider,
  ) {
    final controller = TextEditingController(text: product.stock.toString());
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Stock"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Stock"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () {
              final newStock = int.tryParse(controller.text) ?? product.stock;
              provider.updateStock(product.id, newStock);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
