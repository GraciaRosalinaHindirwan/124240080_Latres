
import 'package:flutter/material.dart';

import '../components/header.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class EpisodePage extends StatelessWidget {
  const EpisodePage({super.key});

  final List<Map<String, String>> episodes = const [
    {
      'episode': 'E01',
      'name': 'PILOT',
      'date': 'December 2, 2013',
    },
    {
      'episode': 'E02',
      'name': 'LAWNMOWER DOG',
      'date': 'December 9, 2013',
    },
    {
      'episode': 'E03',
      'name': 'ANATOMY PARK',
      'date': 'December 16, 2013',
    },
    {
      'episode': 'E04',
      'name': 'M. NIGHT SHAYM-ALIENS!',
      'date': 'January 13, 2014',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Header(title: 'Episode'),

            const SizedBox(height: 24),

            // Episode List
            Expanded(
              child: ListView.separated(
                itemCount: episodes.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemBuilder: (context, index) {
                  final episode = episodes[index];

                  return _buildEpisodeCard(episode);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodeCard(Map<String, String> episode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Play Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1D2B0A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.play_circle_outline,
              color: AppColors.primary,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // Episode Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  episode['episode']!,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  episode['name']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading.copyWith(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      episode['date']!,
                      style: AppTextStyles.body.copyWith(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
