
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.primary;

      case 'dead':
        return AppColors.neonRed;

      default:
        return AppColors.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: statusColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 9,
        ),
      ),
    );
  }
}
