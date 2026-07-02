import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../services/app_state.dart';
import '../../models/booking_model.dart';
import '../../theme/app_theme.dart';

class BookingRequestsScreen extends StatefulWidget {
  const BookingRequestsScreen({super.key});

  @override
  State<BookingRequestsScreen> createState() => _BookingRequestsScreenState();
}

class _BookingRequestsScreenState extends State<BookingRequestsScreen> {
  String _activeTab = 'All'; // 'All', 'Pending', 'Accepted', 'Completed'

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final bookings = appState.bookings;

    // Filter bookings based on activeTab
    List<BookingModel> filteredList = [];
    if (_activeTab == 'All') {
      filteredList = bookings;
    } else if (_activeTab == 'Pending') {
      filteredList = bookings.where((b) => b.status == BookingStatus.pending).toList();
    } else if (_activeTab == 'Accepted') {
      filteredList = bookings.where((b) => b.status == BookingStatus.accepted || b.status == BookingStatus.inProgress).toList();
    } else if (_activeTab == 'Completed') {
      filteredList = bookings.where((b) => b.status == BookingStatus.completed).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(FontAwesomeIcons.locationDot, color: Color(0xFF9E5416), size: 20),
            const SizedBox(width: 8),
            Text(
              'AutoSphere',
              style: TextStyle(
                color: const Color(0xFF9E5416),
                fontFamily: AppTheme.lightTheme.textTheme.headlineMedium?.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 20, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.bell, size: 20, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Stats Row (Screenshot 2: TOTAL REVENUE & ACTIVE JOBS)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECE0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOTAL REVENUE',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9E5416)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${appState.totalRevenue.toStringAsFiltered()}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF9E5416)),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.chartLine, size: 10, color: Color(0xFF9E5416)),
                              SizedBox(width: 4),
                              Text('+12% this week', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF9E5416))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECE0),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ACTIVE JOBS',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9E5416)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${appState.activeJobsCount}',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF9E5416)),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.clock, size: 10, color: Color(0xFFC2410C)),
                            const SizedBox(width: 4),
                            Text(
                              '${appState.pendingJobsCount} pending approval',
                              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFFC2410C)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Tab chips (All, Pending, Accepted, Completed)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _tabChip('All'),
                  _tabChip('Pending'),
                  _tabChip('Accepted'),
                  _tabChip('Completed'),
                ],
              ),
            ),
          ),

          // 3. Main Bookings list
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.inbox, size: 40, color: AppColors.textSecondary.withOpacity(0.3)),
                        const SizedBox(height: 12),
                        const Text('No bookings in this tab', style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final b = filteredList[index];
                      return _bookingCard(context, appState, b);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _tabChip(String label) {
    final isSelected = _activeTab == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9E5416) : const Color(0xFFFFECE0).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF9E5416),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _bookingCard(BuildContext context, AppState appState, BookingModel b) {
    // Determine card shapes and action buttons based on status (Screenshot 2 exact match)
    if (b.status == BookingStatus.pending) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: b.customerAvatarUrl.isNotEmpty ? NetworkImage(b.customerAvatarUrl) : null,
                    child: b.customerAvatarUrl.isEmpty ? const Icon(FontAwesomeIcons.user, size: 14) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.calendar, size: 11, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('MMM d, yyyy • hh:mm a').format(b.dateTime),
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _badgeWidget('PENDING', const Color(0xFFFFE2D1), const Color(0xFF9E5416)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF8F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFECE0), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.plug, color: Color(0xFF9E5416), size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${b.categoryLabel} - ${b.vehicleName} • ${b.distanceKm} miles away',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ),
                    Text(
                      '\$${b.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9E5416),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => appState.acceptBooking(b.id),
                      child: const Text('Accept', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      onPressed: () => appState.declineBooking(b.id),
                      child: const Text('Decline', style: TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (b.status == BookingStatus.accepted) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: b.customerAvatarUrl.isNotEmpty ? NetworkImage(b.customerAvatarUrl) : null,
                    child: b.customerAvatarUrl.isEmpty ? const Icon(FontAwesomeIcons.user, size: 14) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.calendar, size: 11, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('MMM d, yyyy • hh:mm a').format(b.dateTime),
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _badgeWidget('ACCEPTED', const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.route, color: Color(0xFF1E40AF), size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${b.categoryLabel} - ${b.vehicleName} • ${b.distanceKm} miles away',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ),
                    Text(
                      '\$${b.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0056C6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => appState.completeBooking(b.id),
                      child: const Text('Mark as Completed', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.locationArrow, size: 16, color: AppColors.textPrimary),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else if (b.status == BookingStatus.completed) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: b.customerAvatarUrl.isNotEmpty ? NetworkImage(b.customerAvatarUrl) : null,
                    child: b.customerAvatarUrl.isEmpty ? const Icon(FontAwesomeIcons.user, size: 14) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Text(
                          'Completed Oct 23 • \$${b.price.toStringAsFixed(2)}',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Icon(FontAwesomeIcons.solidCircleCheck, color: Color(0xFF16A34A), size: 22),
                ],
              ),
              if (b.comment.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  '"${b.comment}"',
                  style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Container();
  }

  Widget _badgeWidget(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }
}

extension DoubleFormat on double {
  String toStringAsFiltered() {
    // If double represents 4850, format with comma => 4,850.00
    final format = NumberFormat("#,##0.00", "en_US");
    return format.format(this);
  }
}
