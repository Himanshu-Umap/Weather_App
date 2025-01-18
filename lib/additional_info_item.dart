import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(
            icon,
            ),
          const SizedBox(height:8),
          Text(
            label,
            ),
          const SizedBox(height:8),
          Text(value),
        ],
      ),
    );
  }
}