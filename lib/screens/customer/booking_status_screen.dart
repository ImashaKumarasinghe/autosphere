import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../services/app_state.dart';
import '../../models/booking_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge.dart';
import 'payment_screen.dart';
import 'reviews_screen.dart';

class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final bookings = appState.bookings;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(text: 'All Bookings'),
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _bookingsList(context, bookings),
            _bookingsList(context, bookings.where((b) => b.status != BookingStatus.completed && b.status != BookingStatus.cancelled).toList()),
            _bookingsList(context, bookings.where((b) => b.status == BookingStatus.completed).toList()),
          ],
        ),
      ),
    );
  }

  Widget _bookingsList(BuildContext context, List<BookingModel> list) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.calendarXmark, size: 48, color: AppColors.textSecondary.withOpacity(0.3)),
            const SizedBox(height: 16),
            const Text('No bookings found', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final b = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      b.categoryLabel,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                    ),
                    _badgeForStatus(b.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  b.serviceName,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const Divider(height: 24, color: Color(0xFFF1F3F5), thickness: 1),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.clock, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('EEE, MMM d, yyyy • hh:mm a').format(b.dateTime),
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.car, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      b.vehicleName,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Price', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                        Text(
                          'Rs. ${b.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
                        ),
                      ],
                    ),
                    _actionButton(context, b),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _badgeForStatus(BookingStatus status) {
    Color bg;
    Color text;
    String label;

    switch (status) {
      case BookingStatus.pending:
        bg = AppColors.statusLimited.withOpacity(0.1);
        text = AppColors.statusLimited;
        label = 'Pending';
        break;
      case BookingStatus.accepted:
        bg = AppColors.statusInfo.withOpacity(0.1);
        text = AppColors.statusInfo;
        label = 'Accepted';
        break;
      case BookingStatus.inProgress:
        bg = AppColors.primary.withOpacity(0.1);
        text = AppColors.primary;
        label = 'In Progress';
        break;
      case BookingStatus.completed:
        bg = AppColors.statusAvailable.withOpacity(0.1);
        text = AppColors.statusAvailable;
        label = 'Completed';
        break;
      case BookingStatus.cancelled:
        bg = AppColors.statusClosed.withOpacity(0.1);
        text = AppColors.statusClosed;
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  Widget _actionButton(BuildContext context, BookingModel b) {
    if (b.status == BookingStatus.completed) {
      if (b.comment.isNotEmpty) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: null,
          child: const Text('Reviewed', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        );
      }
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReviewsScreen(bookingId: b.id, serviceName: b.serviceName),
            ),
          );
        },
        child: const Text('Leave Review', style: TextStyle(fontSize: 13)),
      );
    } else if (b.paymentStatus == PaymentStatus.pending && b.status != BookingStatus.cancelled) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PaymentScreen(bookingId: b.id, price: b.price, description: b.categoryLabel),
            ),
          );
        },
        child: const Text('Pay Now', style: TextStyle(fontSize: 13)),
      );
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: () {
        // Show status helper info sheet
      },
      child: const Text('Details', style: TextStyle(fontSize: 13, color: AppColors.textPrimary)),
    );
  }
}
