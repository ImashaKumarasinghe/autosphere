import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';
import 'home/home_screen.dart';
import 'customer/booking_status_screen.dart';
import 'customer/customer_profile_screen.dart';
import 'customer/map_view_screen.dart';
import 'provider/provider_dashboard_screen.dart';
import 'provider/booking_requests_screen.dart';
import 'provider/offer_management_screen.dart';
import 'provider/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Screens for Customer Role
  final List<Widget> _customerScreens = [
    const HomeScreen(),
    const BookingStatusScreen(),
    const MapViewScreen(),
    const CustomerProfileScreen(),
  ];

  // Screens for Provider Role
  final List<Widget> _providerScreens = [
    const ProviderDashboardScreen(),
    const BookingRequestsScreen(),
    const OfferManagementScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isProvider = appState.isProviderMode;
    final currentScreens = isProvider ? _providerScreens : _customerScreens;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: currentScreens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withOpacity(0.04),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary.withOpacity(0.6),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house, size: 20),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendarCheck, size: 20),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.map, size: 20),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user, size: 20),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
