import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../theme/app_theme.dart';
import 'booking_requests_screen.dart';
import 'offer_management_screen.dart';
import 'availability_management_screen.dart';
import 'customer_list_screen.dart';

class ProviderDashboardScreen extends StatelessWidget {
  const ProviderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(FontAwesomeIcons.locationDot, color: Color(0xFF9E5416), size: 20),
            const SizedBox(width: 8),
            Text(
              'AutoSphere',
              style: TextStyle(
                color: const Color(0xFF9E5416),
                fontFamily: AppTheme.lightTheme.textTheme.headlineMedium?.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bell, size: 20, color: AppColors.textPrimary),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Greeting card
          Card(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF9E5416), AppColors.primary],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Provider!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Here is your AutoSphere business performance overview for today.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- Stats grid ---
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              _statCard(
                context,
                "Active Jobs",
                '${appState.activeJobsCount}',
                FontAwesomeIcons.briefcase,
                const Color(0xFF3B82F6),
              ),
              _statCard(
                context,
                'Pending Jobs',
                '${appState.pendingJobsCount}',
                FontAwesomeIcons.clock,
                AppColors.primary,
              ),
              _statCard(
                context,
                'Total Revenue',
                '\$${appState.totalRevenue.toStringAsFiltered()}',
                FontAwesomeIcons.sackDollar,
                const Color(0xFF22C55E),
              ),
              _statCard(
                context,
                'Completed Jobs',
                '${appState.completedJobsCount}',
                FontAwesomeIcons.circleCheck,
                const Color(0xFFEAB308),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text('Quick Actions', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          _actionTile(
            context,
            'Manage Availability',
            'Update fuel availability, chargers count, or parking capacity.',
            FontAwesomeIcons.clock,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AvailabilityManagementScreen())),
          ),
          _actionTile(
            context,
            'Booking Requests',
            'See pending requests from Marcus Chen and Sarah Jennings.',
            FontAwesomeIcons.inbox,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookingRequestsScreen())),
          ),
          _actionTile(
            context,
            'Offers & Promotions',
            'Publish new discounts to attract vehicle wash customers.',
            FontAwesomeIcons.tags,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OfferManagementScreen())),
          ),
          _actionTile(
            context,
            'Customers List',
            'See Emma Watson and other returning customer metrics.',
            FontAwesomeIcons.users,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerListScreen())),
          ),
        ],
      ),
    );
  }

  Widget _statCard(BuildContext context, String label, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 14),
            ),
            const Spacer(),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary, letterSpacing: -0.5)),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _actionTile(BuildContext context, String label, String description, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECE0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF9E5416), size: 18),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(description, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        ),
        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
