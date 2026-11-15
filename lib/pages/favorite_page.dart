
import 'package:flutter/material.dart';
import 'package:latres/models/character_model.dart';

import '../components/header.dart';
import '../components/empty_favorite.dart';
import '../components/character_card.dart';
import '../components/favorite_snackbar.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class FavoritePage extends StatelessWidget {
  final List<CharacterModel> favoriteCharacters;
  final Function(String) onRemoveFavorite;
  final VoidCallback onExplore;
  final bool isLoading;

  const FavoritePage({
    super.key,
    required this.favoriteCharacters,
    required this.onRemoveFavorite,
    required this.onExplore,
    required this.isLoading, 
  });

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
            Header(title: "My Favorite",),

            const SizedBox(height: 24),

            // Favorite List
            Expanded(
              child: isLoading
                      ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : favoriteCharacters.isEmpty
                  ? EmptyFavorite(onExplore: onExplore)
                  : ListView.separated(
                      itemCount: favoriteCharacters.length,

                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },

                      itemBuilder: (context, index) {
                        final character =
                            favoriteCharacters[index];

                        final id = character.id.toString(); 
                        final name = character.name;

                        return Dismissible(
                          key: ValueKey(id),
                          direction:
                              DismissDirection.endToStart,

                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.neonRed,
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),

                          onDismissed: (direction) {
                            onRemoveFavorite(id);

                            FavoriteSnackbar.show(
                              context,
                              message:
                                  '$name removed from favorites',
                            );
                          },

                          child: CharacterCard(
                            imageUrl: character.image,
                            name: name,
                            status: character.status,

                            isFavorite: true,
                            showFavoriteButton: false,

                            onFavoriteTap: () {},
                            onTap: () {
                              // Navigasi ke DetailPage
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
