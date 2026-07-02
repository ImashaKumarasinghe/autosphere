import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/mock_data.dart';
import '../../widgets/status_badge.dart';
import '../../models/service_model.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Collect all stations to show on the mock map
    final allServices = [
      ...MockData.fuelStations,
      ...MockData.evStations,
      ...MockData.parkingLots,
      ...MockData.washCenters,
    ];

    return Scaffold(
      body: Stack(
        children: [
          // 1. Mock Map Background (visual painting)
          Container(
            color: const Color(0xFFE2E8F0),
            child: CustomPaint(
              size: Size.infinite,
              painter: MapPainter(),
            ),
          ),

          // 2. Search / Header overlay
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.locationCrosshairs, color: AppColors.primary, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search map locations...',
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.sliders, size: 18, color: AppColors.textSecondary),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),

          // 3. Station cards horizontal slider at bottom
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: allServices.length,
              itemBuilder: (context, index) {
                final s = allServices[index];
                return Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF1F3F5), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 64,
                          height: 64,
                          color: AppColors.primary.withOpacity(0.1),
                          child: Icon(
                            s.category == ServiceCategory.fuel
                                ? FontAwesomeIcons.gasPump
                                : s.category == ServiceCategory.evCharging
                                    ? FontAwesomeIcons.chargingStation
                                    : s.category == ServiceCategory.parking
                                        ? FontAwesomeIcons.squareParking
                                        : FontAwesomeIcons.car,
                            color: AppColors.primary,
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              s.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              s.address,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                StatusBadge(status: s.status),
                                const Spacer(),
                                const Icon(FontAwesomeIcons.locationArrow, size: 10, color: AppColors.primary),
                                const SizedBox(width: 4),
                                Text(
                                  '${s.distanceKm.toStringAsFixed(1)} km',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// Map painting to mock roads, river and parks in the background
class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final parkPaint = Paint()..color = const Color(0xFFDCFCE7);
    final riverPaint = Paint()..color = const Color(0xFFDBEAFE)..style = PaintingStyle.stroke..strokeWidth = 30;
    final roadPaint = Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 20;
    final roadBorderPaint = Paint()..color = const Color(0xFFCBD5E1)..style = PaintingStyle.stroke..strokeWidth = 24;

    // Draw background grid/river/parks
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = const Color(0xFFF1F5F9));
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.4), 100, parkPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 150, parkPaint);

    final riverPath = Path();
    riverPath.moveTo(-50, size.height * 0.3);
    riverPath.quadraticBezierTo(size.width * 0.4, size.height * 0.2, size.width + 50, size.height * 0.5);
    canvas.drawPath(riverPath, riverPaint);

    // Draw grid of roads
    final roadPath = Path();
    roadPath.moveTo(size.width * 0.3, -50);
    roadPath.lineTo(size.width * 0.3, size.height + 50);

    roadPath.moveTo(size.width * 0.7, -50);
    roadPath.lineTo(size.width * 0.7, size.height + 50);

    roadPath.moveTo(-50, size.height * 0.5);
    roadPath.lineTo(size.width + 50, size.height * 0.5);

    roadPath.moveTo(-50, size.height * 0.8);
    roadPath.lineTo(size.width + 50, size.height * 0.8);

    canvas.drawPath(roadPath, roadBorderPaint);
    canvas.drawPath(roadPath, roadPaint);

    // Draw user location pin
    final pinPaint = Paint()..color = AppColors.primary;
    final pinCenter = Offset(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(pinCenter, 12, Paint()..color = AppColors.primary.withOpacity(0.2));
    canvas.drawCircle(pinCenter, 8, pinPaint);
    canvas.drawCircle(pinCenter, 4, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
