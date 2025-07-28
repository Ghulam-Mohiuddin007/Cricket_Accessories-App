import 'package:flutter/material.dart';
import 'buy.dart';

// Global cart list
List<Map<String, dynamic>> cartItems = [];

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void editItem(int index) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Edit feature coming soon")));
  }

  double getTotalPrice() {
    return cartItems.fold(0.0, (sum, item) => sum + (item['price'] ?? 0.0));
  }

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BuyScreen(cartItems: List<Map<String, dynamic>>.from(cartItems)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Cart", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Cart is empty",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading:
                              item['images'] != null &&
                                  item['images'].isNotEmpty
                              ? Image.asset(
                                  item['images'][0],
                                  width: 60,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image, size: 60),
                          title: Text(item['name'] ?? 'No Name'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title'] ?? 'No Title'),
                              Text("Price: \$${item['price']}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => editItem(index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          /// Bottom Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Items: ${cartItems.length}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "Total: \$${getTotalPrice().toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, color: Colors.yellow),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Proceed to Checkout",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
