import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String selectedPeriod = 'Today';

  final List<String> periods = [
    'Today',
    'This Week',
    'This Month',
    'This Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Reports',
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

            // PERIOD FILTER
            const Text(
              'Report Period',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPeriod,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFFF8A00),
                  ),
                  items: periods.map((period) {
                    return DropdownMenuItem(
                      value: period,
                      child: Text(period),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPeriod = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            // SUMMARY TITLE
            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            // SUMMARY CARDS
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Total Sales',
                    value: '₹0',
                    icon: Icons.currency_rupee,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildSummaryCard(
                    title: 'Total Bills',
                    value: '0',
                    icon: Icons.receipt_long_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: 'Products Sold',
                    value: '0',
                    icon: Icons.inventory_2_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildSummaryCard(
                    title: 'Customers',
                    value: '0',
                    icon: Icons.people_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // REPORT OPTIONS
            const Text(
              'Report Types',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            _buildReportTile(
              icon: Icons.bar_chart_outlined,
              title: 'Sales Report',
              subtitle:
              'View detailed sales and billing performance',
            ),

            _buildReportTile(
              icon: Icons.inventory_2_outlined,
              title: 'Product Report',
              subtitle:
              'View product sales and inventory details',
            ),

            _buildReportTile(
              icon: Icons.people_outline,
              title: 'Customer Report',
              subtitle:
              'View customer purchases and activity',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFFFF8A00),
            size: 28,
          ),

          const SizedBox(height: 15),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: const Color(0xFFFFF0DD),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            color: const Color(0xFFFF8A00),
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),

        subtitle: Text(subtitle),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Color(0xFFFF8A00),
        ),

        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$title will show data when backend is connected',
              ),
            ),
          );
        },
      ),
    );
  }
}