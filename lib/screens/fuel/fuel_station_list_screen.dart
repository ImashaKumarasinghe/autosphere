import 'package:flutter/material.dart';
import '../../services/mock_data.dart';
import '../../widgets/service_card.dart';
import 'fuel_station_details_screen.dart';

class FuelStationListScreen extends StatelessWidget {
  const FuelStationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stations = MockData.fuelStations;
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel Stations')),
      body: stations.isEmpty
          ? const Center(child: Text('No fuel stations found nearby'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: stations.length,
              itemBuilder: (context, index) {
                final station = stations[index];
                return ServiceCard(
                  service: station,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FuelStationDetailsScreen(station: station)),
                  ),
                );
              },
            ),
    );
  }
}
