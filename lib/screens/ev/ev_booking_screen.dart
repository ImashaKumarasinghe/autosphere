import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../models/booking_model.dart';
import '../../theme/app_theme.dart';

class EvBookingScreen extends StatefulWidget {
  final String stationName;
  const EvBookingScreen({super.key, required this.stationName});

  @override
  State<EvBookingScreen> createState() => _EvBookingScreenState();
}

class _EvBookingScreenState extends State<EvBookingScreen> {
  int _selectedDateIndex = 0; // 0 = Oct 12, 1 = Oct 13, etc
  int _selectedTimeIndex = 1; // 1 = 10:30 AM

  final List<Map<String, String>> _dates = [
    {'month': 'OCT', 'dayNum': '12', 'dayName': 'SAT'},
    {'month': 'OCT', 'dayNum': '13', 'dayName': 'SUN'},
    {'month': 'OCT', 'dayNum': '14', 'dayName': 'MON'},
    {'month': 'OCT', 'dayNum': '15', 'dayName': 'TUE'},
    {'month': 'OCT', 'dayNum': '16', 'dayName': 'WED'},
  ];

  final List<Map<String, dynamic>> _times = [
    {'time': '09:00 AM', 'available': true},
    {'time': '10:30 AM', 'available': true},
    {'time': '11:00 AM', 'available': false}, // Disabled
    {'time': '12:30 PM', 'available': true},
    {'time': '02:00 PM', 'available': true},
    {'time': '03:30 PM', 'available': true},
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(FontAwesomeIcons.locationDot, color: Color(0xFF9E5416), size: 12),
                SizedBox(width: 4),
                Text('Tech Park, Hub 1', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
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
            // 1. Station Details Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFECE0).withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFECE0), width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFECE0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(FontAwesomeIcons.chargingStation, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.stationName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _badge('FAST CHARGER', const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
                            const SizedBox(width: 8),
                            _badge('⚡ 150kW+', const Color(0xFFFFECE0), AppColors.primary),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Your Vehicle Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Vehicle', style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                  onPressed: () {},
                  child: const Text('CHANGE', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _vehicleCard(
                    'Model S Plaid',
                    appState.selectedVehicle == 'Model S Plaid',
                    () => appState.selectVehicle('Model S Plaid'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _vehicleCard(
                    'Daily Commuter',
                    appState.selectedVehicle == 'Daily Commuter',
                    () => appState.selectVehicle('Daily Commuter'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 3. Select Date
            Text('Select Date', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            SizedBox(
              height: 72,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final d = _dates[index];
                  final isSelected = _selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      width: 58,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : const Color(0xFFF1F3F5),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            d['month']!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white70 : AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            d['dayNum']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            d['dayName']!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white70 : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // 4. Time Slot Grid
            Text('Time Slot', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.3,
              ),
              itemCount: _times.length,
              itemBuilder: (context, index) {
                final t = _times[index];
                final isSelected = _selectedTimeIndex == index;
                final available = t['available'] as bool;

                return GestureDetector(
                  onTap: available
                      ? () {
                          setState(() {
                            _selectedTimeIndex = index;
                          });
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: !available
                          ? const Color(0xFFF8FAFC)
                          : isSelected
                              ? AppColors.primary
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: !available
                            ? const Color(0xFFE2E8F0)
                            : isSelected
                                ? AppColors.primary
                                : const Color(0xFFF1F3F5),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      t['time']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: !available
                            ? const Color(0xFF94A3B8)
                            : isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                        decoration: !available ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // 5. Summary Card (Screenshot 5 Summary match)
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
                  const Text(
                    'SUMMARY',
                    style: TextStyle(color: Color(0xFF9E5416), fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Charging (60 kWh)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                      Text('\$24.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service Fee', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                      Text('\$2.50', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFFFFECE0), thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const Text(
                        '\$26.50',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF9E5416)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 6. Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _confirmSlot,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Confirm Slot', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(FontAwesomeIcons.chevronRight, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleCard(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFECE0) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFF1F3F5),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              FontAwesomeIcons.chargingStation,
              color: isSelected ? AppColors.primary : AppColors.textSecondary.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 9),
      ),
    );
  }

  void _confirmSlot() {
    final appState = Provider.of<AppState>(context, listen: false);

    // Create a new BookingModel and add it
    final b = BookingModel(
      id: 'eb_${DateTime.now().millisecondsSinceEpoch}',
      serviceId: 'e1',
      serviceName: widget.stationName,
      customerName: 'Emma Watson',
      dateTime: DateTime(2023, 10, 12, 10, 30),
      status: BookingStatus.pending,
      paymentStatus: PaymentStatus.pending,
      price: 24.00,
      vehicleName: appState.selectedVehicle,
      distanceKm: 0.9,
      categoryLabel: 'EV Quick Charge',
      customerAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    );

    appState.addBooking(b);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('EV Charger Reservation slot created. Pay now to confirm!'),
        backgroundColor: AppColors.statusInfo,
      ),
    );

    Navigator.pop(context);
  }
}
