import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/service_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge.dart';

class FuelStationDetailsScreen extends StatelessWidget {
  final ServiceModel station;
  const FuelStationDetailsScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final fuelTypes = (station.details['fuelTypes'] as List?)?.cast<String>() ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(station.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Station Visual Map / Image header
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1527018601619-a508a2be00cd?w=600'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.15),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Station Header metadata
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(station.name, style: Theme.of(context).textTheme.headlineSmall)),
                StatusBadge(status: station.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(station.address, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(FontAwesomeIcons.solidStar, size: 14, color: Colors.amber),
                const SizedBox(width: 6),
                Text('${station.rating} (${station.reviewCount} reviews)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
                const SizedBox(width: 20),
                const Icon(FontAwesomeIcons.clock, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(station.openingHours, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
              ],
            ),
            const Divider(height: 32, color: Color(0xFFF1F3F5), thickness: 1),

            // 3. Available fuel types and pricing
            Text('Available Fuel Types', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.2,
              ),
              itemCount: fuelTypes.length,
              itemBuilder: (context, index) {
                final type = fuelTypes[index];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECE0).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFFECE0), width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(type, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text(
                        _mockFuelPrice(type),
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // 4. Contact details & actions
            Text('Contact Details', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _contactTile(FontAwesomeIcons.phone, '+94 11 234 5678', 'Call Center'),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _contactTile(FontAwesomeIcons.envelope, 'info@ceypetro.lk', 'Email Support'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 5. Button directions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(FontAwesomeIcons.locationArrow, size: 16),
                label: const Text('Get Directions'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Starting GPS navigation using Google Maps...'), backgroundColor: AppColors.statusInfo),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _mockFuelPrice(String type) {
    if (type.contains('92')) return 'Rs. 370.00 / L';
    if (type.contains('95')) return 'Rs. 410.00 / L';
    if (type.contains('Diesel')) return 'Rs. 320.00 / L';
    return 'Rs. 350.00 / L';
  }

  Widget _contactTile(IconData icon, String detail, String label) {
    return ListTile(
      leading: Icon(icon, size: 16, color: AppColors.textSecondary),
      title: Text(detail, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
      subtitle: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: () {},
    );
  }
}
