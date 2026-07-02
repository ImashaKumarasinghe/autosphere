import 'package:flutter/material.dart';
import '../../services/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge.dart';
import 'parking_booking_screen.dart';

class ParkingSearchScreen extends StatelessWidget {
  const ParkingSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lots = MockData.parkingLots;

    return Scaffold(
      appBar: AppBar(title: const Text('Find Parking')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lots.length,
        itemBuilder: (context, index) {
          final p = lots[index];
          final available = p.details['available'] as int;
          final capacity = p.details['capacity'] as int;
          final price = (p.details['pricePerHour'] as num).toDouble();

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(p.name, style: Theme.of(context).textTheme.headlineSmall)),
                      StatusBadge(status: p.status),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(p.address, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),

                  // Free vs capacity visual bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$available of $capacity spaces free', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      Text('Rs. ${price.toStringAsFixed(0)} / hour', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: available / capacity,
                      minHeight: 8,
                      backgroundColor: AppColors.statusClosed.withOpacity(0.12),
                      valueColor: const AlwaysStoppedAnimation(AppColors.statusAvailable),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ParkingBookingScreen(lotName: p.name, pricePerHour: price),
                          ),
                        );
                      },
                      child: const Text('Book Slot'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
