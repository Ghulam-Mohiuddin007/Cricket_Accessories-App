import 'package:cricket_accessories/detail.dart';
import 'package:flutter/material.dart';
import 'data_list.dart';

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Search Accessories",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.yellow, // change to your desired color
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: searchController,
              onChanged: updateSuggestions,
              decoration: InputDecoration(
                hintText: "Search accessories...",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: suggestions.isEmpty
                  ? const Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    )
                  : ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final product = suggestions[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(product: product),
                              ),
                            );
                          },
                          title: Text(
                            product['name'],
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            product['category'],
                            style: TextStyle(color: Colors.white),
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
