import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
const SettingsPage({super.key});

@override
State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
bool notifications = true;
bool lowStockAlerts = true;
bool sound = false;

final Color orange = const Color(0xFFFF8A00);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF8F8F8),
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
iconTheme: IconThemeData(color: orange),
title: const Text(
'Settings',
style: TextStyle(
color: Color(0xFF333333),
fontWeight: FontWeight.bold,
),
),
),
body: ListView(
padding: const EdgeInsets.all(20),
children: [
_sectionTitle('ACCOUNT'),
const SizedBox(height: 10),

_settingsTile(
icon: Icons.person_outline,
title: 'Admin Profile',
subtitle: 'View your account details',
onTap: () => _showMessage('Admin Profile'),
),

_settingsTile(
icon: Icons.lock_outline,
title: 'Change Password',
subtitle: 'Update your password',
onTap: () => _showMessage('Change Password'),
),

const SizedBox(height: 24),

_sectionTitle('PREFERENCES'),
const SizedBox(height: 10),

_switchTile(
icon: Icons.notifications_outlined,
title: 'Notifications',
subtitle: 'Receive app notifications',
value: notifications,
onChanged: (value) {
setState(() => notifications = value);
},
),

_switchTile(
icon: Icons.warning_amber_outlined,
title: 'Low Stock Alerts',
subtitle: 'Get alerts for low-stock products',
value: lowStockAlerts,
onChanged: (value) {
setState(() => lowStockAlerts = value);
},
),

_switchTile(
icon: Icons.volume_up_outlined,
title: 'Sound',
subtitle: 'Enable notification sound preference',
value: sound,
onChanged: (value) {
setState(() => sound = value);
},
),

const SizedBox(height: 24),

_sectionTitle('SUPPORT'),
const SizedBox(height: 10),

_settingsTile(
icon: Icons.help_outline,
title: 'Help & Support',
subtitle: 'Get assistance',
onTap: () => _showMessage('Help & Support'),
),

_settingsTile(
icon: Icons.info_outline,
title: 'About App',
subtitle: 'BSM Store Billing System',
onTap: () => _showMessage('BSM Store Billing System'),
),

const SizedBox(height: 24),

// Small Logout button
Center(
child: SizedBox(
width: 120,
height: 38,
child: OutlinedButton.icon(
onPressed: _logoutDialog,
icon: const Icon(
Icons.logout,
color: Colors.red,
size: 16,
),
label: const Text(
'Logout',
style: TextStyle(
color: Colors.red,
fontSize: 13,
fontWeight: FontWeight.w600,
),
),
style: OutlinedButton.styleFrom(
padding: const EdgeInsets.symmetric(
horizontal: 8,
vertical: 4,
),
side: const BorderSide(color: Colors.red),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(8),
),
),
),
),
),

const SizedBox(height: 20),
],
),
);
}

Widget _sectionTitle(String title) {
return Text(
title,
style: const TextStyle(
color: Colors.grey,
fontSize: 12,
fontWeight: FontWeight.bold,
letterSpacing: 1,
),
);
}

Widget _settingsTile({
required IconData icon,
required String title,
required String subtitle,
required VoidCallback onTap,
}) {
return Card(
color: Colors.white,
elevation: 0,
margin: const EdgeInsets.only(bottom: 10),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(14),
),
child: ListTile(
onTap: onTap,
contentPadding: const EdgeInsets.all(12),
leading: Container(
width: 44,
height: 44,
decoration: BoxDecoration(
color: const Color(0xFFFFF0DD),
borderRadius: BorderRadius.circular(12),
),
child: Icon(icon, color: orange),
),
title: Text(
title,
style: const TextStyle(fontWeight: FontWeight.w600),
),
subtitle: Text(
subtitle,
style: const TextStyle(fontSize: 12),
),
trailing: const Icon(
Icons.chevron_right,
color: Colors.grey,
),
),
);
}

Widget _switchTile({
required IconData icon,
required String title,
required String subtitle,
required bool value,
required ValueChanged<bool> onChanged,
}) {
return Card(
color: Colors.white,
elevation: 0,
margin: const EdgeInsets.only(bottom: 10),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(14),
),
child: SwitchListTile(
secondary: Icon(icon, color: orange),
title: Text(
title,
style: const TextStyle(fontWeight: FontWeight.w600),
),
subtitle: Text(
subtitle,
style: const TextStyle(fontSize: 12),
),
activeThumbColor: orange,
value: value,
onChanged: onChanged,
),
);
}

void _showMessage(String title) {
showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: Text(title),
content: const Text(
'This feature will be connected later.',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: Text('OK', style: TextStyle(color: orange)),
),
],
),
);
}

void _logoutDialog() {
showDialog(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text('Logout'),
content: const Text(
'Are you sure you want to logout?',
),
actions: [
TextButton(
onPressed: () => Navigator.pop(dialogContext),
child: const Text('Cancel'),
),
TextButton(
onPressed: () {
Navigator.pop(dialogContext);

Navigator.of(context).pushNamedAndRemoveUntil(
'/login',
(route) => false,
);
},
child: const Text(
'Logout',
style: TextStyle(color: Colors.red),
),
),
],
),
);
}
}
