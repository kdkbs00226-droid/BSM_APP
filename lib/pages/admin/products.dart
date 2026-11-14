import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Map<String, dynamic>> products = [];

  final TextEditingController searchController =
  TextEditingController();

  // =========================
  // ADD PRODUCT
  // =========================
  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    prefixIcon: Icon(
                      Icons.inventory_2_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    prefixIcon: Icon(
                      Icons.numbers,
                    ),
                  ),
                ),
              ],
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
                if (nameController.text.trim().isEmpty ||
                    priceController.text.trim().isEmpty ||
                    quantityController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  products.add({
                    'name': nameController.text.trim(),
                    'price':
                    double.tryParse(
                      priceController.text.trim(),
                    ) ??
                        0,
                    'quantity':
                    int.tryParse(
                      quantityController.text.trim(),
                    ) ??
                        0,
                  });
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
              ),
              child: const Text('Add Product'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // EDIT PRODUCT
  // =========================
  void _showEditProductDialog(int index) {
    final product = products[index];

    final nameController = TextEditingController(
      text: product['name'].toString(),
    );

    final priceController = TextEditingController(
      text: product['price'].toString(),
    );

    final quantityController = TextEditingController(
      text: product['quantity'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    prefixIcon: Icon(
                      Icons.inventory_2_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    prefixIcon: Icon(
                      Icons.numbers,
                    ),
                  ),
                ),
              ],
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
                if (nameController.text.trim().isEmpty ||
                    priceController.text.trim().isEmpty ||
                    quantityController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  products[index] = {
                    'name': nameController.text.trim(),
                    'price':
                    double.tryParse(
                      priceController.text.trim(),
                    ) ??
                        0,
                    'quantity':
                    int.tryParse(
                      quantityController.text.trim(),
                    ) ??
                        0,
                  };
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
              ),
              child: const Text('Update Product'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // DELETE PRODUCT
  // =========================
  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this product?',
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
                  products.removeAt(index);
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================
  // BUILD
  // =========================
  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product['name']
          .toString()
          .toLowerCase()
          .contains(
        searchController.text.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Product Management',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFFF8A00),
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: Column(
        children: [
          // =========================
          // TOP TITLE + ADD BUTTON
          // =========================
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              5,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: _showAddProductDialog,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8A00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =========================
          // SEARCH BAR
          // =========================
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
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

          // =========================
          // PRODUCT LIST
          // =========================
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
                    'No products added yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Click "Add Product" to add your first product',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
                : filteredProducts.isEmpty
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              itemCount: filteredProducts.length,

              // IMPORTANT:
              // itemBuilder is required
              itemBuilder: (context, index) {
                final product =
                filteredProducts[index];

                final originalIndex =
                products.indexOf(product);

                return Card(
                  color: Colors.white,
                  elevation: 1,
                  margin: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.all(12),

                    // PRODUCT ICON
                    leading: Container(
                      padding:
                      const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                        const Color(0xFFFFF0DD),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color:
                        Color(0xFFFF8A00),
                      ),
                    ),

                    // PRODUCT NAME
                    title: Text(
                      product['name'].toString(),
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    // PRICE + STOCK
                    subtitle: Text(
                      'Price: ₹${product['price']}  •  Stock: ${product['quantity']}',
                    ),

                    // EDIT + DELETE
                    trailing: Row(
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                            color:
                            Color(0xFFFF8A00),
                          ),
                          onPressed: () {
                            _showEditProductDialog(
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
                            _deleteProduct(
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
}