import 'package:flutter/material.dart';

class CreateBillPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CreateBillPage({
    super.key,
    required this.cartItems,
  });

  @override
  State<CreateBillPage> createState() => _CreateBillPageState();
}

class _CreateBillPageState extends State<CreateBillPage> {
  final TextEditingController customerNameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  String paymentMethod = 'Cash';

  double get totalAmount {
    double total = 0;

    for (final item in widget.cartItems) {
      total +=
          (item['price'] as num).toDouble() *
              (item['quantity'] as int);
    }

    return total;
  }

  void _generateBill() {
    if (customerNameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter customer details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bill Generated'),
          content: const Text(
            'Customer bill has been generated successfully.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A00),
                foregroundColor: Colors.white,
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    customerNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Bill',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFFF8A00),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Details
            const Text(
              'Customer Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: customerNameController,
              decoration: InputDecoration(
                labelText: 'Customer Name',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: Color(0xFFFF8A00),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xFFFF8A00),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Products
            const Text(
              'Bill Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            ...widget.cartItems.map((item) {
              final price =
              (item['price'] as num).toDouble();

              final quantity =
              item['quantity'] as int;

              final itemTotal = price * quantity;

              return Card(
                color: Colors.white,
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0DD),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: Icon(
                      item['icon'],
                      color: const Color(0xFFFF8A00),
                    ),
                  ),
                  title: Text(
                    item['name'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '₹$price × $quantity',
                  ),
                  trailing: Text(
                    '₹$itemTotal',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Payment Method
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: paymentMethod,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'Cash',
                      child: Text('Cash'),
                    ),
                    DropdownMenuItem(
                      value: 'UPI',
                      child: Text('UPI'),
                    ),
                    DropdownMenuItem(
                      value: 'Card',
                      child: Text('Card'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        paymentMethod = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Total
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹$totalAmount',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8A00),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Generate Bill
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _generateBill,
                icon: const Icon(
                  Icons.receipt_long_outlined,
                ),
                label: const Text(
                  'Generate Bill',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFFFF8A00),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}