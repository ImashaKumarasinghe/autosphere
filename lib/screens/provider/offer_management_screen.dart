import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../services/app_state.dart';
import '../../theme/app_theme.dart';

class OfferManagementScreen extends StatelessWidget {
  const OfferManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final offers = appState.offers;

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
            icon: const Icon(FontAwesomeIcons.bell, size: 20, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header text
            Text(
              'Optimize your service offers and track performance metrics.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary.withOpacity(0.8), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),

            // 1. Business Performance (Screenshot 3 Chart Card)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Business Performance',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFECE0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'LIVE UPDATES',
                            style: TextStyle(color: Color(0xFF9E5416), fontSize: 9, fontWeight: FontWeight.bold),
                          ),
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
                            const Text('MONTHLY REVENUE', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            const Text(
                              '\$42,850.00',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF9E5416)),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(FontAwesomeIcons.arrowTrendUp, size: 10, color: Color(0xFF16A34A)),
                              SizedBox(width: 4),
                              Text('12%', style: TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Weekly chart custom painted
                    SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: WeeklyBarPainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Rating Box (Screenshot 3 Blue Card)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF538EFB),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PROVIDER RATING',
                    style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        '4.9',
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '/ 5',
                        style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(FontAwesomeIcons.solidStar, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Top 5% of Service Providers this month.',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Offer Management Header and button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Offer Management', style: Theme.of(context).textTheme.headlineSmall),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(FontAwesomeIcons.plus, size: 14),
                  label: const Text('Add New Offer', style: TextStyle(fontSize: 12)),
                  onPressed: () => _showAddOfferModal(context, appState),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 4. Offers list
            ...offers.map((offer) => Card(
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
                              offer['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.orangeLight, borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                offer['discount'],
                                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          offer['description'],
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                        const Divider(height: 24, color: Color(0xFFF1F3F5), thickness: 1),
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.calendarCheck, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 6),
                            Text(
                              'Active: ${offer['startDate']} - ${offer['endDate']}',
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showAddOfferModal(BuildContext context, AppState appState) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final discountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create New Offer', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Offer Title (e.g. Summer Sparkle)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                decoration: const InputDecoration(hintText: 'Description (e.g. 20% off all wash packages)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: discountController,
                decoration: const InputDecoration(hintText: 'Discount value (e.g. 20% or Rs. 500)'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    final desc = descController.text.trim();
                    final disc = discountController.text.trim();

                    if (title.isNotEmpty && desc.isNotEmpty && disc.isNotEmpty) {
                      appState.addOffer({
                        'id': DateTime.now().toString(),
                        'title': title,
                        'description': desc,
                        'discount': disc,
                        'startDate': 'Today',
                        'endDate': 'Nov 30, 2023',
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('New promotion added successfully!'), backgroundColor: AppColors.statusAvailable),
                      );
                    }
                  },
                  child: const Text('Publish Promotion'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Painter to draw the visual weekly bar chart
class WeeklyBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double spacing = size.width / 7;
    final double barWidth = spacing * 0.4;
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final heights = [0.4, 0.6, 0.5, 0.75, 0.9, 0.7, 0.6]; // Friday is highlighted at 0.9

    for (int i = 0; i < 7; i++) {
      final double x = spacing * i + (spacing - barWidth) / 2;
      final double height = size.height * 0.75 * heights[i];
      final double y = size.height * 0.8 - height;

      // Color selection (Friday highlighted in Orange, others in light grey-blue)
      Paint paint = Paint()
        ..color = (i == 4) ? AppColors.primary : const Color(0xFFE2E8F0)
        ..style = PaintingStyle.fill;

      // Draw rounded rectangle for bar
      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, height),
        const Radius.circular(6),
      );
      canvas.drawRRect(rrect, paint);

      // Draw day label text
      final textPainter = TextPainter(
        text: TextSpan(
          text: days[i],
          style: TextStyle(
            color: (i == 4) ? const Color(0xFF9E5416) : AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + (barWidth - textPainter.width) / 2, size.height * 0.85));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
