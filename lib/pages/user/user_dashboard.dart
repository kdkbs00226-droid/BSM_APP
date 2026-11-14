
import 'package:flutter/material.dart';
import 'user_billing.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final TextEditingController _searchController =
  TextEditingController();

  final List<Map<String, dynamic>> _products = [
    {
      'id': 'P001',
      'name': 'Rice',
      'price': 60.0,
      'stock': 25,
      'barcode': '8901000000011',
      'icon': Icons.rice_bowl_outlined,
    },
    {
      'id': 'P002',
      'name': 'Sugar',
      'price': 45.0,
      'stock': 30,
      'barcode': '8901000000028',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'id': 'P003',
      'name': 'Cooking Oil',
      'price': 150.0,
      'stock': 15,
      'barcode': '8901000000042',
      'icon': Icons.local_drink_outlined,
    },
    {
      'id': 'P004',
      'name': 'Biscuits',
      'price': 30.0,
      'stock': 40,
      'barcode': '8901000000066',
      'icon': Icons.cookie_outlined,
    },
  ];

  final List<Map<String, dynamic>> _cartItems = [];

  Color get _orange => const Color(0xFFFF8A00);

  List<Map<String, dynamic>> get _filteredProducts {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return _products;

    return _products.where((product) {
      return product['name'].toString().toLowerCase().contains(query) ||
          product['barcode'].toString().contains(query) ||
          product['id'].toString().toLowerCase().contains(query);
    }).toList();
  }

  int get _cartCount => _cartItems.fold<int>(
    0,
        (sum, item) => sum + (item['quantity'] as int),
  );

  double get _cartTotal => _cartItems.fold<double>(
    0,
        (sum, item) =>
    sum +
        (item['price'] as double) * (item['quantity'] as int),
  );

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _addToCart(Map<String, dynamic> product) {
    final existingIndex = _cartItems.indexWhere(
          (item) => item['id'] == product['id'],
    );

    final currentQuantity = existingIndex >= 0
        ? _cartItems[existingIndex]['quantity'] as int
        : 0;

    if (currentQuantity >= (product['stock'] as int)) {
      _showMessage('Available stock limit reached.');
      return;
    }

    setState(() {
      if (existingIndex >= 0) {
        _cartItems[existingIndex]['quantity'] =
            currentQuantity + 1;
      } else {
        _cartItems.add({
          'id': product['id'],
          'name': product['name'],
          'price': product['price'],
          'barcode': product['barcode'],
          'icon': product['icon'],
          'stock': product['stock'],
          'quantity': 1,
        });
      }
    });

    _showMessage('${product['name']} added to cart');
  }

  Future<void> _scanFromHome() async {
    final scannedCode = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const BarcodeScannerPage(),
      ),
    );

    if (!mounted || scannedCode == null) return;

    final code = scannedCode.trim();

    final matches = _products.where((product) {
      return product['barcode'].toString() == code ||
          product['id'].toString().toLowerCase() == code.toLowerCase();
    });

    if (matches.isEmpty) {
      _searchController.text = code;
      setState(() {});
      _showMessage(
        'Product not found. Check the product barcode.',
      );
      return;
    }

    _addToCart(matches.first);
  }

  Future<void> _openBilling() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserBillingPage(
          initialCart: _cartItems
              .map((item) => Map<String, dynamic>.from(item))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      elevation: 1,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0DD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            product['icon'] as IconData,
            color: _orange,
          ),
        ),
        title: Text(
          product['name'].toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '₹${product['price']}  •  Stock: ${product['stock']}',
          ),
        ),
        trailing: IconButton.filled(
          tooltip: 'Add to bill',
          style: IconButton.styleFrom(
            backgroundColor: _orange,
            foregroundColor: Colors.white,
          ),
          onPressed: () => _addToCart(product),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'BSM Store',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                tooltip: 'Open current bill',
                onPressed: _openBilling,
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: _orange,
                  size: 28,
                ),
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search product name or barcode...',
                  prefixIcon: Icon(Icons.search, color: _orange),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E5E5),
                    ),
                  ),
                ),
              ),
            ),

            // Scanner button is on the HOME PAGE.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  onPressed: _scanFromHome,
                  style: FilledButton.styleFrom(
                    backgroundColor: _orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text(
                    'Scan Barcode / QR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Available Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${filteredProducts.length} Products',
                    style: TextStyle(
                      color: _orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                child: Text('No products found'),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(
                    filteredProducts[index],
                  );
                },
              ),
            ),

            if (_cartCount > 0)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFE5E5E5)),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$_cartCount item(s)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '₹${_cartTotal.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: _orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: _openBilling,
                      style: FilledButton.styleFrom(
                        backgroundColor: _orange,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.receipt_long),
                      label: const Text('Current Bill'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
