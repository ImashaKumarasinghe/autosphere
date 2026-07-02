import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../theme/app_theme.dart';
import '../../models/booking_model.dart';

class ProviderReviewsScreen extends StatelessWidget {
  const ProviderReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final reviewedBookings = appState.bookings.where((b) => b.status == BookingStatus.completed).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Feedback')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Rating Summary Header card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Overall Rating', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text('4.9', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                            const SizedBox(width: 4),
                            Text('/5', style: TextStyle(fontSize: 16, color: AppColors.textSecondary.withOpacity(0.8), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            5,
                            (index) => const Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: Icon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Based on 1.2k reviews', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                      ],
                    ),
                    const Spacer(),
                    // Visual star breakdown bars
                    Column(
                      children: [
                        _ratingBar(5, 0.9),
                        _ratingBar(4, 0.08),
                        _ratingBar(3, 0.01),
                        _ratingBar(2, 0.0),
                        _ratingBar(1, 0.01),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text('Reviews Log', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),

            // 2. Reviews Log list
            reviewedBookings.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No customer reviews logged.')))
                : Column(
                    children: reviewedBookings.map((b) => _reviewCard(context, b)).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(int star, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$star', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(width: 4),
          const Icon(FontAwesomeIcons.solidStar, size: 8, color: Colors.amber),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 80,
              height: 6,
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: const Color(0xFFF1F5F9),
                valueColor: const AlwaysStoppedAnimation(Colors.amber),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard(BuildContext context, BookingModel b) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: b.customerAvatarUrl.isNotEmpty ? NetworkImage(b.customerAvatarUrl) : null,
                  child: b.customerAvatarUrl.isEmpty ? const Icon(FontAwesomeIcons.user, size: 12) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b.customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
                      Text(b.categoryLabel, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Icon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 11),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              b.comment.isNotEmpty ? b.comment : 'No written feedback provided.',
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
            ),
            const Divider(height: 20, color: Color(0xFFF1F3F5), thickness: 1),
            GestureDetector(
              onTap: () {
                // Open dialog to type reply
              },
              child: const Row(
                children: [
                  Icon(FontAwesomeIcons.reply, size: 11, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text('Reply to Feedback', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
