import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class Header extends StatelessWidget {
  String title; 
  
  Header({
    super.key, 
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/img/logo.png', 
          width: 121,
          fit: BoxFit.contain,
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