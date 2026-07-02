import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {
        'name': 'Marcus Chen',
        'vehicle': 'Tesla Model 3',
        'visits': 8,
        'spent': 360.00,
        'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      },
      {
        'name': 'Sarah Jennings',
        'vehicle': 'Audi Q7',
        'visits': 12,
        'spent': 840.00,
        'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      },
      {
        'name': 'Robert King',
        'vehicle': 'BMW 5 Series',
        'visits': 5,
        'spent': 420.00,
        'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      },
      {
        'name': 'Emma Watson',
        'vehicle': 'Tesla Model S',
        'visits': 15,
        'spent': 1250.00,
        'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      }
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Customers')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final c = customers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(c['avatar'] as String),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                        const SizedBox(height: 2),
                        Text(c['vehicle'] as String, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${c['visits']} visits', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const SizedBox(height: 2),
                      Text(
                        '\$${(c['spent'] as double).toStringAsFixed(2)}',
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
