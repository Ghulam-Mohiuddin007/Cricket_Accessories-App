import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cricket_accessories/customer/view/product/search.dart';
import 'package:cricket_accessories/customer/view/cart/cart.dart';
import 'package:cricket_accessories/customer/view/profile/profile.dart';
import 'package:cricket_accessories/customer/view/product/history.dart';
import 'package:cricket_accessories/customer/view/product/detail.dart';
import 'package:cricket_accessories/customer/view/product/products_list.dart';
import 'package:cricket_accessories/customer/view/product/cat.dart';
import 'package:cricket_accessories/customer/view/cart/data_list.dart';
import 'package:cricket_accessories/core/colors.dart';
import 'package:cricket_accessories/core/text_styles.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:cricket_accessories/customer/view/auth/login.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String email;
  final Map<String, String>? initialOrder;
  final List<Map<String, dynamic>>? itemdetail;

  const HomeScreen({
    super.key,
    required this.name,
    required this.email,
    this.initialOrder,
    required this.itemdetail,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Map<String, String>> orderHistory = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialOrder != null) {
      orderHistory.add(widget.initialOrder!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final shuffledList = List<Map<String, dynamic>>.from(allProducts)
      ..shuffle(random);

    final List<Widget> pages = [
      _buildHome(shuffledList),
      const Search(),
      const Cart(),
      OrderHistory(
        orderHistory: orderHistory,
        itemdetail: widget.itemdetail ?? [],
      ),
      ProfileScreen(name: widget.name, email: widget.email),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cricket Accessories',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      drawer: Drawer(
        backgroundColor: AppColors.softBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryGreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://cdn.icon-icons.com/icons2/3708/PNG/512/girl_female_woman_person_people_avatar_icon_230018.png',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.name, style: AppTextStyles.body),
                  Text(widget.email, style: AppTextStyles.muted),
                ],
              ),
            ),
            _navigateTile(
              context,
              Icons.home,
              'Home',
              HomeScreen(
                name: widget.name,
                email: widget.email,
                itemdetail: widget.itemdetail ?? [],
              ),
            ),
            _navigateTile(context, Icons.search, 'Search', const Search()),
            _navigateTile(context, Icons.shopping_cart, 'Cart', const Cart()),
            _navigateTile(
              context,
              Icons.history,
              'Order History',
              OrderHistory(
                orderHistory: orderHistory,
                itemdetail: widget.itemdetail ?? [],
              ),
            ),
            _navigateTile(
              context,
              Icons.person,
              'Profile',
              ProfileScreen(name: widget.name, email: widget.email),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Login(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }

  Widget _navigateTile(
    BuildContext context,
    IconData icon,
    String label,
    Widget targetScreen,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.lightGreen),
      title: Text(label, style: AppTextStyles.body),
      onTap: () {
        Navigator.pop(context); // close the drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => targetScreen),
        );
      },
    );
  }

  Widget _buildHome(List<Map<String, dynamic>> shuffledList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Search()),
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Icon(Icons.search, size: 25, color: Colors.grey),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Search for cricket gear...",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ImageSlideshow(
                height: 200,
                indicatorColor: Colors.white,
                autoPlayInterval: 3000,
                isLoop: true,
                children: [
                  Image.network(
                    'https://cdn.intellemo.ai/int-stock/62a1aba679541829b33ea74a/62a1aba779541829b33ea74b-v154/cricket_gears_l.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://www.talentcricket.co.uk/images/custom/gmdeskbanner2025__size-1440-0.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://www.cricketshopitaly.com/cdn/shop/files/Cricket-Accessories_43e862f4-aa10-4e94-b5cc-3ed338130c8d.jpg?v=1732342416',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select by Category',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Cat()),
                  ),
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsList(category: name[index]),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.asset(
                              img1[index],
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            name[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Popular Items',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                final product = shuffledList[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Detail(product: product)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: AssetImage(product['images'][0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? 'No name',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product['price'] != null
                                      ? '₹${product['price']}'
                                      : 'Price: N/A',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
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
          ],
        ),
      ),
    );
  }
}
