/// The type of service, matching Section 5.1 Service Categories
enum ServiceCategory { fuel, evCharging, parking, wash, detailing, accessories }

/// The provider's current availability status (Section 4 Status Colors)
enum ServiceStatus { available, limited, closed, info }

/// Represents ONE service provider location, e.g. a single fuel station,
/// a single EV charging hub, a single parking lot, or a wash center.
///
/// This one model is reused across Fuel, EV, Parking, and Wash modules
/// (Sections 5.2 - 5.5) since they all share the same basic shape:
/// name, location, rating, price, availability.
class ServiceModel {
  final String id;
  final String name;
  final ServiceCategory category;
  final ServiceStatus status;
  final String address;
  final double distanceKm;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String openingHours;
  final Map<String, dynamic> details; // category-specific extra info

  const ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    required this.address,
    required this.distanceKm,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.openingHours,
    this.details = const {},
  });

  /// Converts backend JSON into a ServiceModel. When you connect a real API,
  /// you'll call: ServiceModel.fromJson(jsonResponse)
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      category: ServiceCategory.values.firstWhere((e) => e.name == json['category']),
      status: ServiceStatus.values.firstWhere((e) => e.name == json['status']),
      address: json['address'],
      distanceKm: (json['distanceKm'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      imageUrl: json['imageUrl'],
      openingHours: json['openingHours'],
      details: json['details'] ?? {},
    );
  }
}
