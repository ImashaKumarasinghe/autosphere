import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../services/app_state.dart';
import '../../models/booking_model.dart';

class PaymentScreen extends StatefulWidget {
  final String bookingId;
  final double price;
  final String description;

  const PaymentScreen({
    super.key,
    required this.bookingId,
    required this.price,
    required this.description,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0; // 0 = Credit Card, 1 = Google Pay, 2 = Cash
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Booking cost summary card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Summary', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.description, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        Text('Rs. ${widget.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Service Fee', style: TextStyle(color: AppColors.textSecondary)),
                        Text('Rs. 2.50', style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                    const Divider(height: 24, color: Color(0xFFF1F3F5), thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                        Text(
                          'Rs. ${(widget.price + 2.50).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 2. Select Payment Method
            Text('Select Payment Method', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            _methodTile(0, 'Credit or Debit Card', FontAwesomeIcons.creditCard),
            const SizedBox(height: 10),
            _methodTile(1, 'Google Pay', FontAwesomeIcons.googlePay),
            const SizedBox(height: 10),
            _methodTile(2, 'Pay at Station (Cash)', FontAwesomeIcons.moneyBillWave),
            const SizedBox(height: 32),

            // 3. Confirm checkout action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Pay Securely'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _methodTile(int index, String title, IconData icon) {
    final isSelected = _selectedMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFF1F3F5),
            width: isSelected ? 2 : 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : const Color(0xFFCBD5E1),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment() {
    setState(() {
      _isProcessing = true;
    });

    // Simulate network latency
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      
      final appState = Provider.of<AppState>(context, listen: false);
      
      // Update payment status and move to accepted status
      final index = appState.bookings.indexWhere((b) => b.id == widget.bookingId);
      if (index != -1) {
        appState.bookings[index] = appState.bookings[index].copyWith(
          paymentStatus: PaymentStatus.paid,
          status: BookingStatus.accepted,
        );
        appState.notifyListeners();
      }

      setState(() {
        _isProcessing = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Row(
            children: [
              Icon(FontAwesomeIcons.circleCheck, color: AppColors.statusAvailable),
              SizedBox(width: 12),
              Text('Payment Successful'),
            ],
          ),
          content: const Text('Your payment has been processed securely. Your booking has been sent to the service provider.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // dismiss dialog
                Navigator.pop(context); // dismiss checkout screen
              },
              child: const Text('Great'),
            ),
          ],
        ),
      );
    });
  }
}
