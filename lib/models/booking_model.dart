/// Booking Status values exactly as listed in Section 5.8
enum BookingStatus { pending, accepted, inProgress, completed, cancelled }

/// Payment Status values exactly as listed in Section 5.10
enum PaymentStatus { pending, paid, refunded }

extension BookingStatusLabel on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.pending: return 'Pending';
      case BookingStatus.accepted: return 'Accepted';
      case BookingStatus.inProgress: return 'In Progress';
      case BookingStatus.completed: return 'Completed';
      case BookingStatus.cancelled: return 'Cancelled';
    }
  }
}

/// Represents one customer booking of any service type
/// (fuel reservation, EV slot, parking slot, or wash appointment).
class BookingModel {
  final String id;
  final String serviceId;
  final String serviceName;
  final String customerName;
  final DateTime dateTime;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final double price;
  final String vehicleName;
  final double distanceKm;
  final String categoryLabel;
  final String customerAvatarUrl;
  final String comment;

  const BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.customerName,
    required this.dateTime,
    required this.status,
    required this.paymentStatus,
    required this.price,
    this.vehicleName = 'Tesla Model 3',
    this.distanceKm = 1.5,
    this.categoryLabel = 'General Service',
    this.customerAvatarUrl = '',
    this.comment = '',
  });

  BookingModel copyWith({
    String? id,
    String? serviceId,
    String? serviceName,
    String? customerName,
    DateTime? dateTime,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    double? price,
    String? vehicleName,
    double? distanceKm,
    String? categoryLabel,
    String? customerAvatarUrl,
    String? comment,
  }) {
    return BookingModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      customerName: customerName ?? this.customerName,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      price: price ?? this.price,
      vehicleName: vehicleName ?? this.vehicleName,
      distanceKm: distanceKm ?? this.distanceKm,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      customerAvatarUrl: customerAvatarUrl ?? this.customerAvatarUrl,
      comment: comment ?? this.comment,
    );
  }
}

