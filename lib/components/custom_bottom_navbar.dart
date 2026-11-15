
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<String> labels = const [
    'Characters',
    'Favorite',
    'Episode',
  ];

  // Asset untuk icon Characters
  final List<String> activeImages = const [
    'assets/img/active.png',
    '',
    '',
  ];

  final List<String> inactiveImages = const [
    'assets/img/deactive.png',
    '',
    '',
  ];

  final List<IconData> icons = const [
    Icons.person,
    Icons.favorite,
    Icons.movie,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFF111811),
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = currentIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon atau Image
                  if (index == 0)
                    Image.asset(
                      isSelected
                          ? activeImages[index]
                          : inactiveImages[index],
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    )
                  else
                    Icon(
                      icons[index],
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.unknown,
                      size: 22,
                    ),

                  const SizedBox(height: 4),

                  Text(
                    labels[index],
                    style: AppTextStyles.navbar.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.unknown,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
