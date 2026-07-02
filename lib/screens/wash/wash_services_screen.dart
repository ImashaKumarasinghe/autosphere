import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../models/booking_model.dart';
import '../../theme/app_theme.dart';

class WashServicesScreen extends StatefulWidget {
  const WashServicesScreen({super.key});

  @override
  State<WashServicesScreen> createState() => _WashServicesScreenState();
}

class _WashServicesScreenState extends State<WashServicesScreen> {
  String _selectedPackage = 'Full'; // 'Normal', 'Full', 'Interior'
  int _selectedDateIndex = 1; // 1 = TUE 13
  int _selectedTimeIndex = 1; // 1 = 11:30 AM

  final List<Map<String, String>> _dates = [
    {'dayName': 'MON', 'dayNum': '12'},
    {'dayName': 'TUE', 'dayNum': '13'},
    {'dayName': 'WED', 'dayNum': '14'},
    {'dayName': 'THU', 'dayNum': '15'},
    {'dayName': 'FRI', 'dayNum': '16'},
  ];

  final List<String> _times = ['09:00 AM', '11:30 AM', '02:00 PM', '04:30 PM', '06:00 PM'];

  double get _packagePrice {
    switch (_selectedPackage) {
      case 'Normal': return 25.00;
      case 'Full': return 55.00;
      case 'Interior': return 40.00;
      default: return 55.00;
    }
  }

  String get _packageDescription {
    switch (_selectedPackage) {
      case 'Normal': return 'Normal Wash';
      case 'Full': return 'Full Wash';
      case 'Interior': return 'Interior Only';
      default: return 'Full Wash';
    }
  }

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
            // 1. Premium Detailing Image Banner Card
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=600'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'PREMIUM SERVICE',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Advanced Detailing',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 2. Choose Package Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Choose Package', style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                  onPressed: () {},
                  child: const Text('Compare All', style: TextStyle(color: Color(0xFF9E5416), fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Normal card
                Expanded(
                  child: _packageCardGrid(
                    'Normal',
                    'Quick external wash\n& shine',
                    '25',
                    FontAwesomeIcons.droplet,
                    const Color(0xFF3B82F6),
                    _selectedPackage == 'Normal',
                  ),
                ),
                const SizedBox(width: 12),
                // Full card (selected)
                Expanded(
                  child: _packageCardGrid(
                    'Full',
                    'Exterior + Interior +\nWaxing',
                    '55',
                    FontAwesomeIcons.clockRotateLeft,
                    AppColors.primary,
                    _selectedPackage == 'Full',
                    isMostPopular: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Interior only card
            _packageCardFullWidth(
              'Interior',
              'Interior Only',
              'Deep clean for seats and dash',
              '40',
              FontAwesomeIcons.chair,
              _selectedPackage == 'Interior',
            ),
            const SizedBox(height: 24),

            // 3. Schedule Service Date
            Text('Schedule Service', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            SizedBox(
              height: 68,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final d = _dates[index];
                  final isSelected = _selectedDateIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDateIndex = index),
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
                            d['dayName']!,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isSelected ? Colors.white70 : AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            d['dayNum']!,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // 4. Time Slot Selector
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
                      color: isSelected ? AppColors.primary : const Color(0xFFFFF2EB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : const Color(0xFFFFECE0),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _times[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF9E5416),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // 5. Cost Summary
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F3F5), width: 1.5),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.bagShopping, size: 14, color: AppColors.primary),
                      const SizedBox(width: 8),
                      const Text('Subtotal', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('\$${_packagePrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      SizedBox(width: 22),
                      Text('Service Fee', style: TextStyle(color: AppColors.textSecondary)),
                      Spacer(),
                      Text('\$2.50', style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFFF1F3F5), thickness: 1),
                  Row(
                    children: [
                      const SizedBox(width: 22),
                      const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                      const Spacer(),
                      Text(
                        '\$${(_packagePrice + 2.50).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF9E5416)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 6. Confirm Booking action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _confirmBooking,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Confirm Booking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(FontAwesomeIcons.arrowRight, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _packageCardGrid(
    String title,
    String subtitle,
    String price,
    IconData icon,
    Color iconColor,
    bool isSelected, {
    bool isMostPopular = false,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPackage = title),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : const Color(0xFFFFECE0).withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? const Color(0xFF9E5416) : const Color(0xFFFFECE0).withOpacity(0.6),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFECE0) : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, height: 1.2),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$$price',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF9E5416)),
                ),
              ],
            ),
          ),
          if (isMostPopular)
            Positioned(
              top: -10,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF9E5416),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'MOST POPULAR',
                  style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _packageCardFullWidth(
    String packageVal,
    String title,
    String subtitle,
    String price,
    IconData icon,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPackage = packageVal),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFFFECE0).withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF9E5416) : const Color(0xFFFFECE0).withOpacity(0.6),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFECE0) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(FontAwesomeIcons.chair, color: Color(0xFF64748B), size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
            Text(
              '\$$price',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF9E5416)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmBooking() {
    final appState = Provider.of<AppState>(context, listen: false);

    // Create a new BookingModel and add it
    final b = BookingModel(
      id: 'ws_${DateTime.now().millisecondsSinceEpoch}',
      serviceId: 'w1',
      serviceName: 'ShineMax Car Wash',
      customerName: 'Emma Watson',
      dateTime: DateTime(2023, 10, 13, 11, 30),
      status: BookingStatus.pending,
      paymentStatus: PaymentStatus.pending,
      price: _packagePrice,
      vehicleName: appState.selectedVehicle,
      distanceKm: 3.1,
      categoryLabel: _packageDescription,
      customerAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    );

    appState.addBooking(b);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Wash service booked successfully! Proceed to payments to confirm.'),
        backgroundColor: AppColors.statusInfo,
      ),
    );

    Navigator.pop(context);
  }
}
