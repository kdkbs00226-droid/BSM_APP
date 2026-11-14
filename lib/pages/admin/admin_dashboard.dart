import 'package:flutter/material.dart';

import 'products.dart';
import 'inventory.dart';
import 'customers.dart';
import 'staff.dart';
import 'suppliers.dart';
import 'low_stock.dart';
import 'reports.dart';
import 'sales_analytics.dart';
import 'customer_dues.dart';
import 'settings.dart';
import 'notifications.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isDarkMode = false;

  int selectedMenu = 0;

  final List<String> menuItems = [
    'Dashboard',
    'Sales Analytics',
    'Product Management',
    'Inventory',
    'Staff Management',
    'Reports',
    'Low Stock Alerts',
    'Suppliers',
    'Customers',
    'Customer Dues',
    'Settings',
  ];

  final List<IconData> menuIcons = [
    Icons.dashboard_outlined,
    Icons.bar_chart_outlined,
    Icons.inventory_2_outlined,
    Icons.warehouse_outlined,
    Icons.people_outline,
    Icons.assessment_outlined,
    Icons.warning_amber_outlined,
    Icons.local_shipping_outlined,
    Icons.person_add_alt_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
    isDarkMode
        ? const Color(0xFF1A1A1A)
        : const Color(0xFFF7F7F7);

    final sidebarColor =
    isDarkMode
        ? const Color(0xFF121212)
        : Colors.white;

    final cardColor =
    isDarkMode
        ? const Color(0xFF242424)
        : Colors.white;

    final textColor =
    isDarkMode
        ? Colors.white
        : const Color(0xFF252525);

    final secondaryText =
    isDarkMode
        ? Colors.white70
        : const Color(0xFF777777);

    return Scaffold(
      backgroundColor: backgroundColor,

      body: Row(
        children: [

          // =========================================================
          // SIDEBAR
          // =========================================================

          Container(
            width: 250,
            color: sidebarColor,

            child: Column(
              children: [

                const SizedBox(height: 20),

                // ===================================================
                // KDK BILLING LOGO
                // ===================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),

                  child: SizedBox(
                    height: 85,
                    width: double.infinity,

                    child: Image.asset(
                      'assets/images/kdk_billing_logo.jpeg' ,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ===================================================
                // MENU
                // ===================================================

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),

                    itemCount: menuItems.length,

                    itemBuilder: (context, index) {

                      final isSelected =
                          selectedMenu == index;

                      return GestureDetector(
                        onTap: () {

                          setState(() {
                            selectedMenu = index;
                          });

                          // Product Management
                          if (index == 2) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const ProductsPage(),
                              ),
                            );
                          }

                          // Sales Analytics
                          else if (index == 1) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SalesAnalyticsPage(),
                              ),
                            );
                          }

                          // Inventory
                          else if (index == 3) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const InventoryPage(),
                              ),
                            );
                          }

                          // Staff Management
                          else if (index == 4) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const StaffPage(),
                              ),
                            );
                          }

                          // Reports
                          else if (index == 5) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const ReportsPage(),
                              ),
                            );
                          }

                          // Low Stock
                          else if (index == 6) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const LowStockPage(),
                              ),
                            );
                          }

                          // Suppliers
                          else if (index == 7) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SuppliersPage(),
                              ),
                            );
                          }

                          // Customers
                          else if (index == 8) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const CustomersPage(),
                              ),
                            );
                          }

                          // Customer Dues
                          else if (index == 9) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const CustomerDuesPage(),
                              ),
                            );
                          }

                          // Settings
                          else if (index == 10) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SettingsPage(),
                              ),
                            );
                          }
                        },

                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 7,
                          ),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),

                          decoration: BoxDecoration(
                            color:
                            isSelected
                                ? const Color(0xFFFF8A00)
                                : Colors.transparent,

                            borderRadius:
                            BorderRadius.circular(10),
                          ),

                          child: Row(
                            children: [

                              Icon(
                                menuIcons[index],

                                color:
                                isSelected
                                    ? Colors.white
                                    : secondaryText,

                                size: 22,
                              ),

                              const SizedBox(width: 15),

                              Text(
                                menuItems[index],

                                style: TextStyle(
                                  color:
                                  isSelected
                                      ? Colors.white
                                      : textColor,

                                  fontSize: 14,

                                  fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ===================================================
                // ADMIN CARD
                // ===================================================

                Container(
                  margin: const EdgeInsets.all(15),

                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color:
                    isDarkMode
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFFFF3E3),

                    borderRadius:
                    BorderRadius.circular(14),

                    border: Border.all(
                      color: const Color(0xFFFFD5A6),
                    ),
                  ),

                  child: Row(
                    children: [

                      const CircleAvatar(
                        radius: 20,

                        backgroundColor:
                        Color(0xFFFF8A00),

                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              'Admin',

                              style: TextStyle(
                                color: textColor,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            Text(
                              'Administrator',

                              style: TextStyle(
                                color: secondaryText,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // =========================================================
          // MAIN AREA
          // =========================================================

          Expanded(
            child: Column(
              children: [

                // ===================================================
                // TOP BAR
                // ===================================================

                Container(
                  height: 85,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                  ),

                  color: cardColor,

                  child: Row(
                    children: [

                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            'Dashboard',

                            style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Welcome back, Admin',

                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // =================================================
                      // SEARCH
                      // =================================================

                      Container(
                        width: 250,
                        height: 45,

                        decoration: BoxDecoration(
                          color:
                          isDarkMode
                              ? const Color(0xFF303030)
                              : const Color(0xFFF5F5F5),

                          borderRadius:
                          BorderRadius.circular(12),
                        ),

                        child: TextField(
                          style: TextStyle(
                            color: textColor,
                          ),

                          decoration: InputDecoration(
                            hintText:
                            'Search anything...',

                            hintStyle: TextStyle(
                              color: secondaryText,
                            ),

                            prefixIcon: Icon(
                              Icons.search,
                              color: secondaryText,
                            ),

                            border:
                            InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // =================================================
                      // DARK / LIGHT MODE
                      // =================================================

                      Container(
                        height: 45,

                        decoration: BoxDecoration(
                          color:
                          isDarkMode
                              ? const Color(0xFF303030)
                              : const Color(0xFFFFF3E3),

                          borderRadius:
                          BorderRadius.circular(12),
                        ),

                        child: TextButton.icon(
                          onPressed: () {

                            setState(() {
                              isDarkMode =
                              !isDarkMode;
                            });
                          },

                          icon: Icon(
                            isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,

                            color:
                            const Color(
                              0xFFFF8A00,
                            ),
                          ),

                          label: Text(
                            isDarkMode
                                ? 'Light Mode'
                                : 'Dark Mode',

                            style:
                            const TextStyle(
                              color:
                              Color(0xFFFF8A00),
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // =================================================
                      // NOTIFICATION
                      // =================================================

                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                        ),

                        onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const NotificationsPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 20),

                      const CircleAvatar(
                        radius: 21,

                        backgroundColor:
                        Color(0xFFFFE0B2),

                        child: Icon(
                          Icons.person,
                          color: Color(0xFFFF8A00),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            'Admin',

                            style: TextStyle(
                              color: textColor,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          Text(
                            'Administrator',

                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ===================================================
                // DASHBOARD CONTENT
                // ===================================================

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),

                    child: Column(
                      children: [

                        // =================================================
                        // TOP 4 CARDS
                        // =================================================

                        Row(
                          children: [

                            Expanded(
                              child: _summaryCard(
                                title: 'Total Sales',
                                value: '₹ 0',
                                icon:
                                Icons.trending_up,
                                iconColor:
                                const Color(
                                  0xFFFF8A00,
                                ),
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: _summaryCard(
                                title: 'Total Profit',
                                value: '₹ 0',
                                icon:
                                Icons
                                    .account_balance_wallet_outlined,
                                iconColor:
                                const Color(
                                  0xFFFF8A00,
                                ),
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: _summaryCard(
                                title: 'Total Expenses',
                                value: '₹ 0',
                                icon:
                                Icons
                                    .money_off_outlined,
                                iconColor:
                                const Color(
                                  0xFFFF8A00,
                                ),
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),

                            const SizedBox(width: 18),

                            Expanded(
                              child: _summaryCard(
                                title: 'Total Dues',
                                value: '₹ 0',
                                icon:
                                Icons.person_outline,
                                iconColor:
                                const Color(
                                  0xFFFF8A00,
                                ),
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // =================================================
                        // SALES ANALYTICS + TOP SELLING
                        // =================================================

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Expanded(
                              flex: 3,

                              child:
                              _emptySalesAnalytics(
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              flex: 2,

                              child:
                              _emptyTopProducts(
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // =================================================
                        // RECENT BILLS + LOW STOCK
                        // =================================================

                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Expanded(
                              flex: 3,

                              child:
                              _emptyRecentBills(
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              flex: 2,

                              child:
                              _emptyLowStock(
                                cardColor:
                                cardColor,
                                textColor:
                                textColor,
                                secondaryText:
                                secondaryText,
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
        ],
      ),
    );
  }

  // ===============================================================
  // SUMMARY CARD
  // ===============================================================

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color cardColor,
    required Color textColor,
    required Color secondaryText,
  }) {
    return Container(
      height: 170,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color:
          isDarkMode
              ? Colors.white12
              : const Color(0xFFE8E8E8),
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Expanded(
                child: Text(
                  title,

                  style: TextStyle(
                    color: secondaryText,
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color:
                  const Color(0xFFFFF1DF),

                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            value,

            style: TextStyle(
              color: textColor,
              fontSize: 25,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const Spacer(),

          Text(
            'No data available yet',

            style: TextStyle(
              color: secondaryText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // SALES ANALYTICS
  // ===============================================================

  Widget _emptySalesAnalytics({
    required Color cardColor,
    required Color textColor,
    required Color secondaryText,
  }) {
    return Container(
      height: 330,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color:
          isDarkMode
              ? Colors.white12
              : const Color(0xFFE8E8E8),
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              const Icon(
                Icons.bar_chart_outlined,
                color: Color(0xFFFF8A00),
              ),

              const SizedBox(width: 10),

              Text(
                'Sales Analytics',

                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            '₹ 0',

            style: TextStyle(
              color: textColor,
              fontSize: 27,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          Text(
            'Total Sales',

            style: TextStyle(
              color: secondaryText,
              fontSize: 13,
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.show_chart,
                    size: 50,
                    color: secondaryText,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Sales data will appear here',

                    style: TextStyle(
                      color: secondaryText,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'after backend connection',

                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // TOP PRODUCTS
  // ===============================================================

  Widget _emptyTopProducts({
    required Color cardColor,
    required Color textColor,
    required Color secondaryText,
  }) {
    return Container(
      height: 330,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color:
          isDarkMode
              ? Colors.white12
              : const Color(0xFFE8E8E8),
        ),
      ),

      child: Column(
        children: [

          Row(
            children: [

              const Icon(
                Icons.star_outline,
                color: Color(0xFFFF8A00),
              ),

              const SizedBox(width: 10),

              Text(
                'Top Selling Products',

                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const Spacer(),

              const Text(
                'View All',

                style: TextStyle(
                  color: Color(0xFFFF8A00),
                  fontSize: 13,
                ),
              ),
            ],
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.inventory_2_outlined,
                    size: 48,
                    color: secondaryText,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'No product sales yet',

                    style: TextStyle(
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // RECENT BILLS
  // ===============================================================

  Widget _emptyRecentBills({
    required Color cardColor,
    required Color textColor,
    required Color secondaryText,
  }) {
    return Container(
      height: 260,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color:
          isDarkMode
              ? Colors.white12
              : const Color(0xFFE8E8E8),
        ),
      ),

      child: Column(
        children: [

          Row(
            children: [

              const Icon(
                Icons.receipt_long_outlined,
                color: Color(0xFFFF8A00),
              ),

              const SizedBox(width: 10),

              Text(
                'Recent Bills',

                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const Spacer(),

              const Text(
                'View All',

                style: TextStyle(
                  color: Color(0xFFFF8A00),
                  fontSize: 13,
                ),
              ),
            ],
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.receipt_outlined,
                    size: 48,
                    color: secondaryText,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'No bills created yet',

                    style: TextStyle(
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // LOW STOCK
  // ===============================================================

  Widget _emptyLowStock({
    required Color cardColor,
    required Color textColor,
    required Color secondaryText,
  }) {
    return Container(
      height: 260,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color:
          isDarkMode
              ? Colors.white12
              : const Color(0xFFE8E8E8),
        ),
      ),

      child: Column(
        children: [

          Row(
            children: [

              const Icon(
                Icons.warning_amber_outlined,
                color: Color(0xFFFF8A00),
              ),

              const SizedBox(width: 10),

              Text(
                'Low Stock Alerts',

                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const Spacer(),

              const Text(
                'View All',

                style: TextStyle(
                  color: Color(0xFFFF8A00),
                  fontSize: 13,
                ),
              ),
            ],
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.inventory_outlined,
                    size: 48,
                    color: secondaryText,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'No low stock alerts',

                    style: TextStyle(
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}