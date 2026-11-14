import 'package:flutter/material.dart';

class SalesAnalyticsPage extends StatefulWidget {
  const SalesAnalyticsPage({super.key});

  @override
  State<SalesAnalyticsPage> createState() =>
      _SalesAnalyticsPageState();
}

class _SalesAnalyticsPageState
    extends State<SalesAnalyticsPage> {
  String selectedPeriod = 'This Week';

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
          'Sales Analytics',
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
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            // PERIOD FILTER
            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(14),
                border: Border.all(
                  color:
                  const Color(0xFFE5E5E5),
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

            const Text(
              'Sales Overview',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            // SALES CARDS
            Row(
              children: [
                Expanded(
                  child: _buildAnalyticsCard(
                    title: 'Today Sales',
                    value: '₹0',
                    icon:
                    Icons.currency_rupee,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildAnalyticsCard(
                    title: 'Total Bills',
                    value: '0',
                    icon:
                    Icons.receipt_long_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildAnalyticsCard(
                    title: 'Sales Growth',
                    value: '0%',
                    icon:
                    Icons.trending_up,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildAnalyticsCard(
                    title: 'Avg. Bill',
                    value: '₹0',
                    icon:
                    Icons.analytics_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // SALES TREND
            const Text(
              'Sales Trend',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              height: 220,
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(16),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),
                    blurRadius: 8,
                    offset:
                    const Offset(0, 3),
                  ),
                ],
              ),

              child: const Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 55,
                    color: Color(0xFFFF8A00),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Sales trend chart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      Color(0xFF333333),
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Sales chart will appear when billing data is available',
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // TOP PRODUCTS
            const Text(
              'Top Selling Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(16),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),
                    blurRadius: 8,
                    offset:
                    const Offset(0, 3),
                  ),
                ],
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 50,
                    color: Color(0xFFFF8A00),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'No sales data yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      Color(0xFF333333),
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Top selling products will appear here after sales are recorded.',
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
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
              fontWeight:
              FontWeight.bold,
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
}