import 'package:flutter/material.dart';

class LowStockPage extends StatefulWidget {
  const LowStockPage({super.key});

  @override
  State<LowStockPage> createState() => _LowStockPageState();
}

class _LowStockPageState extends State<LowStockPage> {
  // Temporary frontend data
  // Backend connect pannumbodhu actual inventory data varum.
  final List<Map<String, dynamic>> products = [];

  final TextEditingController searchController =
  TextEditingController();

  // Low stock limit
  final int lowStockLimit = 10;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lowStockProducts = products.where((product) {
      final quantity = product['quantity'] ?? 0;

      return quantity <= lowStockLimit;
    }).where((product) {
      return product['name']
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Low Stock Alerts',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFFF8A00),
        ),
      ),

      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0DD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFFF8A00),
                  size: 32,
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stock Alert',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Products with stock quantity 10 or below will appear here.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {});
              },

              decoration: InputDecoration(
                hintText: 'Search low stock products...',

                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFFF8A00),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E5E5),
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E5E5),
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF8A00),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // LOW STOCK LIST
          Expanded(
            child: products.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Color(0xFFFF8A00),
                  ),

                  SizedBox(height: 20),

                  Text(
                    'No inventory data yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Low stock alerts will appear automatically when inventory data is available.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
                : lowStockProducts.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.green,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'All products are sufficiently stocked',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: lowStockProducts.length,

              itemBuilder: (context, index) {
                final product =
                lowStockProducts[index];

                final quantity =
                    product['quantity'] ?? 0;

                final bool isCritical =
                    quantity <= 5;

                return Card(
                  color: Colors.white,
                  elevation: 1,

                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),

                  child: ListTile(
                    leading: Container(
                      padding:
                      const EdgeInsets.all(
                        10,
                      ),

                      decoration: BoxDecoration(
                        color: isCritical
                            ? Colors.red.shade50
                            : const Color(
                          0xFFFFF0DD,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                      ),

                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: isCritical
                            ? Colors.red
                            : const Color(
                          0xFFFF8A00,
                        ),
                      ),
                    ),

                    title: Text(
                      product['name'].toString(),

                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    subtitle: Text(
                      'Current Stock: $quantity',
                    ),

                    trailing: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: isCritical
                            ? Colors.red.shade50
                            : const Color(
                          0xFFFFF0DD,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: Text(
                        isCritical
                            ? 'Critical'
                            : 'Low Stock',

                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,

                          color: isCritical
                              ? Colors.red
                              : const Color(
                            0xFFFF8A00,
                          ),
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
    );
  }
}