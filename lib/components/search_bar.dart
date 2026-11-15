
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CharacterSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback onFilterTap;

  const CharacterSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.body.copyWith(
                fontSize: 12,
              ),
              decoration: InputDecoration(
                hintText: 'Search Characters',
                hintStyle: AppTextStyles.hint.copyWith(
                  fontSize: 12,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: onFilterTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Icon(
              Icons.tune,
              color: AppColors.background,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
