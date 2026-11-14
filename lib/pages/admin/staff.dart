import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
const StaffPage({super.key});

@override
State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
final List<Map<String, dynamic>> staff = [];

final TextEditingController searchController =
TextEditingController();

final List<String> roles = [
'Admin',
'Cashier',
'Sales Staff',
'Inventory Staff',
];

String _formatDate(DateTime date) {
final day = date.day.toString().padLeft(2, '0');
final month = date.month.toString().padLeft(2, '0');
return '$day/$month/${date.year}';
}

String _formatTime(DateTime date) {
final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
final minute = date.minute.toString().padLeft(2, '0');
final period = date.hour >= 12 ? 'PM' : 'AM';
return '$hour:$minute $period';
}

void _showMessage(String message) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(message),
backgroundColor: const Color(0xFFFF8A00),
),
);
}

// ADD STAFF
void _showAddStaffDialog() {
final nameController = TextEditingController();
final phoneController = TextEditingController();
String selectedRole = roles[1];

showDialog(
context: context,
builder: (dialogContext) {
return StatefulBuilder(
builder: (context, setDialogState) {
return AlertDialog(
title: const Text('Add Staff'),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: nameController,
decoration: const InputDecoration(
labelText: 'Staff Name',
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
DropdownButtonFormField<String>(
value: selectedRole,
decoration: const InputDecoration(
labelText: 'Select Role',
prefixIcon: Icon(Icons.work_outline),
border: OutlineInputBorder(),
),
items: roles.map((role) {
return DropdownMenuItem(
value: role,
child: Text(role),
);
}).toList(),
onChanged: (value) {
if (value != null) {
setDialogState(() {
selectedRole = value;
});
}
},
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
phoneController.text.trim().isEmpty) {
_showMessage('Please enter staff name and phone');
return;
}

setState(() {
staff.add({
'name': nameController.text.trim(),
'phone': phoneController.text.trim(),
'role': selectedRole,
'attendanceDate': '',
'checkIn': '',
'checkOut': '',
'status': 'Not Marked',
});
});

Navigator.pop(dialogContext);
_showMessage('Staff added successfully');
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFFF8A00),
foregroundColor: Colors.white,
),
child: const Text('Add Staff'),
),
],
);
},
);
},
).then((_) {
nameController.dispose();
phoneController.dispose();
});
}

// EDIT STAFF
void _showEditStaffDialog(int index) {
final member = staff[index];
final nameController =
TextEditingController(text: member['name'].toString());
final phoneController =
TextEditingController(text: member['phone'].toString());

String selectedRole = roles.contains(member['role'])
? member['role'].toString()
    : roles[1];

showDialog(
context: context,
builder: (dialogContext) {
return StatefulBuilder(
builder: (context, setDialogState) {
return AlertDialog(
title: const Text('Edit Staff'),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: nameController,
decoration: const InputDecoration(
labelText: 'Staff Name',
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
DropdownButtonFormField<String>(
value: selectedRole,
decoration: const InputDecoration(
labelText: 'Select Role',
prefixIcon: Icon(Icons.work_outline),
border: OutlineInputBorder(),
),
items: roles.map((role) {
return DropdownMenuItem(
value: role,
child: Text(role),
);
}).toList(),
onChanged: (value) {
if (value != null) {
setDialogState(() {
selectedRole = value;
});
}
},
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
phoneController.text.trim().isEmpty) {
_showMessage('Please fill in all details');
return;
}

setState(() {
staff[index]['name'] =
nameController.text.trim();
staff[index]['phone'] =
phoneController.text.trim();
staff[index]['role'] = selectedRole;
});

Navigator.pop(dialogContext);
_showMessage('Staff updated successfully');
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFFF8A00),
foregroundColor: Colors.white,
),
child: const Text('Update Staff'),
),
],
);
},
);
},
).then((_) {
nameController.dispose();
phoneController.dispose();
});
}

// CHECK IN
void _checkIn(int index) {
final now = DateTime.now();

setState(() {
staff[index]['attendanceDate'] = _formatDate(now);
staff[index]['checkIn'] = _formatTime(now);
staff[index]['checkOut'] = '';
staff[index]['status'] = 'Present';
});

_showMessage('${staff[index]['name']} checked in');
}

// CHECK OUT
void _checkOut(int index) {
if (staff[index]['checkIn'].toString().isEmpty ||
staff[index]['attendanceDate'] !=
_formatDate(DateTime.now())) {
_showMessage('Please check in first');
return;
}

if (staff[index]['checkOut'].toString().isNotEmpty) {
_showMessage('Check-out already recorded');
return;
}

final now = DateTime.now();

setState(() {
staff[index]['checkOut'] = _formatTime(now);
});

_showMessage('${staff[index]['name']} checked out');
}

// MARK ABSENT
void _markAbsent(int index) {
final today = _formatDate(DateTime.now());

if (staff[index]['attendanceDate'] == today &&
staff[index]['status'] == 'Present') {
_showMessage('Staff already checked in today');
return;
}

setState(() {
staff[index]['attendanceDate'] = today;
staff[index]['checkIn'] = '';
staff[index]['checkOut'] = '';
staff[index]['status'] = 'Absent';
});

_showMessage('${staff[index]['name']} marked absent');
}

// DELETE STAFF
void _deleteStaff(int index) {
showDialog(
context: context,
builder: (dialogContext) {
return AlertDialog(
title: const Text('Delete Staff'),
content: const Text(
'Are you sure you want to delete this staff member?',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
ElevatedButton(
onPressed: () {
setState(() {
staff.removeAt(index);
});
Navigator.pop(dialogContext);
_showMessage('Staff deleted');
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
final query = searchController.text.toLowerCase().trim();

final filteredStaff = staff.where((member) {
return member['name'].toString().toLowerCase().contains(query) ||
member['phone'].toString().toLowerCase().contains(query) ||
member['role'].toString().toLowerCase().contains(query);
}).toList();

final presentCount = staff.where((member) {
return member['attendanceDate'] == _formatDate(DateTime.now()) &&
member['status'] == 'Present';
}).length;

final absentCount = staff.where((member) {
return member['attendanceDate'] == _formatDate(DateTime.now()) &&
member['status'] == 'Absent';
}).length;

return Scaffold(
backgroundColor: const Color(0xFFF8F8F8),
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
title: const Text(
'Staff Management',
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
Padding(
padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
child: Row(
children: [
const Expanded(
child: Text(
'Staff Members',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Color(0xFF333333),
),
),
),
ElevatedButton.icon(
onPressed: _showAddStaffDialog,
icon: const Icon(Icons.person_add_alt_1),
label: const Text('Add Staff'),
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

// TODAY'S ATTENDANCE SUMMARY
Padding(
padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
child: Row(
children: [
Expanded(
child: _summaryCard(
'Total Staff',
'${staff.length}',
Icons.people_outline,
Colors.blue,
),
),
const SizedBox(width: 10),
Expanded(
child: _summaryCard(
'Present',
'$presentCount',
Icons.check_circle_outline,
Colors.green,
),
),
const SizedBox(width: 10),
Expanded(
child: _summaryCard(
'Absent',
'$absentCount',
Icons.cancel_outlined,
Colors.red,
),
),
],
),
),

Padding(
padding: const EdgeInsets.all(20),
child: TextField(
controller: searchController,
onChanged: (_) => setState(() {}),
decoration: InputDecoration(
hintText: 'Search staff by name, phone or role...',
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
),
),
),

Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: Row(
children: [
const Icon(
Icons.calendar_today_outlined,
size: 16,
color: Color(0xFFFF8A00),
),
const SizedBox(width: 8),
Text(
"Today's Attendance • ${_formatDate(DateTime.now())}",
style: const TextStyle(
fontWeight: FontWeight.w600,
color: Color(0xFF444444),
),
),
],
),
),

const SizedBox(height: 10),

Expanded(
child: filteredStaff.isEmpty
? Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(
Icons.people_outline,
size: 75,
color: Color(0xFFFF8A00),
),
const SizedBox(height: 16),
Text(
staff.isEmpty
? 'No staff added yet'
    : 'No matching staff found',
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
staff.isEmpty
? 'Click "Add Staff" to add your first staff member'
    : 'Try another search',
style: const TextStyle(color: Colors.grey),
textAlign: TextAlign.center,
),
],
),
)
    : ListView.builder(
padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 4,
),
itemCount: filteredStaff.length,
itemBuilder: (context, index) {
final member = filteredStaff[index];
final originalIndex = staff.indexOf(member);

final isToday = member['attendanceDate'] ==
_formatDate(DateTime.now());

final status = isToday
? member['status'].toString()
    : 'Not Marked';

final checkIn =
isToday ? member['checkIn'].toString() : '';
final checkOut =
isToday ? member['checkOut'].toString() : '';

final statusColor = status == 'Present'
? Colors.green
    : status == 'Absent'
? Colors.red
    : Colors.grey;

return Card(
color: Colors.white,
elevation: 1,
margin: const EdgeInsets.only(bottom: 14),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(14),
),
child: Padding(
padding: const EdgeInsets.all(14),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: const Color(0xFFFFF0DD),
borderRadius: BorderRadius.circular(12),
),
child: const Icon(
Icons.person_outline,
color: Color(0xFFFF8A00),
size: 28,
),
),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
member['name'].toString(),
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Text(
'${member['role']} • ${member['phone']}',
style: const TextStyle(
color: Colors.grey,
),
),
],
),
),
PopupMenuButton<String>(
onSelected: (value) {
if (value == 'edit') {
_showEditStaffDialog(originalIndex);
} else if (value == 'delete') {
_deleteStaff(originalIndex);
}
},
itemBuilder: (context) => const [
PopupMenuItem(
value: 'edit',
child: Text('Edit Staff'),
),
PopupMenuItem(
value: 'delete',
child: Text('Delete Staff'),
),
],
),
],
),

const Divider(height: 24),

Row(
children: [
const Icon(
Icons.access_time,
size: 18,
color: Color(0xFFFF8A00),
),
const SizedBox(width: 6),
const Text(
'Attendance',
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
const Spacer(),
Container(
padding: const EdgeInsets.symmetric(
horizontal: 10,
vertical: 5,
),
decoration: BoxDecoration(
color: statusColor.withValues(
alpha: 0.12,
),
borderRadius: BorderRadius.circular(20),
),
child: Text(
status,
style: TextStyle(
color: statusColor,
fontWeight: FontWeight.bold,
fontSize: 12,
),
),
),
],
),

const SizedBox(height: 12),

Row(
children: [
Expanded(
child: _timeInfo(
'Check In',
checkIn.isEmpty ? '--:--' : checkIn,
Icons.login,
),
),
Expanded(
child: _timeInfo(
'Check Out',
checkOut.isEmpty ? '--:--' : checkOut,
Icons.logout,
),
),
],
),

const SizedBox(height: 14),

Wrap(
spacing: 8,
runSpacing: 8,
children: [
ElevatedButton.icon(
onPressed: () {
if (isToday &&
checkIn.isNotEmpty) {
_showMessage(
'Check-in already recorded today',
);
} else {
_checkIn(originalIndex);
}
},
icon: const Icon(
Icons.login,
size: 17,
),
label: const Text('Check In'),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.green,
foregroundColor: Colors.white,
),
),
OutlinedButton.icon(
onPressed: () =>
_checkOut(originalIndex),
icon: const Icon(
Icons.logout,
size: 17,
),
label: const Text('Check Out'),
),
TextButton(
onPressed: () =>
_markAbsent(originalIndex),
child: const Text(
'Mark Absent',
style: TextStyle(color: Colors.red),
),
),
],
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

Widget _summaryCard(
String title,
String value,
IconData icon,
Color color,
) {
return Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: const Color(0xFFECECEC)),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Icon(icon, color: color, size: 23),
const SizedBox(height: 8),
Text(
value,
style: const TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
Text(
title,
style: const TextStyle(
fontSize: 12,
color: Colors.grey,
),
),
],
),
);
}

Widget _timeInfo(String title, String time, IconData icon) {
return Row(
children: [
Icon(icon, size: 18, color: Colors.grey),
const SizedBox(width: 7),
Flexible(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: const TextStyle(
color: Colors.grey,
fontSize: 12,
),
),
const SizedBox(height: 4),
Text(
time,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 14,
),
),
],
),
),
],
);
}
}

