import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../theme/app_theme.dart';
import '../login_screen.dart';
import 'availability_management_screen.dart';
import 'customer_list_screen.dart';
import 'provider_reviews_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Color(0xFFF1F5F9),
                      child: Icon(FontAwesomeIcons.shieldHalved, size: 36, color: AppColors.primary),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'AutoSphere Service Center',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Provider ID: #AS-992841',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                    const SizedBox(height: 16),

                    // Business Status toggle row
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFECE0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'BUSINESS STATUS',
                                style: TextStyle(color: Color(0xFF9E5416), fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                appState.isBusinessOpen ? 'Open for Service' : 'Closed for Service',
                                style: const TextStyle(color: Color(0xFF9E5416), fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: appState.isBusinessOpen,
                            activeColor: const Color(0xFF3B82F6), // Blue switch match
                            activeTrackColor: const Color(0xFF93C5FD),
                            onChanged: (val) {
                              appState.toggleBusinessStatus(val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Rating Metrics cards row
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(FontAwesomeIcons.solidStar, color: AppColors.primary, size: 18),
                          const SizedBox(height: 12),
                          const Text('4.9', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          Text('Rating', style: TextStyle(color: AppColors.textSecondary.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(FontAwesomeIcons.handshake, color: Color(0xFF00875A), size: 18),
                          const SizedBox(height: 12),
                          Text('${(appState.completedJobsCount / 1000).toStringAsFixed(1)}k', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          Text('Completed', style: TextStyle(color: AppColors.textSecondary.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 3. Settings Menu
            const Text(
              'ACCOUNT & SETTINGS',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _menuItem(
                    context,
                    'Business Profile',
                    FontAwesomeIcons.solidBuilding,
                    () {},
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _menuItem(
                    context,
                    'Manage Services',
                    FontAwesomeIcons.sliders,
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AvailabilityManagementScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _menuItem(
                    context,
                    'Customers List',
                    FontAwesomeIcons.users,
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerListScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _menuItem(
                    context,
                    'Customer Feedback',
                    FontAwesomeIcons.solidCommentDots,
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProviderReviewsScreen()));
                    },
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _menuItem(
                    context,
                    'Switch back to Customer Mode',
                    FontAwesomeIcons.rotate,
                    () {
                      appState.setRole(false);
                    },
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _menuItem(
                    context,
                    'Logout',
                    FontAwesomeIcons.rightFromBracket,
                    () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFECE0).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF9E5416)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out of AutoSphere?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // dismiss dialog
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout', style: TextStyle(color: AppColors.statusClosed)),
          ),
        ],
      ),
    );
  }
}
