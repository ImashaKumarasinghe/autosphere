import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../widgets/category_card.dart';
import '../../widgets/service_card.dart';
import '../../services/mock_data.dart';
import '../fuel/fuel_station_list_screen.dart';
import '../ev/ev_charging_screen.dart';
import '../parking/parking_search_screen.dart';
import '../wash/wash_services_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(FontAwesomeIcons.locationDot, color: Color(0xFF9E5416), size: 12),
                SizedBox(width: 4),
                Text('San Francisco, CA', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 2),
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
  icon: const Icon(
    FontAwesomeIcons.bell,
    size: 20,
    color: AppColors.textPrimary,
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificationsScreen(),
      ),
    );
  },
)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search fuel, EV, parking, wash...',
                prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16, color: AppColors.textSecondary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 2. Offer / Promotion Banner Carousel
          _offerBanner(context),
          const SizedBox(height: 24),

          // 3. Service Categories Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Service Categories', style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.80,
              children: [
                CategoryCard(
                  label: 'Fuel Stations',
                  icon: FontAwesomeIcons.gasPump,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FuelStationListScreen())),
                ),
                CategoryCard(
                  label: 'EV Charging',
                  icon: FontAwesomeIcons.chargingStation,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EvChargingScreen())),
                ),
                CategoryCard(
                  label: 'Parking Lots',
                  icon: FontAwesomeIcons.squareParking,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ParkingSearchScreen())),
                ),
                CategoryCard(
                  label: 'Vehicle Wash',
                  icon: FontAwesomeIcons.soap,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WashServicesScreen())),
                ),
                CategoryCard(
                  label: 'Detailing',
                  icon: FontAwesomeIcons.sprayCanSparkles,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WashServicesScreen())),
                ),
                CategoryCard(
                  label: 'Accessories',
                  icon: FontAwesomeIcons.wrench,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Accessory services under construction.')),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // 4. Popular Providers / Offers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Popular Providers', style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 10),
          ...MockData.fuelStations.map((s) => ServiceCard(
                service: s,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FuelStationListScreen()),
                ),
              )),
          ...MockData.evStations.map((s) => ServiceCard(
                service: s,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EvChargingScreen()),
                ),
              )),
        ],
      ),
    );
  }

  Widget _offerBanner(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFC2410C), AppColors.primary, AppColors.primary.withRed(240)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'SPECIAL PROMO',
                    style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get 20% Off Detail Clean',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Book any detailing wash package this week.',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(FontAwesomeIcons.gifts, color: Colors.white, size: 54),
        ],
      ),
    );
  }
}
