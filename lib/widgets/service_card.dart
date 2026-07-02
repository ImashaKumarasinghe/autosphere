import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/service_model.dart';
import '../theme/app_theme.dart';
import 'status_badge.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Beautiful service category thumbnail image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_categoryImageUrl(service.category)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        StatusBadge(status: service.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.address,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.locationArrow, size: 10, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          '${service.distanceKm.toStringAsFixed(1)} km',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                        const SizedBox(width: 16),
                        const Icon(FontAwesomeIcons.solidStar, size: 11, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${service.rating} (${service.reviewCount})',
                          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _categoryImageUrl(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.fuel:
        return 'https://images.unsplash.com/photo-1527018601619-a508a2be00cd?w=150';
      case ServiceCategory.evCharging:
        return 'https://images.unsplash.com/photo-1563720223185-11003d516935?w=150';
      case ServiceCategory.parking:
        return 'https://images.unsplash.com/photo-1506521788723-868128859a9e?w=150';
      case ServiceCategory.wash:
        return 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=150';
      case ServiceCategory.detailing:
        return 'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=150';
      case ServiceCategory.accessories:
        return 'https://images.unsplash.com/photo-1486006920555-c77dce18193b?w=150';
    }
  }
}
