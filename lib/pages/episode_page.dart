
import 'package:flutter/material.dart';
import 'package:latres/api/api_service.dart';
import 'package:latres/models/episode_model.dart';

import '../components/header.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  List<EpisodeModel> episodes = [];
  bool isLoading = true;

  String? errorMessage;

  Future<void> fetchEpisodes() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final result = await ApiService.getEpisodes();

      if (!mounted) return;

      setState(() {
        episodes = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load episodes';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

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
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                errorMessage!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: fetchEpisodes,
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
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

  Widget _buildEpisodeCard(EpisodeModel episode) {
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
                  episode.episode,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  episode.name,
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
                      episode.airDate,
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
