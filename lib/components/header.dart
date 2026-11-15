
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback? onLogout;

  const Header({
    super.key,
    required this.title,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/img/logo.png',
              width: 121,
              fit: BoxFit.contain,
            ),

            if (onLogout != null)
              IconButton(
                onPressed: onLogout,
                icon: const Icon(
                  Icons.logout,
                  color: AppColors.neonRed,
                ),
                tooltip: 'Logout',
              ),
          ],
        ),

        Text(
          title,
          style: AppTextStyles.heading.copyWith(
            color: AppColors.textPrimary,
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
