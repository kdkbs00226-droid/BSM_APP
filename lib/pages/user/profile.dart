
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const Color orange = Color(0xFFF58220);
  static const Color background = Color(0xFFF8F8F8);
  static const Color darkText = Color(0xFF252525);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Profile header
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: orange,
                  ),
                  child: const CircleAvatar(
                    radius: 43,
                    backgroundColor: Color(0xFFFFE8D2),
                    child: Icon(
                      Icons.person,
                      size: 52,
                      color: orange,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Vaishnavi R',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'vaishnavi@example.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfilePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 17),
                  label: const Text('Edit Profile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: orange,
                    side: const BorderSide(color: orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 12),

          _infoCard([
            _InfoItem(Icons.person_outline, 'Full Name', 'Vaishnavi R'),
            _InfoItem(Icons.email_outlined, 'Email', 'vaishnavi@example.com'),
            _InfoItem(Icons.phone_outlined, 'Phone Number', 'Not added'),
          ]),

          const SizedBox(height: 24),

          const Text(
            'My Account',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 12),

          _menuCard(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () => _message(context, 'Orders page'),
          ),
          _menuCard(
            icon: Icons.receipt_long_outlined,
            title: 'Bill History',
            onTap: () => _message(context, 'Bill History'),
          ),
          _menuCard(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () => _message(context, 'Notifications'),
          ),
          _menuCard(
            icon: Icons.location_on_outlined,
            title: 'My Addresses',
            onTap: () => _message(context, 'My Addresses'),
          ),
          _menuCard(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => _message(context, 'Help & Support'),
          ),

          const SizedBox(height: 20),

          OutlinedButton.icon(
            onPressed: () {
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
                        _message(context, 'Logout UI only');
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: orange),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: OutlinedButton.styleFrom(
              foregroundColor: orange,
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: orange),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _infoCard(List<_InfoItem> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Icon(item.icon, color: orange, size: 23),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.value,
                        style: const TextStyle(
                          color: darkText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: orange, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: darkText,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _message(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title - connect navigation next')),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem(this.icon, this.title, this.value);
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  static const Color orange = Color(0xFFF58220);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: 'Vaishnavi R');
    final emailController =
    TextEditingController(text: 'vaishnavi@example.com');
    final phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF252525),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFFFE8D2),
              child: Icon(Icons.person, size: 48, color: orange),
            ),
          ),
          const SizedBox(height: 25),
          _field('Full Name', nameController),
          _field('Email Address', emailController),
          _field('Phone Number', phoneController),
          const SizedBox(height: 22),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'UI only. Saving will be connected later.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}