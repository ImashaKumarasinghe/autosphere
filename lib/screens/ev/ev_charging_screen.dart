import 'package:flutter/material.dart';
import '../../services/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge.dart';

/// Screens #4-5: EV Charging Stations + Charging Slot Booking (Section 5.3)
class EvChargingScreen extends StatelessWidget {
  const EvChargingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stations = MockData.evStations;
    return Scaffold(
      appBar: AppBar(title: const Text('EV Charging Stations')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final s = stations[index];
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
                      Expanded(child: Text(s.name, style: Theme.of(context).textTheme.headlineSmall)),
                      StatusBadge(status: s.status),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(s.address, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  _detailRow('Charger Type', s.details['chargerType'].toString()),
                  _detailRow('Speed', s.details['speed'].toString()),
                  _detailRow('Available Slots', s.details['availableSlots'].toString()),
                  _detailRow('Price', 'Rs. ${s.details['pricePerKwh']} / kWh'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showReserveSheet(context, s.name),
                      child: const Text('Reserve Slot'),
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  // Screen #5: Charging Slot Booking, shown as a bottom sheet to keep the
  // flow quick (tap Reserve -> pick a time -> confirm).
  void _showReserveSheet(BuildContext context, String stationName) {
    TimeOfDay? selectedTime;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) => Padding(
            padding: EdgeInsets.only(
              left: 20, right: 20, top: 24,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reserve at $stationName', style: Theme.of(ctx).textTheme.headlineSmall),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  icon: const Icon(Icons.access_time),
                  label: Text(selectedTime == null ? 'Select Time' : selectedTime!.format(ctx)),
                  onPressed: () async {
                    final time = await showTimePicker(context: ctx, initialTime: TimeOfDay.now());
                    if (time != null) setState(() => selectedTime = time);
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedTime == null ? null : () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Charging slot reserved for ${selectedTime!.format(context)}')),
                      );
                    },
                    child: const Text('Confirm Reservation'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
