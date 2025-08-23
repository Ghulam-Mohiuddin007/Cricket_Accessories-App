import 'package:cricket_accessories/seller/auth/login.dart';
import 'package:cricket_accessories/seller/product/add_product.dart';
import 'package:cricket_accessories/seller/product/inventory.dart';
import 'package:cricket_accessories/seller/product/manage_product.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatelessWidget {
  final String sellerName;

  const SellerHomeScreen({super.key, required this.sellerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade700,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.store, color: Colors.green),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Hello, $sellerName 👋",
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login_seller()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade600, Colors.green.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  sellerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Dashboard Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildCard(
                    context,
                    icon: Icons.add_box,
                    title: "Add Product",
                    colors: [Colors.green.shade700, Colors.green.shade400],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddProductScreen(),
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    icon: Icons.inventory,
                    title: "Manage Products",
                    colors: [Colors.teal.shade600, Colors.teal.shade400],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ManageProductsScreen();
                          },
                        ),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    icon: Icons.shopping_cart,
                    title: "Orders",
                    colors: [Colors.orange.shade600, Colors.orange.shade400],
                    onTap: () {
                      Navigator.pushNamed(context, '/orders');
                    },
                  ),
                  _buildCard(
                    context,
                    icon: Icons.person,
                    title: "Profile",
                    colors: [Colors.blue.shade600, Colors.blue.shade400],
                    onTap: () {
                      Navigator.pushNamed(context, '/sellerProfile');
                    },
                  ),

                  // ✅ New Inventory Check Button
                  _buildCard(
                    context,
                    icon: Icons.check_circle_outline,
                    title: "Inventory Check",
                    colors: [Colors.purple.shade600, Colors.purple.shade400],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InventoryCheckScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: title,
              child: Icon(icon, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
