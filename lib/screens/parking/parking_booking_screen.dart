import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../models/booking_model.dart';
import '../../theme/app_theme.dart';

class ParkingBookingScreen extends StatefulWidget {
  final String lotName;
  final double pricePerHour;
  const ParkingBookingScreen({super.key, required this.lotName, required this.pricePerHour});

  @override
  State<ParkingBookingScreen> createState() => _ParkingBookingScreenState();
}

class _ParkingBookingScreenState extends State<ParkingBookingScreen> {
  int _selectedHours = 2;
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 0;

  final List<String> _dates = ['Today', 'Tomorrow', 'Oct 14', 'Oct 15', 'Oct 16'];
  final List<String> _times = ['08:00 AM', '10:00 AM', '12:00 PM', '02:00 PM', '04:00 PM', '06:00 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking Reservation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Lot header info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                      child: const Icon(FontAwesomeIcons.squareParking, color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.lotName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('Rs. ${widget.pricePerHour.toStringAsFixed(0)} / hour', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Select Date Scroll
            Text('Select Date', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDateIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFFF1F3F5), width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _dates[index],
                        style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 3. Select Entry Time
            Text('Entry Time', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_times.length, (index) {
                final isSelected = _selectedTimeIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTimeIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFFF1F3F5), width: 1.5),
                    ),
                    child: Text(
                      _times[index],
                      style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // 4. Select Duration (Hours)
            Text('Duration (Hours)', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                _counterButton(FontAwesomeIcons.minus, () {
                  if (_selectedHours > 1) setState(() => _selectedHours--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text('$_selectedHours hrs', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary)),
                ),
                _counterButton(FontAwesomeIcons.plus, () {
                  setState(() => _selectedHours++);
                }),
              ],
            ),
            const SizedBox(height: 24),

            // 5. Cost Summary Card
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFECE0).withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFECE0).withOpacity(0.6), width: 1.5),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SUMMARY', style: TextStyle(color: Color(0xFF9E5416), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Parking slot ($_selectedHours hrs)', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text('Rs. ${(widget.pricePerHour * _selectedHours).toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service Fee', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      Text('Rs. 2.50', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFFFFECE0), thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        'Rs. ${(widget.pricePerHour * _selectedHours + 2.50).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF9E5416)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmParking,
                child: const Text('Confirm Slot Reservation'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: const Color(0xFFFFECE0), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, size: 14, color: const Color(0xFF9E5416)),
      ),
    );
  }

  void _confirmParking() {
    final appState = Provider.of<AppState>(context, listen: false);

    final b = BookingModel(
      id: 'pk_${DateTime.now().millisecondsSinceEpoch}',
      serviceId: 'p1',
      serviceName: widget.lotName,
      customerName: 'Emma Watson',
      dateTime: DateTime(2023, 10, 12, 10, 0),
      status: BookingStatus.pending,
      paymentStatus: PaymentStatus.pending,
      price: widget.pricePerHour * _selectedHours,
      vehicleName: appState.selectedVehicle,
      distanceKm: 1.5,
      categoryLabel: 'Parking Slot Booking',
      customerAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    );

    appState.addBooking(b);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Parking slot booked successfully! Pay now to confirm.')),
    );

    Navigator.pop(context);
  }
}
