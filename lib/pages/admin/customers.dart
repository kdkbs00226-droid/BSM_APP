import 'package:flutter/material.dart';

class CustomersPage extends StatefulWidget {
const CustomersPage({super.key});

@override
State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
final List<Map<String, String>> customers = [];

final TextEditingController searchController =
TextEditingController();

static const Color orange = Color(0xFFFF8A00);
static const Color pageBackground = Color(0xFFF8F8F8);

void _deleteCustomer(int index) {
showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text('Delete Customer'),
content: Text(
'Delete ${customers[index]['name']}?',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
setState(() {
customers.removeAt(index);
});

Navigator.pop(dialogContext);

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Customer deleted successfully'),
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
),
);
}

@override
void dispose() {
searchController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
final query = searchController.text.toLowerCase();

final filteredCustomers = customers.where((customer) {
return (customer['name'] ?? '')
    .toLowerCase()
    .contains(query) ||
(customer['phone'] ?? '')
    .toLowerCase()
    .contains(query) ||
(customer['email'] ?? '')
    .toLowerCase()
    .contains(query);
}).toList();

return Scaffold(
backgroundColor: pageBackground,

appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
title: const Text(
'Customer Management',
style: TextStyle(
color: Color(0xFF333333),
fontWeight: FontWeight.bold,
),
),
iconTheme: const IconThemeData(color: orange),
),

body: Column(
children: [
// CUSTOMER LIST HEADING
Padding(
padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Customer List',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Color(0xFF333333),
),
),
Text(
'${filteredCustomers.length} Customers',
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
hintText: 'Search customers...',
prefixIcon: const Icon(
Icons.search,
color: orange,
),
filled: true,
fillColor: Colors.white,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: const BorderSide(
color: Color(0xFFE5E5E5),
),
),
enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: const BorderSide(
color: Color(0xFFE5E5E5),
),
),
focusedBorder: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: const BorderSide(
color: orange,
width: 2,
),
),
),
),
),

// CUSTOMER LIST
Expanded(
child: filteredCustomers.isEmpty
? Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.people_outline,
size: 70,
color: orange,
),
const SizedBox(height: 12),
Text(
customers.isEmpty
? 'No customers added yet'
    : 'No matching customers found',
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Color(0xFF555555),
),
),
const SizedBox(height: 6),
const Text(
'Customer details will appear here.',
style: TextStyle(color: Colors.grey),
),
],
),
)
    : ListView.builder(
padding: const EdgeInsets.symmetric(
horizontal: 20,
),
itemCount: filteredCustomers.length,
itemBuilder: (context, index) {
final customer = filteredCustomers[index];

return Card(
color: Colors.white,
elevation: 1,
margin: const EdgeInsets.only(bottom: 12),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
child: ListTile(
contentPadding: const EdgeInsets.all(12),

leading: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: const Color(0xFFFFF0DD),
borderRadius: BorderRadius.circular(12),
),
child: const Icon(
Icons.person_outline,
color: orange,
),
),

title: Text(
customer['name'] ?? '',
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),

subtitle: Text(
'${customer['phone'] ?? ''}\n'
'${customer['email'] ?? ''}',
),

isThreeLine: true,

trailing: IconButton(
tooltip: 'Delete Customer',
onPressed: () {
final originalIndex =
customers.indexOf(customer);

if (originalIndex != -1) {
_deleteCustomer(originalIndex);
}
},
icon: const Icon(
Icons.delete_outline,
color: Colors.red,
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
