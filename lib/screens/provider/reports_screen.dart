import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../theme/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    // Dynamic metrics based on AppState
    final revenue = appState.totalRevenue;
    final activeJobs = appState.activeJobsCount;
    final completedJobs = appState.completedJobsCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Reports'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.download, size: 18),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading PDF Business Report...'),
                  backgroundColor: AppColors.statusInfo,
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. High-level Summary Metrics (2x2 Grid)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.45,
              children: [
                _metricCard(
                  context,
                  'Total Revenue',
                  'Rs. ${revenue.toStringAsFixed(0)}',
                  FontAwesomeIcons.moneyBillTrendUp,
                  const Color(0xFFE8F5E9),
                  const Color(0xFF2E7D32),
                ),
                _metricCard(
                  context,
                  'Active Orders',
                  '$activeJobs',
                  FontAwesomeIcons.solidClock,
                  const Color(0xFFE3F2FD),
                  const Color(0xFF1565C0),
                ),
                _metricCard(
                  context,
                  'Completed Jobs',
                  '$completedJobs',
                  FontAwesomeIcons.circleCheck,
                  const Color(0xFFFFF8E1),
                  const Color(0xFFF57F17),
                ),
                _metricCard(
                  context,
                  'Average Rating',
                  '4.9 / 5',
                  FontAwesomeIcons.solidStar,
                  const Color(0xFFFFEBEE),
                  const Color(0xFFC62828),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Revenue Chart Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Revenue Growth',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Monthly',
                            style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Revenue bar visualization
                    SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _barItem('May', 0.45, 'Rs. 3.2k'),
                          _barItem('Jun', 0.65, 'Rs. 4.5k'),
                          _barItem('Jul', 0.85, 'Rs. 5.9k'),
                          _barItem('Aug', 0.75, 'Rs. 5.1k'),
                          _barItem('Sep', 0.95, 'Rs. 6.8k', isSelected: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Service Performance
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Share Performance',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    _performanceRow('EV Charging Slots', 0.45, '45% Share', AppColors.statusInfo),
                    const SizedBox(height: 12),
                    _performanceRow('Vehicle Wash', 0.30, '30% Share', AppColors.primary),
                    const SizedBox(height: 12),
                    _performanceRow('Parking Reservation', 0.15, '15% Share', AppColors.statusAvailable),
                    const SizedBox(height: 12),
                    _performanceRow('Fuel Purchases', 0.10, '10% Share', AppColors.statusLimited),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 4. Rating Distribution Breakdown
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Feedback Rating Distribution',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    _feedbackDistributionRow('5 Stars', 0.82, '82%'),
                    const SizedBox(height: 8),
                    _feedbackDistributionRow('4 Stars', 0.12, '12%'),
                    const SizedBox(height: 8),
                    _feedbackDistributionRow('3 Stars', 0.04, '4%'),
                    const SizedBox(height: 8),
                    _feedbackDistributionRow('2 Stars', 0.01, '1%'),
                    const SizedBox(height: 8),
                    _feedbackDistributionRow('1 Star', 0.01, '1%'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color bgIconColor,
    Color iconColor,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: bgIconColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _barItem(String month, double heightPct, String amount, {bool isSelected = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          amount,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 24,
          height: 100 * heightPct,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: isSelected
                  ? [AppColors.primary, AppColors.primary.withOpacity(0.7)]
                  : [AppColors.secondary.withOpacity(0.2), AppColors.secondary.withOpacity(0.1)],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _performanceRow(String label, double valuePct, String shareText, Color barColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            Text(
              shareText,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: barColor),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: valuePct,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _feedbackDistributionRow(String label, double progress, String percent) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 6,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 32,
          child: Text(
            percent,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
