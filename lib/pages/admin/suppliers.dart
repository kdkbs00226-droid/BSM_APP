import 'package:flutter/material.dart';

class SuppliersPage extends StatefulWidget {
const SuppliersPage({super.key});

@override
State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
final List<Map<String, dynamic>> suppliers = [];
final TextEditingController searchController =
TextEditingController();

static const Color orange = Color(0xFFFF8A00);
static const Color background = Color(0xFFF8F8F8);

// Format date and time
String _formatDateTime(DateTime dateTime) {
final day = dateTime.day.toString().padLeft(2, '0');
final month = dateTime.month.toString().padLeft(2, '0');
final year = dateTime.year;
final hour =
dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
final minute = dateTime.minute.toString().padLeft(2, '0');
final period = dateTime.hour >= 12 ? 'PM' : 'AM';

return '$day/$month/$year • $hour:$minute $period';
}

// ADD SUPPLIER
void _showAddSupplierDialog() {
final nameController = TextEditingController();
final phoneController = TextEditingController();
final addressController = TextEditingController();

showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text(
'Add Supplier',
style: TextStyle(fontWeight: FontWeight.bold),
),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: nameController,
decoration: const InputDecoration(
labelText: 'Supplier Name',
prefixIcon: Icon(Icons.person_outline),
),
),
const SizedBox(height: 12),
TextField(
controller: phoneController,
keyboardType: TextInputType.phone,
decoration: const InputDecoration(
labelText: 'Phone Number',
prefixIcon: Icon(Icons.phone_outlined),
),
),
const SizedBox(height: 12),
TextField(
controller: addressController,
maxLines: 2,
decoration: const InputDecoration(
labelText: 'Address',
prefixIcon: Icon(Icons.location_on_outlined),
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
if (nameController.text.trim().isEmpty ||
phoneController.text.trim().isEmpty ||
addressController.text.trim().isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Please fill all supplier details'),
),
);
return;
}

setState(() {
suppliers.add({
'name': nameController.text.trim(),
'phone': phoneController.text.trim(),
'address': addressController.text.trim(),
'addedAt': DateTime.now(),
'visits': <DateTime>[],
});
});

Navigator.pop(dialogContext);
nameController.dispose();
phoneController.dispose();
addressController.dispose();
},
style: ElevatedButton.styleFrom(
backgroundColor: orange,
foregroundColor: Colors.white,
),
child: const Text('Add Supplier'),
),
],
),
);
}

// EDIT SUPPLIER
void _showEditSupplierDialog(int index) {
final supplier = suppliers[index];
final nameController =
TextEditingController(text: supplier['name'].toString());
final phoneController =
TextEditingController(text: supplier['phone'].toString());
final addressController =
TextEditingController(text: supplier['address'].toString());

showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text(
'Edit Supplier',
style: TextStyle(fontWeight: FontWeight.bold),
),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: nameController,
decoration: const InputDecoration(
labelText: 'Supplier Name',
prefixIcon: Icon(Icons.person_outline),
),
),
const SizedBox(height: 12),
TextField(
controller: phoneController,
keyboardType: TextInputType.phone,
decoration: const InputDecoration(
labelText: 'Phone Number',
prefixIcon: Icon(Icons.phone_outlined),
),
),
const SizedBox(height: 12),
TextField(
controller: addressController,
maxLines: 2,
decoration: const InputDecoration(
labelText: 'Address',
prefixIcon: Icon(Icons.location_on_outlined),
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
if (nameController.text.trim().isEmpty ||
phoneController.text.trim().isEmpty ||
addressController.text.trim().isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Please fill all supplier details'),
),
);
return;
}

setState(() {
// Keep original visit history while editing details.
supplier['name'] = nameController.text.trim();
supplier['phone'] = phoneController.text.trim();
supplier['address'] = addressController.text.trim();
});

Navigator.pop(dialogContext);
nameController.dispose();
phoneController.dispose();
addressController.dispose();
},
style: ElevatedButton.styleFrom(
backgroundColor: orange,
foregroundColor: Colors.white,
),
child: const Text('Update Supplier'),
),
],
),
);
}

// RECORD A REAL SUPPLIER VISIT
void _recordVisit(int index) {
final visitTime = DateTime.now();

setState(() {
suppliers[index]['visits'] ??= <DateTime>[];
(suppliers[index]['visits'] as List<DateTime>)
    .add(visitTime);
});

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
'${suppliers[index]['name']} visit recorded',
),
backgroundColor: orange,
),
);
}

// SHOW ALL VISITS
void _showVisitHistory(int index) {
final supplier = suppliers[index];
final visits =
(supplier['visits'] as List<DateTime>?) ?? <DateTime>[];

showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: Text(
'${supplier['name']} - Visit History',
style: const TextStyle(fontWeight: FontWeight.bold),
),
content: SizedBox(
width: 400,
child: visits.isEmpty
? const Text('No visits recorded yet.')
    : ListView.separated(
shrinkWrap: true,
itemCount: visits.length,
separatorBuilder: (_, __) =>
const Divider(),
itemBuilder: (context, visitIndex) {
final visit = visits[visits.length - 1 - visitIndex];

return ListTile(
leading: const Icon(
Icons.event_available,
color: orange,
),
title: Text(
'Visit ${visits.length - visitIndex}',
),
subtitle: Text(_formatDateTime(visit)),
);
},
),
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Close'),
),
],
),
);
}

// DELETE SUPPLIER
void _deleteSupplier(int index) {
showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text('Delete Supplier'),
content: const Text(
'Are you sure you want to delete this supplier?',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
setState(() {
suppliers.removeAt(index);
});
Navigator.pop(dialogContext);
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
final searchText = searchController.text.toLowerCase();

final filteredSuppliers = suppliers.where((supplier) {
return supplier['name']
    .toString()
    .toLowerCase()
    .contains(searchText) ||
supplier['phone']
    .toString()
    .toLowerCase()
    .contains(searchText) ||
supplier['address']
    .toString()
    .toLowerCase()
    .contains(searchText);
}).toList();

return Scaffold(
backgroundColor: background,
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
title: const Text(
'Supplier Management',
style: TextStyle(
color: Color(0xFF333333),
fontWeight: FontWeight.bold,
),
),
iconTheme: const IconThemeData(color: orange),
),
body: Column(
children: [
// PAGE TITLE AND ADD BUTTON
Padding(
padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
child: Row(
children: [
const Expanded(
child: Text(
'Suppliers',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Color(0xFF333333),
),
),
),
ElevatedButton.icon(
onPressed: _showAddSupplierDialog,
icon: const Icon(
Icons.local_shipping_outlined,
color: Colors.white,
),
label: const Text(
'Add Supplier',
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.w600,
),
),
style: ElevatedButton.styleFrom(
backgroundColor: orange,
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

// SEARCH
Padding(
padding: const EdgeInsets.all(20),
child: TextField(
controller: searchController,
onChanged: (_) => setState(() {}),
decoration: InputDecoration(
hintText: 'Search suppliers...',
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

// SUPPLIER LIST
Expanded(
child: suppliers.isEmpty
? const Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.local_shipping_outlined,
size: 80,
color: orange,
),
SizedBox(height: 20),
Text(
'No suppliers added yet',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: Color(0xFF333333),
),
),
SizedBox(height: 8),
Text(
'Click "Add Supplier" to add your first supplier',
style: TextStyle(color: Colors.grey),
),
],
),
)
    : filteredSuppliers.isEmpty
? const Center(
child: Text(
'No matching suppliers found',
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
itemCount: filteredSuppliers.length,
itemBuilder: (context, index) {
final supplier = filteredSuppliers[index];
final originalIndex =
suppliers.indexOf(supplier);
final visits =
(supplier['visits'] as List<DateTime>?) ??
<DateTime>[];
final addedAt =
supplier['addedAt'] as DateTime?;

return Card(
color: Colors.white,
elevation: 1,
margin: const EdgeInsets.only(bottom: 12),
child: ListTile(
contentPadding: const EdgeInsets.all(12),
leading: Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: const Color(0xFFFFF0DD),
borderRadius: BorderRadius.circular(12),
),
child: const Icon(
Icons.local_shipping_outlined,
color: orange,
),
),
title: Text(
supplier['name'].toString(),
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
subtitle: Padding(
padding: const EdgeInsets.only(top: 6),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
children: [
Text(
'${supplier['phone']}\n${supplier['address']}',
),
if (addedAt != null) ...[
const SizedBox(height: 6),
Text(
'Added: ${_formatDateTime(addedAt)}',
style: const TextStyle(fontSize: 12),
),
],
const SizedBox(height: 6),
Text(
'Total Visits: ${visits.length}',
style: const TextStyle(
fontWeight: FontWeight.w600,
color: orange,
),
),
if (visits.isNotEmpty)
Text(
'Last Visit: ${_formatDateTime(visits.last)}',
style: const TextStyle(fontSize: 12),
),
],
),
),
isThreeLine: true,
trailing: Wrap(
spacing: 0,
children: [
IconButton(
tooltip: 'Record Visit',
onPressed: () =>
_recordVisit(originalIndex),
icon: const Icon(
Icons.event_available_outlined,
color: Colors.green,
),
),
IconButton(
tooltip: 'Visit History',
onPressed: () =>
_showVisitHistory(originalIndex),
icon: const Icon(
Icons.history,
color: orange,
),
),
IconButton(
tooltip: 'Edit Supplier',
onPressed: () =>
_showEditSupplierDialog(originalIndex),
icon: const Icon(
Icons.edit_outlined,
color: orange,
),
),
IconButton(
tooltip: 'Delete Supplier',
onPressed: () =>
_deleteSupplier(originalIndex),
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
],
),
);
}
}
