import 'package:flutter/material.dart';
import 'package:cricket_accessories/detail.dart';
import 'data_list.dart'; // Contains all lists like bats, balls, etc.

class ProductsList extends StatefulWidget {
  final String category;

  const ProductsList({super.key, required this.category});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  // Better lookup using map
  final Map<String, List<Map<String, dynamic>>> categoryMap = {
    'bat': bats,
    'bats': bats,
    'ball': balls,
    'balls': balls,
    'shoe': shoes,
    'shoes': shoes,
    'bag': bags,
    'bags': bags,
    'glove': gloves,
    'gloves': gloves,
    'shirt': shirts,
    'shirts': shirts,
    'trouser': trousers,
    'trousers': trousers,
    'full kit': fullKits,
    'full kits': fullKits,
    'stump': stumps,
    'stumps': stumps,
    'protection gear': protectionGears,
    'protection gears': protectionGears,
  };

  List<Map<String, dynamic>> getSelectedProducts(String category) {
    final key = category.toLowerCase().trim();
    final products = categoryMap[key] ?? [];
    print("Selected category: '$key', Found: ${products.length} items");
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final selectedProducts = getSelectedProducts(widget.category);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.yellow),
      ),
      body: selectedProducts.isEmpty
          ? const Center(
              child: Text(
                "No products found",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                final product = selectedProducts[index];
                return GestureDetector(
                  onTap: () {
                    print("Navigating to Detail of: ${product['name']}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(product: product),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product['images'][0], // assumes images is List
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rs ${product['price']}",
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(5, (i) {
                                    final rating = product['rating'] ?? 0;
                                    return Icon(
                                      i < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 16,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white38,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
