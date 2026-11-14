import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const Color billingOrange = Color(0xFFFF8A00);
const Color billingBackground = Color(0xFFF8F8F8);

class UserBillingPage extends StatefulWidget {
  UserBillingPage({
    super.key,
    this.initialCart = const [],
  });

  final List<Map<String, dynamic>> initialCart;
  @override
  State<UserBillingPage> createState() => _UserBillingPageState();
}

class _UserBillingPageState extends State<UserBillingPage> {
  final TextEditingController searchController =
  TextEditingController();
  final TextEditingController customerController =
  TextEditingController();
  final TextEditingController phoneController =
  TextEditingController();

  String paymentMethod = 'Cash';

  // Frontend sample data. Replace barcode values with actual product codes.
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Rice',
      'price': 60.0,
      'stock': 25,
      'barcode': '8901000000001',
      'icon': Icons.rice_bowl_outlined,
    },
    {
      'name': 'Sugar',
      'price': 45.0,
      'stock': 30,
      'barcode': '8901000000002',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'name': 'Cooking Oil',
      'price': 150.0,
      'stock': 15,
      'barcode': '8901000000003',
      'icon': Icons.water_drop_outlined,
    },
    {
      'name': 'Biscuits',
      'price': 30.0,
      'stock': 40,
      'barcode': '8901000000004',
      'icon': Icons.cookie_outlined,
    },
  ];

  final List<Map<String, dynamic>> cartItems = [];

  List<Map<String, dynamic>> get filteredProducts {
    final query = searchController.text.trim().toLowerCase();

    return products.where((product) {
      return product['name']
          .toString()
          .toLowerCase()
          .contains(query) ||
          product['barcode'].toString().contains(query);
    }).toList();
  }

  double get totalAmount {
    return cartItems.fold<double>(0, (total, item) {
      return total +
          (item['price'] as num).toDouble() *
              (item['quantity'] as int);
    });
  }

  int get totalQuantity {
    return cartItems.fold<int>(
      0,
          (total, item) => total + (item['quantity'] as int),
    );
  }

  void _addProduct(Map<String, dynamic> product) {
    if ((product['stock'] as int) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product is out of stock')),
      );
      return;
    }

    setState(() {
      final index = cartItems.indexWhere(
            (item) => item['barcode'] == product['barcode'],
      );

      if (index >= 0) {
        if (cartItems[index]['quantity'] < product['stock']) {
          cartItems[index]['quantity']++;
        }
      } else {
        cartItems.add({
          ...product,
          'quantity': 1,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to bill'),
        duration: const Duration(seconds: 1),
        backgroundColor: billingOrange,
      ),
    );
  }

  Future<void> _scanBarcode() async {
    final scannedCode = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const BarcodeScannerPage(),
      ),
    );

    if (!mounted || scannedCode == null) return;

    final index = products.indexWhere(
          (product) => product['barcode'].toString() == scannedCode,
    );

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product not found for barcode: $scannedCode'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _addProduct(products[index]);
  }

  void _changeQuantity(int index, int change) {
    setState(() {
      final item = cartItems[index];
      final newQuantity = (item['quantity'] as int) + change;

      if (newQuantity <= 0) {
        cartItems.removeAt(index);
      } else if (newQuantity <= (item['stock'] as int)) {
        item['quantity'] = newQuantity;
      }
    });
  }

  void _generateBill() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one product first')),
      );
      return;
    }

    if (customerController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter customer name and phone number'),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Bill Preview'),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'KDK BILLING',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Text('Customer: ${customerController.text.trim()}'),
                Text('Phone: ${phoneController.text.trim()}'),
                Text('Payment: $paymentMethod'),
                const SizedBox(height: 12),
                ...cartItems.map((item) {
                  final amount =
                      (item['price'] as num).toDouble() *
                          (item['quantity'] as int);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${item['name']} × ${item['quantity']}',
                          ),
                        ),
                        Text('₹${amount.toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₹${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: billingOrange,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Frontend preview only. Bill saving and printing '
                      'will be connected later.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() {
                cartItems.clear();
                customerController.clear();
                phoneController.clear();
                searchController.clear();
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Preview completed. Saving and printing '
                        'will be added later.',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: billingOrange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Finish Preview'),
          ),
        ],
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: billingOrange),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    customerController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: billingBackground,
      appBar: AppBar(
        title: const Text(
          'Store Billing',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: billingOrange),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Cart: $totalQuantity',
                style: const TextStyle(
                  color: billingOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wideScreen = constraints.maxWidth >= 850;

          final productSection = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _scanBarcode,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Scan Barcode'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: billingOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search product name or barcode...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: billingOrange,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(child: Text('No products found'))
                    : ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFFFF0DD),
                          child: Icon(
                            product['icon'] as IconData,
                            color: billingOrange,
                          ),
                        ),
                        title: Text(
                          product['name'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '₹${product['price']}  •  '
                              'Stock: ${product['stock']}',
                        ),
                        trailing: IconButton(
                          tooltip: 'Add to bill',
                          onPressed: () => _addProduct(product),
                          icon: const Icon(
                            Icons.add_circle,
                            color: billingOrange,
                            size: 30,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );

          final cartSection = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Bill',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 64,
                        color: billingOrange,
                      ),
                      SizedBox(height: 10),
                      Text('No products in bill yet'),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final amount =
                        (item['price'] as num).toDouble() *
                            (item['quantity'] as int);

                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '₹${item['price']} × '
                                        '${item['quantity']}',
                                  ),
                                  Text(
                                    '₹${amount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: billingOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _changeQuantity(index, -1),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${item['quantity']}'),
                            IconButton(
                              onPressed: () =>
                                  _changeQuantity(index, 1),
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: billingOrange,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  cartItems.removeAt(index);
                                });
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              _input(
                controller: customerController,
                label: 'Customer Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 10),
              _input(
                controller: phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: paymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                  DropdownMenuItem(value: 'UPI', child: Text('UPI')),
                  DropdownMenuItem(value: 'Card', child: Text('Card')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => paymentMethod = value);
                  }
                },
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: billingOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _generateBill,
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Generate Bill Preview'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: billingOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          );

          if (wideScreen) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 3, child: productSection),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: cartSection),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 320, child: productSection),
                const Divider(height: 28),
                Expanded(child: cartSection),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  bool alreadyScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product Barcode'),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              if (alreadyScanned || capture.barcodes.isEmpty) return;

              final code = capture.barcodes.first.rawValue;
              if (code == null || code.isEmpty) return;

              alreadyScanned = true;
              Navigator.pop(context, code);
            },
          ),
          Center(
            child: Container(
              width: 280,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: billingOrange,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const Positioned(
            bottom: 35,
            left: 20,
            right: 20,
            child: Text(
              'Place the product barcode inside the box',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(blurRadius: 5, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
