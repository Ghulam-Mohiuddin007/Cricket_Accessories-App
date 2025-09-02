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
        elevation: 4,
        title: const Text(
          '🏏 Cricket Accessories',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      drawer: _buildDrawer(context),
      body: pages[_selectedIndex],
    );
  }

  ClipRRect _buildDrawer(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        backgroundColor: AppColors.softBackground,
        child: Column(
          children: [
            // HEADER with animated avatar
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade800, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 38,
                        backgroundImage: NetworkImage(
                          'https://cdn.icon-icons.com/icons2/3708/PNG/512/girl_female_woman_person_people_avatar_icon_230018.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          widget.name,
                          style: AppTextStyles.heading.copyWith(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                        Text(
                          widget.email,
                          style: AppTextStyles.muted.copyWith(
                            color: Colors.white70,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // MENU OPTIONS (animated tiles)
            Expanded(
              child: ListView(
                children: [
                  _animatedTile(
                    context,
                    Icons.home,
                    "Home",
                    HomeScreen(
                      name: widget.name,
                      email: widget.email,
                      itemdetail: widget.itemdetail ?? [],
                    ),
                  ),
                  _animatedTile(
                    context,
                    Icons.search,
                    "Search",
                    const Search(),
                  ),
                  _animatedTile(
                    context,
                    Icons.shopping_cart,
                    "Cart",
                    const Cart(),
                  ),
                  _animatedTile(
                    context,
                    Icons.history,
                    "Order History",
                    OrderHistory(
                      orderHistory: orderHistory,
                      itemdetail: widget.itemdetail ?? [],
                    ),
                  ),
                  _animatedTile(
                    context,
                    Icons.person,
                    "Profile",
                    ProfileScreen(name: widget.name, email: widget.email),
                  ),
                ],
              ),
            ),

            // LOGOUT BUTTON with glass effect
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                ),
                child: _logoutButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Animated menu tile
  Widget _animatedTile(
    BuildContext context,
    IconData icon,
    String label,
    Widget targetScreen,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.9, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700, size: 26),
        title: Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => targetScreen),
          );
        },
      ),
    );
  }

  Widget _navigateTile(
    BuildContext context,
    IconData icon,
    String label,
    Widget targetScreen,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.green.shade700),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => targetScreen),
        );
      },
    );
  }

  Widget _logoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 6,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
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
                        MaterialPageRoute(builder: (_) => const Login()),
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
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text(
            'Logout',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildHome(List<Map<String, dynamic>> shuffledList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            _buildSearchBar(context),
            const SizedBox(height: 20),

            // Banner
            _buildBanner(),
            const SizedBox(height: 20),

            // Category Section
            _buildCategorySection(context),
            const SizedBox(height: 20),

            // Popular items
            _buildPopularItems(shuffledList),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Search()),
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade50, Colors.green.shade100],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: const [
            Icon(Icons.search, size: 25, color: Colors.green),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Search for cricket gear...",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: ImageSlideshow(
        height: 200,
        indicatorColor: Colors.green,
        indicatorBackgroundColor: Colors.white54,
        autoPlayInterval: 4000,
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
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select by Category',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Cat()),
              ),
              child: const Text(
                'View all',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Category Horizontal Scroll
        SizedBox(
          height: size.height * 0.24, // responsive height
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: name.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 400),
                tween: Tween<double>(begin: 0.95, end: 1.0),
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductsList(category: name[index]),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    width: size.width * 0.35, // responsive width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background Image with gradient overlay
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Image.asset(
                                img1[index],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Category Name (overlay text)
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Text(
                            name[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularItems(List<Map<String, dynamic>> shuffledList) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Items',
          style: TextStyle(
            color: Colors.green,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        // List of Products
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: size.height * 0.2, // Responsive height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.green.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Product Image with rounded corners
                    Flexible(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: AspectRatio(
                          aspectRatio: 1, // Keeps image square
                          child: Image.asset(
                            product['images'][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // Product Info
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            Text(
                              product['name'] ?? 'No name',
                              style: TextStyle(
                                fontSize: size.width * 0.042,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: size.height * 0.008),

                            // Price
                            Text(
                              product['price'] != null
                                  ? '₹${product['price']}'
                                  : 'Price: N/A',
                              style: TextStyle(
                                fontSize: size.width * 0.038,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                            const Spacer(),

                            // Bottom Row: Details + Add to Cart
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: size.height * 0.008,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    "View Details",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Floating Add to Cart Button
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.4),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
    );
  }
}
