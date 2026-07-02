import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';

class AvailabilityManagementScreen extends StatefulWidget {
  const AvailabilityManagementScreen({super.key});

  @override
  State<AvailabilityManagementScreen> createState() => _AvailabilityManagementScreenState();
}

class _AvailabilityManagementScreenState extends State<AvailabilityManagementScreen> {
  // Mock availability states
  bool _petrol92 = true;
  bool _petrol95 = true;
  bool _diesel = false;

  int _chargerSlots = 3;
  int _parkingSlots = 34;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Availability')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Fuel Station Section
            _sectionHeader('Fuel Station Availability'),
            Card(
              child: Column(
                children: [
                  _switchTile('Petrol 92', _petrol92, (v) => setState(() => _petrol92 = v)),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _switchTile('Petrol 95', _petrol95, (v) => setState(() => _petrol95 = v)),
                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFF1F3F5)),
                  _switchTile('Diesel', _diesel, (v) => setState(() => _diesel = v)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. EV Charging Section
            _sectionHeader('EV Charging Availability'),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Available Chargers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Row(
                      children: [
                        _counterButton(FontAwesomeIcons.minus, () {
                          if (_chargerSlots > 0) setState(() => _chargerSlots--);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('$_chargerSlots', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        _counterButton(FontAwesomeIcons.plus, () {
                          setState(() => _chargerSlots++);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 3. Parking Section
            _sectionHeader('Parking Slot Management'),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Available Parking Spaces', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Row(
                      children: [
                        _counterButton(FontAwesomeIcons.minus, () {
                          if (_parkingSlots > 0) setState(() => _parkingSlots--);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('$_parkingSlots', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        _counterButton(FontAwesomeIcons.plus, () {
                          setState(() => _parkingSlots++);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Availability statuses updated successfully!'),
                      backgroundColor: AppColors.statusAvailable,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF9E5416)),
      ),
    );
  }

  Widget _switchTile(String title, bool val, ValueChanged<bool> onChanged) {
    return SwitchListTile.adaptive(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
      value: val,
      activeColor: AppColors.primary,
      onChanged: onChanged,
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFECE0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 12, color: const Color(0xFF9E5416)),
      ),
    );
  }
}
