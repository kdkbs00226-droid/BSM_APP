import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Low Stock Alert',
      'message': 'Rice stock is running low.',
      'icon': Icons.warning_amber_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'Customer Due',
      'message': 'A customer has a pending payment.',
      'icon': Icons.account_balance_wallet_outlined,
      'color': Colors.red,
    },
    {
      'title': 'Bill Created',
      'message': 'A new bill was created successfully.',
      'icon': Icons.receipt_long_outlined,
      'color': Colors.green,
    },
  ];

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFFFF8A00),
        ),

        actions: [
          if (notifications.isNotEmpty)
            TextButton(
              onPressed: _clearAll,
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: Color(0xFFFF8A00),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),

      body: notifications.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_outlined,
              size: 80,
              color: Color(0xFFFF8A00),
            ),

            SizedBox(height: 20),

            Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            SizedBox(height: 8),

            Text(
              'You are all caught up!',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),

        itemCount: notifications.length,

        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            color: Colors.white,
            elevation: 1,

            margin: const EdgeInsets.only(
              bottom: 12,
            ),

            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              leading: Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: notification['color']
                      .withOpacity(0.12),

                  borderRadius: BorderRadius.circular(12),
                ),

                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                ),
              ),

              title: Text(
                notification['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  notification['message'],
                ),
              ),

              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),

                onPressed: () {
                  _deleteNotification(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}