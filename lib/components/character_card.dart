
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'status_badge.dart';

class CharacterCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String status;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;
  final bool showFavoriteButton;

  const CharacterCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Character Image
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) {
                  return const Icon(
                    Icons.person,
                    size: 48,
                    color: AppColors.unknown,
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // Character Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.sectionTitle.copyWith(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 4),

                  StatusBadge(status: status),
                ],
              ),
            ),

            // Favorite Button
            // Favorite Button
          if (showFavoriteButton)
            IconButton(
              onPressed: onFavoriteTap,
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: AppColors.primary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
