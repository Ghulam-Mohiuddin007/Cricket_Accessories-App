import 'package:cricket_accessories/customer/view/cart/data_list.dart';
import 'package:cricket_accessories/customer/view/product/detail.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> suggestions = [];

  void updateSuggestions(String input) {
    final query = input.toLowerCase();
    setState(() {
      suggestions = allProducts.where((product) {
        return product['name'].toLowerCase().contains(query) ||
            product['category'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Search Accessories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 6,
        shadowColor: Colors.green.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: searchController,
                onChanged: updateSuggestions,
                decoration: InputDecoration(
                  hintText: "Search accessories...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.green),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // Results
            Expanded(
              child: suggestions.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.green.withOpacity(0.6),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "No products found",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final product = suggestions[index];
                        final productImage = product['image'] ?? "";

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Detail(product: product),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [Colors.green.shade50, Colors.white],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                leading: Hero(
                                  tag: "product-${product['name']}",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: productImage.isNotEmpty
                                        ? Image.asset(
                                            productImage,
                                            width: 55,
                                            height: 55,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 55,
                                            height: 55,
                                            color: Colors.green.shade100,
                                            child: const Icon(
                                              Icons.sports_cricket,
                                              color: Colors.green,
                                            ),
                                          ),
                                  ),
                                ),
                                title: Text(
                                  product['name'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  product['category'],
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
