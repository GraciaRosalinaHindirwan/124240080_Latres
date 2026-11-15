
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'custom_buttom.dart';

class EmptyFavorite extends StatelessWidget {
  final VoidCallback onExplore;

  const EmptyFavorite({
    super.key,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Heading
          Text(
            'NO FAVORITES YET!',
            style: AppTextStyles.heading.copyWith(
              color: AppColors.primary,
              fontSize: 25,
            ),
          ),

          const SizedBox(height: 24),

          // Illustration
          Image.asset(
            'assets/img/empty.png',
            width: double.infinity,
            height: 190,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 20),

          // Description
          Text(
            'Looks like your favorite characters are lost in another dimension.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 16),

          // Explore Button
          SizedBox(
            width: 220,
            height: 54,
            child: CustomButton(
              text: 'EXPLORE CHARACTER',
              onPressed: onExplore,
            ),
          ),
        ],
      ),
    );
  }
}
