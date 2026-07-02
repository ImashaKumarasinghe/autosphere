import '../models/service_model.dart';

/// TEMPORARY sample data. This lets you build and test every screen
/// before your backend API exists. Later, replace calls to
/// MockData.fuelStations with a real http.get() call to your API
/// (see services/api_service.dart for where that would go).
class MockData {
  static List<ServiceModel> fuelStations = [
    const ServiceModel(
      id: 'f1', name: 'CeyPetro Fuel Station', category: ServiceCategory.fuel,
      status: ServiceStatus.available, address: 'Galle Road, Colombo 03',
      distanceKm: 1.2, rating: 4.5, reviewCount: 128,
      imageUrl: '', openingHours: '24 Hours',
      details: {'fuelTypes': ['Petrol 92', 'Petrol 95', 'Diesel']},
    ),
    const ServiceModel(
      id: 'f2', name: 'IOC Fuel Point', category: ServiceCategory.fuel,
      status: ServiceStatus.limited, address: 'Duplication Road, Colombo 04',
      distanceKm: 2.8, rating: 4.1, reviewCount: 76,
      imageUrl: '', openingHours: '6:00 AM - 10:00 PM',
      details: {'fuelTypes': ['Petrol 92', 'Diesel']},
    ),
  ];

  static List<ServiceModel> evStations = [
    const ServiceModel(
      id: 'e1', name: 'VoltCharge Hub', category: ServiceCategory.evCharging,
      status: ServiceStatus.available, address: 'Independence Ave, Colombo 07',
      distanceKm: 0.9, rating: 4.8, reviewCount: 54,
      imageUrl: '', openingHours: '24 Hours',
      details: {'chargerType': 'Type 2 / CCS', 'speed': '60 kW', 'availableSlots': 3, 'pricePerKwh': 45},
    ),
  ];

  static List<ServiceModel> parkingLots = [
    const ServiceModel(
      id: 'p1', name: 'City Center Parking', category: ServiceCategory.parking,
      status: ServiceStatus.available, address: 'Colpetty, Colombo 03',
      distanceKm: 1.5, rating: 4.3, reviewCount: 210,
      imageUrl: '', openingHours: '24 Hours',
      details: {'capacity': 120, 'available': 34, 'pricePerHour': 100},
    ),
  ];

  static List<ServiceModel> washCenters = [
    const ServiceModel(
      id: 'w1', name: 'ShineMax Car Wash', category: ServiceCategory.wash,
      status: ServiceStatus.available, address: 'Havelock Road, Colombo 05',
      distanceKm: 3.1, rating: 4.6, reviewCount: 88,
      imageUrl: '', openingHours: '8:00 AM - 8:00 PM',
      details: {'packages': ['Normal Wash', 'Full Wash', 'Interior Cleaning', 'Detailing']},
    ),
  ];
}
