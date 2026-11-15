
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../components/status_badge.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> character;

  const DetailPage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          'CHARACTER PROFILE',
          style: AppTextStyles.sectionTitle,
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(24),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Character Image
                    Image.network(
                      character['image']!,
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Character Name and Favorite
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      character['name']!.toUpperCase(),
                                      style: AppTextStyles.heading.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 20,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    StatusBadge(
                                      status: character['status']!,
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Divider
                          Divider(
                            color: AppColors.primary,
                            thickness: 1,
                          ),

                          const SizedBox(height: 12),

                          // Character Information
                          Text(
                            'Character Information',
                            style: AppTextStyles.body.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Information Grid
                          Row(
                            children: [
                              Expanded(
                                child: _buildInformation(
                                  'SPECIES',
                                  character['species']!,
                                ),
                              ),
                              Expanded(
                                child: _buildInformation(
                                  'GENDER',
                                  character['gender']!,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              Expanded(
                                child: _buildInformation(
                                  'ORIGIN',
                                  character['origin']!,
                                ),
                              ),
                              Expanded(
                                child: _buildInformation(
                                  'LOCATION',
                                  character['location']!,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformation(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: AppColors.unknown,
            fontSize: 10,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
