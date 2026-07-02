import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/service_model.dart';

/// A small colored pill showing "Available", "Limited", "Closed" etc.
/// Used on: Fuel listing, EV charging, Parking, Wash cards, Provider dashboard.
class StatusBadge extends StatelessWidget {
  final ServiceStatus status;
  const StatusBadge({super.key, required this.status});

  Color get _color {
    switch (status) {
      case ServiceStatus.available: return AppColors.statusAvailable;
      case ServiceStatus.limited: return AppColors.statusLimited;
      case ServiceStatus.closed: return AppColors.statusClosed;
      case ServiceStatus.info: return AppColors.statusInfo;
    }
  }

  String get _label {
    switch (status) {
      case ServiceStatus.available: return 'Available';
      case ServiceStatus.limited: return 'Limited';
      case ServiceStatus.closed: return 'Closed';
      case ServiceStatus.info: return 'Info';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6, height: 6,
            decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(_label, style: TextStyle(color: _color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
