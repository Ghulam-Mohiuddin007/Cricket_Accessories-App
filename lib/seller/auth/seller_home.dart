import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cricket_accessories/seller/auth/login.dart';
import 'package:cricket_accessories/seller/product/add_product.dart';
import 'package:cricket_accessories/seller/product/inventory.dart';
import 'package:cricket_accessories/seller/product/manage_product.dart';
import 'package:cricket_accessories/seller/profile/profile.dart';

class SellerHomeScreen extends StatelessWidget {
  final String sellerName;
  final String shopName;
  final String address;
  final String phone;
  final String email;
  final File? imageFile;

  const SellerHomeScreen({
    super.key,
    required this.sellerName,
    required this.shopName,
    required this.address,
    required this.phone,
    required this.email,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade700,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              backgroundColor: Colors.white,
              child: imageFile == null
                  ? const Icon(Icons.store, color: Colors.green)
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Hi, $sellerName 👋",
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
          // 🔥 Top Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade600, Colors.green.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : null,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: imageFile == null
                      ? const Icon(
                          Icons.storefront,
                          size: 40,
                          color: Colors.green,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shopName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 Dashboard Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: isTablet ? 3 : 2,
                childAspectRatio: isTablet ? 1.2 : 1,
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
                          builder: (context) => ManageProductsScreen(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            shopName: shopName,
                            address: address,
                            phone: phone,
                            email: email,
                            imageFile: imageFile,
                          ),
                        ),
                      );
                    },
                  ),
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

  // 🔥 Card Builder
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
      child: Ink(
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
