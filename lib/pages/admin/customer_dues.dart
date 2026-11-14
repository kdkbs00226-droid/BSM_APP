import 'package:flutter/material.dart';

class CustomerDuesPage extends StatefulWidget {
const CustomerDuesPage({super.key});

@override
State<CustomerDuesPage> createState() => _CustomerDuesPageState();
}

class _CustomerDuesPageState extends State<CustomerDuesPage> {
final List<Map<String, dynamic>> dues = [];

final TextEditingController searchController =
TextEditingController();

static const Color orange = Color(0xFFFF8A00);
static const Color pageBackground = Color(0xFFF8F8F8);

// EDIT CUSTOMER DUE
void _showEditDueDialog(int index) {
final due = dues[index];

final nameController =
TextEditingController(text: due['name'].toString());

final totalController =
TextEditingController(text: due['total'].toString());

final paidController =
TextEditingController(text: due['paid'].toString());

showDialog(
context: context,
builder: (dialogContext) {
return AlertDialog(
title: const Text('Edit Customer Due'),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: nameController,
decoration: const InputDecoration(
labelText: 'Customer Name',
prefixIcon: Icon(Icons.person_outline),
),
),
const SizedBox(height: 12),
TextField(
controller: totalController,
keyboardType: const TextInputType.numberWithOptions(
decimal: true,
),
decoration: const InputDecoration(
labelText: 'Total Amount',
prefixIcon: Icon(Icons.currency_rupee),
),
),
const SizedBox(height: 12),
TextField(
controller: paidController,
keyboardType: const TextInputType.numberWithOptions(
decimal: true,
),
decoration: const InputDecoration(
labelText: 'Paid Amount',
prefixIcon: Icon(Icons.payments_outlined),
),
),
],
),
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
final name = nameController.text.trim();
final total = double.tryParse(
totalController.text.trim(),
) ??
-1;
final paid = double.tryParse(
paidController.text.trim(),
) ??
-1;

if (name.isEmpty ||
total < 0 ||
paid < 0 ||
paid > total) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Enter valid customer and payment details',
),
backgroundColor: Colors.red,
),
);
return;
}

setState(() {
dues[index] = {
'name': name,
'total': total,
'paid': paid,
};
});

Navigator.pop(dialogContext);

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Customer due updated successfully'),
backgroundColor: orange,
),
);
},
style: ElevatedButton.styleFrom(
backgroundColor: orange,
foregroundColor: Colors.white,
),
child: const Text('Update Due'),
),
],
);
},
);
}

// DELETE CUSTOMER DUE
void _showDeleteConfirmation(int index) {
showDialog(
context: context,
builder: (dialogContext) {
return AlertDialog(
title: const Text('Delete Customer Due'),
content: Text(
'Are you sure you want to delete the due for '
'"${dues[index]['name']}"?',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
setState(() {
dues.removeAt(index);
});

Navigator.pop(dialogContext);

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Customer due deleted'),
backgroundColor: orange,
),
);
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

@override
Widget build(BuildContext context) {
final filteredDues = dues.where((due) {
return due['name']
    .toString()
    .toLowerCase()
    .contains(searchController.text.toLowerCase());
}).toList();

return Scaffold(
backgroundColor: pageBackground,

appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
title: const Text(
'Customer Dues',
style: TextStyle(
color: Color(0xFF333333),
fontWeight: FontWeight.bold,
),
),
iconTheme: const IconThemeData(color: orange),
),

body: Column(
children: [
// DUE LIST HEADING - NO ADD DUE BUTTON
Padding(
padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Due List',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Color(0xFF333333),
),
),
Text(
'${filteredDues.length} Customers',
style: const TextStyle(
color: orange,
fontWeight: FontWeight.w600,
),
),
],
),
),

// SEARCH BAR
Padding(
padding: const EdgeInsets.all(20),
child: TextField(
controller: searchController,
onChanged: (_) => setState(() {}),
decoration: InputDecoration(
hintText: 'Search customer dues...',
prefixIcon: const Icon(
Icons.search,
color: orange,
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
color: orange,
width: 2,
),
),
),
),
),

// CUSTOMER DUE LIST
Expanded(
child: filteredDues.isEmpty
? Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.account_balance_wallet_outlined,
size: 80,
color: orange,
),
const SizedBox(height: 20),
Text(
dues.isEmpty
? 'No customer dues'
    : 'No matching customers found',
style: const TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: Color(0xFF333333),
),
),
const SizedBox(height: 8),
const Text(
'Customer pending payments will appear here',
textAlign: TextAlign.center,
style: TextStyle(color: Colors.grey),
),
],
),
)
    : ListView.builder(
padding: const EdgeInsets.symmetric(
horizontal: 20,
),
itemCount: filteredDues.length,
itemBuilder: (context, index) {
final due = filteredDues[index];

final total =
(due['total'] as num).toDouble();

final paid =
(due['paid'] as num).toDouble();

final remaining = total - paid;

final originalIndex = dues.indexOf(due);

return Card(
color: Colors.white,
elevation: 1,
margin: const EdgeInsets.only(bottom: 12),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(14),
),
child: Padding(
padding: const EdgeInsets.all(14),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Row(
children: [
Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: const Color(0xFFFFF0DD),
borderRadius:
BorderRadius.circular(12),
),
child: const Icon(
Icons.person_outline,
color: orange,
),
),

const SizedBox(width: 12),

Expanded(
child: Text(
due['name'].toString(),
style: const TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
),

IconButton(
tooltip: 'Edit Due',
onPressed: () {
_showEditDueDialog(
originalIndex,
);
},
icon: const Icon(
Icons.edit_outlined,
color: orange,
),
),

IconButton(
tooltip: 'Delete Due',
onPressed: () {
_showDeleteConfirmation(
originalIndex,
);
},
icon: const Icon(
Icons.delete_outline,
color: Colors.red,
),
),
],
),

const Divider(height: 24),

_amountRow(
'Total Amount',
total,
Colors.black87,
),

const SizedBox(height: 10),

_amountRow(
'Paid Amount',
paid,
Colors.green,
),

const SizedBox(height: 10),

_amountRow(
'Remaining Due',
remaining,
remaining > 0
? Colors.red
    : Colors.green,
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

Widget _amountRow(
String label,
double amount,
Color color,
) {
return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
label,
style: const TextStyle(fontSize: 15),
),
Text(
'₹${amount.toStringAsFixed(2)}',
style: TextStyle(
fontSize: 15,
fontWeight: FontWeight.bold,
color: color,
),
),
],
);
}
}
