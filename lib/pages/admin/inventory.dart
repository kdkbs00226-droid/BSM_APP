import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController searchController =
  TextEditingController();

  // Backend connect pannura varaikum empty data
  final List<Map<String, dynamic>> inventory = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showUpdateStockDialog(int index) {
    final quantityController = TextEditingController(
      text: inventory[index]['quantity'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Stock'),

          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Stock Quantity',
              prefixIcon: Icon(Icons.inventory_2_outlined),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                final quantity =
                int.tryParse(quantityController.text.trim());

                if (quantity == null || quantity < 0) {
                  return;
                }

                setState(() {
                  inventory[index]['quantity'] = quantity;
                });

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
              ),

              child: const Text('Update Stock'),
            ),
          ],
        );
      },
    );
  }

  void _deleteInventoryItem(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Product'),

          content: const Text(
            'Are you sure you want to remove this product from inventory?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  inventory.removeAt(index);
                });

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),

              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredInventory = inventory.where((product) {
      return product['name']
          .toString()
          .toLowerCase()
          .contains(
        searchController.text.toLowerCase(),
      );
    }).toList();

    final int totalProducts = inventory.length;

    final int totalStock = inventory.fold(
      0,
          (sum, product) =>
      sum +
          ((product['quantity'] as num?)?.toInt() ?? 0),
    );

    final int lowStockProducts =
        inventory.where((product) {
          final quantity =
              (product['quantity'] as num?)?.toInt() ?? 0;

          return quantity <= 5;
        }).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Inventory',
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

          // SUMMARY CARDS
          Padding(
            padding: const EdgeInsets.all(20),

            child: Row(
              children: [

                Expanded(
                  child: _summaryCard(
                    title: 'Products',
                    value: totalProducts.toString(),
                    icon: Icons.inventory_2_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    title: 'Total Stock',
                    value: totalStock.toString(),
                    icon: Icons.layers_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    title: 'Low Stock',
                    value: lowStockProducts.toString(),
                    icon: Icons.warning_amber_outlined,
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
                hintText: 'Search inventory...',

                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFFF8A00),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(14),

                  borderSide: const BorderSide(
                    color: Color(0xFFE5E5E5),
                  ),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(14),

                  borderSide: const BorderSide(
                    color: Color(0xFFE5E5E5),
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(14),

                  borderSide: const BorderSide(
                    color: Color(0xFFFF8A00),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // INVENTORY LIST
          Expanded(
            child: inventory.isEmpty

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
                      fontWeight:
                      FontWeight.bold,
                      color:
                      Color(0xFF333333),
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Inventory will update automatically after backend connection',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

                : filteredInventory.isEmpty

                ? const Center(
              child: Text(
                'No matching products found',

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )

                : ListView.builder(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              itemCount:
              filteredInventory.length,

              itemBuilder:
                  (context, index) {

                final product =
                filteredInventory[index];

                final originalIndex =
                inventory.indexOf(product);

                final quantity =
                    (product['quantity']
                    as num?)
                        ?.toInt() ??
                        0;

                final isLowStock =
                    quantity <= 5;

                return Card(
                  color: Colors.white,
                  elevation: 1,

                  margin:
                  const EdgeInsets.only(
                    bottom: 12,
                  ),

                  child: ListTile(

                    leading: Container(
                      padding:
                      const EdgeInsets.all(
                        10,
                      ),

                      decoration:
                      BoxDecoration(
                        color:
                        const Color(
                          0xFFFFF0DD,
                        ),

                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                      ),

                      child: const Icon(
                        Icons
                            .inventory_2_outlined,

                        color:
                        Color(0xFFFF8A00),
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
                      'Available Stock: $quantity',
                    ),

                    trailing: Row(
                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        if (isLowStock)
                          const Icon(
                            Icons
                                .warning_amber_rounded,
                            color:
                            Colors.red,
                          ),

                        IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                            color:
                            Color(0xFFFF8A00),
                          ),

                          onPressed: () {
                            _showUpdateStockDialog(
                              originalIndex,
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),

                          onPressed: () {
                            _deleteInventoryItem(
                              originalIndex,
                            );
                          },
                        ),
                      ],
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

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFFFE2BD),
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: const Color(0xFFFF8A00),
          ),

          const SizedBox(height: 10),

          Text(
            title,

            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}