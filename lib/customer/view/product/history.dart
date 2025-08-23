import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  final List<Map<String, String>> orderHistory; // customer/order fields
  final List<Map<String, dynamic>> itemdetail; // product info

  const OrderHistory({
    super.key,
    required this.orderHistory,
    required this.itemdetail,
  });

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order History",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,

        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: widget.orderHistory.isEmpty
            ? const Center(
                child: Text(
                  "No orders yet!",
                  style: TextStyle(color: Colors.greenAccent, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: widget.orderHistory.length,
                itemBuilder: (context, index) {
                  final order = widget.orderHistory[index];
                  final item = widget.itemdetail.length > index
                      ? widget.itemdetail[index]
                      : {}; // fallback if itemdetail is shorter

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Details
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item['images']?[0] ?? '', // use first image
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.broken_image,
                                        size: 80,
                                        color: Colors.white30,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'] ?? 'Product Name',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['title'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white60,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Price: ${item['price'] ?? ''}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          const Divider(color: Colors.white24),

                          const Text(
                            "Order Info",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          ...order.entries.map(
                            (entry) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${entry.key}: ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
