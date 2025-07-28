import 'package:flutter/material.dart';
import 'package:cricket_accessories/cart.dart';
import 'package:cricket_accessories/buy.dart';

class Detail extends StatefulWidget {
  final Map<String, dynamic> product;
  const Detail({super.key, required this.product});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String? selectedVariant;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final variants = product['variants'] as List<dynamic>?;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(product['name'] ?? 'Product'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Product Image Carousel
              Container(
                height: height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product['images']?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(product['images'][index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Title
              Text(
                product['title'] ?? 'No title available',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: height * 0.02),

              /// Description
              Text(
                product['description'] ?? 'No description provided.',
                style: const TextStyle(fontSize: 16, color: Colors.yellow),
              ),

              SizedBox(height: height * 0.03),

              /// Price
              Text(
                "Price: \$${product['price']}",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),

              SizedBox(height: height * 0.03),

              /// Variant Selection
              if (variants != null && variants.isNotEmpty) ...[
                const Text(
                  "Select Variant:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Wrap(
                  spacing: 8.0,
                  children: variants.map((variant) {
                    return ChoiceChip(
                      label: Text(variant),
                      selected: selectedVariant == variant,
                      onSelected: (_) {
                        setState(() {
                          selectedVariant = variant;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],

              SizedBox(height: height * 0.02),

              /// Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (variants != null && selectedVariant == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a variant"),
                            ),
                          );
                          return;
                        }

                        final itemToAdd = {
                          ...product,
                          'selectedVariant': selectedVariant,
                        };

                        cartItems.add(itemToAdd);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to Cart")),
                        );
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (variants != null && selectedVariant == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a variant"),
                            ),
                          );
                          return;
                        }

                        final selectedProduct = {
                          ...product,
                          'selectedVariant': selectedVariant,
                        };

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BuyScreen(cartItems: [selectedProduct]),
                          ),
                        );
                      },
                      child: const Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
