import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class AppState extends ChangeNotifier {
  // Toggle between Customer and Provider Mode
  bool _isProviderMode = false;
  bool get isProviderMode => _isProviderMode;

  void toggleRole() {
    _isProviderMode = !_isProviderMode;
    notifyListeners();
  }

  void setRole(bool isProvider) {
    _isProviderMode = isProvider;
    notifyListeners();
  }

  // Business Status (Screenshot 4)
  bool _isBusinessOpen = true;
  bool get isBusinessOpen => _isBusinessOpen;

  void toggleBusinessStatus(bool val) {
    _isBusinessOpen = val;
    notifyListeners();
  }

  // Active bookings list
  final List<BookingModel> _bookings = [
    BookingModel(
      id: 'b1',
      serviceId: 'e1',
      serviceName: 'VoltCharge Hub',
      customerName: 'Marcus Chen',
      dateTime: DateTime(2023, 10, 24, 10, 30),
      status: BookingStatus.pending,
      paymentStatus: PaymentStatus.pending,
      price: 45.00,
      vehicleName: 'Tesla Model 3',
      distanceKm: 2.4,
      categoryLabel: 'EV Quick Charge',
      customerAvatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
    ),
    BookingModel(
      id: 'b2',
      serviceId: 'f1',
      serviceName: 'CeyPetro Fuel Station',
      customerName: 'Sarah Jennings',
      dateTime: DateTime(2023, 10, 24, 14, 0),
      status: BookingStatus.accepted,
      paymentStatus: PaymentStatus.paid,
      price: 120.00,
      vehicleName: 'Audi Q7',
      distanceKm: 4.1,
      categoryLabel: 'Full Tire Inspection',
      customerAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    ),
    BookingModel(
      id: 'b3',
      serviceId: 'w1',
      serviceName: 'ShineMax Car Wash',
      customerName: 'Robert King',
      dateTime: DateTime(2023, 10, 23, 16, 30),
      status: BookingStatus.completed,
      paymentStatus: PaymentStatus.paid,
      price: 85.00,
      vehicleName: 'BMW 5 Series',
      distanceKm: 1.5,
      categoryLabel: 'Premium Car Wash',
      customerAvatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      comment: 'Excellent service, arrived on time.',
    ),
  ];

  List<BookingModel> get bookings => _bookings;

  // Active Provider Offers / Promotions
  final List<Map<String, dynamic>> _offers = [
    {
      'id': 'o1',
      'title': 'Supercharge Discount',
      'description': '15% off EV Quick Charging on weekends',
      'discount': '15%',
      'startDate': 'Oct 25, 2023',
      'endDate': 'Nov 05, 2023',
    },
    {
      'id': 'o2',
      'title': 'Premium Detailing Combo',
      'description': 'Rs. 1,000 off on Full Detailing Package',
      'discount': 'Rs. 1,000',
      'startDate': 'Oct 20, 2023',
      'endDate': 'Oct 30, 2023',
    }
  ];

  List<Map<String, dynamic>> get offers => _offers;

  void addOffer(Map<String, dynamic> newOffer) {
    _offers.insert(0, newOffer);
    notifyListeners();
  }

  // Customer vehicle selection (for EV Slot booking selection)
  String _selectedVehicle = 'Model S Plaid';
  String get selectedVehicle => _selectedVehicle;

  void selectVehicle(String name) {
    _selectedVehicle = name;
    notifyListeners();
  }

  // Methods to manipulate bookings
  void addBooking(BookingModel booking) {
    _bookings.insert(0, booking);
    notifyListeners();
  }

  void acceptBooking(String bookingId) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(status: BookingStatus.accepted);
      notifyListeners();
    }
  }

  void declineBooking(String bookingId) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(status: BookingStatus.cancelled);
      notifyListeners();
    }
  }

  void completeBooking(String bookingId) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(
        status: BookingStatus.completed,
        paymentStatus: PaymentStatus.paid,
      );
      notifyListeners();
    }
  }

  void addBookingComment(String bookingId, String commentText) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      _bookings[index] = _bookings[index].copyWith(comment: commentText);
      notifyListeners();
    }
  }

  // Provider statistics calculations
  double get totalRevenue {
    // Basic sum of completed bookings revenue + mock baseline
    double base = 4850.00;
    double computed = 0.0;
    for (var b in _bookings) {
      if (b.status == BookingStatus.completed && b.id != 'b3') {
        computed += b.price;
      }
    }
    return base + computed;
  }

  int get activeJobsCount {
    return _bookings.where((b) => b.status == BookingStatus.accepted || b.status == BookingStatus.inProgress).length + 12; // matching active jobs stats (14 baseline)
  }

  int get pendingJobsCount {
    return _bookings.where((b) => b.status == BookingStatus.pending).length;
  }

  int get completedJobsCount {
    return _bookings.where((b) => b.status == BookingStatus.completed).length + 1200; // baseline 1.2k (Screenshot 4)
  }
}
