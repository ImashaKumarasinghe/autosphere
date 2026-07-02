import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/app_state.dart';

class ReviewsScreen extends StatefulWidget {
  final String bookingId;
  final String serviceName;

  const ReviewsScreen({
    super.key,
    required this.bookingId,
    required this.serviceName,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Text(
              'How was your service at',
              style: TextStyle(color: AppColors.textSecondary.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              widget.serviceName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // 1. Star selection row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starPos = index + 1;
                final active = starPos <= _rating;
                return IconButton(
                  icon: Icon(
                    active ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                    color: Colors.amber,
                    size: 36,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = starPos;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(
              _ratingLabel(_rating),
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 15),
            ),
            const SizedBox(height: 28),

            // 2. Feedback comments text box
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tell us more about your experience',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Excellent service, friendly staff, highly recommended...',
              ),
            ),
            const SizedBox(height: 32),

            // 3. Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                child: const Text('Submit Review'),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _ratingLabel(int stars) {
    switch (stars) {
      case 1: return 'Terrible';
      case 2: return 'Poor';
      case 3: return 'Average';
      case 4: return 'Very Good';
      case 5: return 'Excellent';
      default: return 'Excellent';
    }
  }

  void _submitReview() {
    final comment = _commentController.text.trim();
    final appState = Provider.of<AppState>(context, listen: false);

    // Save review in app state
    appState.addBookingComment(widget.bookingId, comment.isNotEmpty ? comment : 'No comment provided.');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(FontAwesomeIcons.circleCheck, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Review submitted! Thank you.'),
          ],
        ),
        backgroundColor: AppColors.statusAvailable,
      ),
    );

    Navigator.pop(context);
  }
}
