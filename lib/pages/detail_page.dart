
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/character_model.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../components/status_badge.dart';

class DetailPage extends StatefulWidget {
  final Map<String, String> character;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const DetailPage({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  CharacterModel? characterDetail;
  bool isLoading = true;
  String? errorMessage;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    fetchCharacterDetail();
  }

  Future<void> fetchCharacterDetail() async {
    try {
      final id = int.parse(widget.character['id']!);

      final result = await ApiService.getCharacterById(id);

      if (!mounted) return;

      setState(() {
        characterDetail = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Failed to load character detail';
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    if (errorMessage != null || characterDetail == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            errorMessage ?? 'Character not found',
            style: AppTextStyles.body.copyWith(color: Colors.white),
          ),
        ),
      );
    }
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
                      characterDetail!.image,
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
                                      characterDetail!.name.toUpperCase(),
                                      style: AppTextStyles.heading.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 20,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    StatusBadge(
                                      status: characterDetail!.status,
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });

                                  widget.onFavoriteTap();
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
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
                                  characterDetail!.species,
                                ),
                              ),
                              Expanded(
                                child: _buildInformation(
                                  'GENDER',
                                  characterDetail!.gender,
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
                                  characterDetail!.origin,
                                ),
                              ),
                              Expanded(
                                child: _buildInformation(
                                  'LOCATION',
                                  characterDetail!.location,
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
