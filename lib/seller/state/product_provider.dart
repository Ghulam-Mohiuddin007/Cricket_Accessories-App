import 'package:cricket_accessories/seller/model/product.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateStock(String id, int newStock) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index] = Product(
        id: _products[index].id,
        name: _products[index].name,
        price: _products[index].price,
        stock: newStock,
        description: _products[index].description,
        category: _products[index].category,
        imagePath: _products[index].imagePath,
      );
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
