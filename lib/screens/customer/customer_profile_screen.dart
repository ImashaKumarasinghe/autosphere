import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/app_state.dart';
import '../login_screen.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bell, size: 20),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. Customer Info header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Emma Watson', style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 4),
                          Text('emma.watson@gmail.com', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.orangeLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Premium Member',
                              style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Role Toggle Card
            Card(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withRed(240)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Business Account',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Switch to Provider Mode to manage bookings and promotions.',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        appState.toggleRole();
                      },
                      child: const Text('Switch'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. Vehicles section (Section 5.3 EV Details / Section 6 booking)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('My Vehicles', style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 12),
            _vehicleItem(
              context,
              'Model S Plaid',
              'Tesla • EV',
              FontAwesomeIcons.carBattery,
              appState.selectedVehicle == 'Model S Plaid',
              () => appState.selectVehicle('Model S Plaid'),
            ),
            const SizedBox(height: 10),
            _vehicleItem(
              context,
              'Daily Commuter',
              'Nissan Leaf • EV',
              FontAwesomeIcons.bolt,
              appState.selectedVehicle == 'Daily Commuter',
              () => appState.selectVehicle('Daily Commuter'),
            ),
            const SizedBox(height: 20),

            // 4. Menu options
            Card(
              child: Column(
                children: [
                  _menuItem(context, 'Transaction History', FontAwesomeIcons.clockRotateLeft, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Transaction history list is currently empty.')),
                    );
                  }),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _menuItem(context, 'Saved Stations', FontAwesomeIcons.heart, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved stations list is empty.')),
                    );
                  }),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _menuItem(context, 'Settings', FontAwesomeIcons.gear, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings are managed via profile details.')),
                    );
                  }),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _menuItem(context, 'Logout', FontAwesomeIcons.rightFromBracket, () {
                    _showLogoutDialog(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleItem(
    BuildContext context,
    String name,
    String type,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFF1F3F5),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.orangeLight : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
                  Text(type, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(FontAwesomeIcons.circleCheck, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title, IconData icon, [VoidCallback? onTap]) {
    return ListTile(
      leading: Icon(icon, size: 18, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
      onTap: onTap ?? () {},
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
