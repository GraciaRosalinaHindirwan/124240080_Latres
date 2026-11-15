
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class FavoriteSnackbar {
  static void show(
    BuildContext context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 20,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                message,
                style: AppTextStyles.body.copyWith(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),

        backgroundColor: AppColors.cardBackground,
        behavior: SnackBarBehavior.floating,
        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),

        duration: const Duration(seconds: 2),
      ),
    );
  }
}
