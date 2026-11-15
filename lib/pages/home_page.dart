
import 'package:flutter/material.dart';
import 'package:latres/api/api_service.dart';
import 'package:latres/components/filter_bottom_sheet.dart';
import 'package:latres/components/favorite_snackbar.dart';
import 'package:latres/models/character_model.dart';
import 'package:latres/pages/episode_page.dart';
import 'package:latres/pages/login_page.dart';
import 'package:latres/services/auth_service.dart';
import 'package:latres/services/favorite_service.dart';
import '../pages/favorite_page.dart';
import '../pages/detail_page.dart';
import '../pages/episode_page.dart';


import '../components/header.dart';
import '../components/search_bar.dart';
import '../components/character_card.dart';
import '../components/custom_bottom_navbar.dart';
import '../utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  String? selectedStatus;
  int currentIndex = 0;

  Set<String> favorites = {};

  List<CharacterModel> characters = []; 
  List<CharacterModel> favoriteCharacters = [];
  bool isFavoriteLoading = true;

  bool isLoading = true; 
  String? errorMessage; 


  @override
  void initState() {
    super.initState();
    fetchCharacters();
    loadFavorites();
    fetchFavoriteCharacters(); 
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchFavoriteCharacters() async {
    try {
      setState(() {
        isFavoriteLoading = true;
      });

      final favoriteIds = await FavoriteService.getFavorites();

      final result = await ApiService.getCharactersByIds(favoriteIds);

      if (!mounted) return;

      setState(() {
        favoriteCharacters = result;
        isFavoriteLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isFavoriteLoading = false;
      });
    }
  }

  Future<void> fetchCharacters() async {
    try {
      setState(() {
        isLoading = true; 
        errorMessage = null; 
      });

      final result = await ApiService.getCharacters(
        status: selectedStatus, 
      ); 
      if(!mounted) return; 

      setState(() {
        characters = result; 
        isLoading = false; 
      });

    } catch (e) {
      if(!mounted) return; 

      setState(() {
        isLoading = false; 
        errorMessage = "Failed to load characters"; 
      });
    }
  }

  Map<String, String> characterToMap(CharacterModel character) {
    return {
      'id': character.id.toString(),
      'name': character.name,
      'image': character.image,
      'status': character.status,
      'species': character.species,
      'gender': character.gender,
      'origin': character.origin,
      'location': character.location,
    };
  }

  Future<void> loadFavorites() async {
    final result = await FavoriteService.getFavorites();

    if (!mounted) return;

    setState(() {
      favorites = result.toSet();
    });
  }

  Future<void> removeFavorite(String id) async {
    setState(() {
      favorites.remove(id);
    });

    await FavoriteService.removeFavorite(id); 
    await fetchFavoriteCharacters(); 
  }

  Future<void> toggleFavorite(String id, String name) async {
    final isRemoving = favorites.contains(id);

    setState(() {
      if (isRemoving) {
        favorites.remove(id);
      } else {
        favorites.add(id);
      }
    });

    if (isRemoving) {
      await FavoriteService.removeFavorite(id);
    } else {
      await FavoriteService.addFavorite(id);
    }

    await fetchFavoriteCharacters();

    if (!mounted) return;

    FavoriteSnackbar.show(
      context,
      message: isRemoving
          ? '$name removed from favorites'
          : '$name added to favorites',
    );
  }

  Future<void> handleLogout() async {
    await AuthService.logout(); 

    if(!mounted) return; 

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(
        builder: ((context) => LoginPage()),
      ),
      (route) => false, 
    ); 
  }
  
  Widget buildHomeContent() {
    if(isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if(errorMessage != null){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!,
            style: const TextStyle(color: Colors.white),
            ), 

            const SizedBox(height: 12,), 

            ElevatedButton(
              onPressed: fetchCharacters, child: Text("Try Again"))
          ],
        ),
      );
    }

    final filteredCharacters = characters.where((character) {
      final matchesSearch = character.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase());

      return matchesSearch;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: "Character Explore", 
            onLogout: handleLogout,
          ),

          const SizedBox(height: 20),

          CharacterSearchBar(
            controller: searchController,
            onChanged: (value) {
              setState(() {});
            },
            onFilterTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.cardBackground,
                isScrollControlled: true,
                builder: (context) {
                  return FilterBottomSheet(
                    selectedStatus: selectedStatus,
                    onApply: (status) {
                      setState(() {
                        selectedStatus = status;
                      });

                      fetchCharacters();
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              itemCount: filteredCharacters.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
                final characterMap = characterToMap(character); 
                final name = character.name;

                return CharacterCard(
                  imageUrl: character.image,
                  name: name,
                  status: character.status,
                  isFavorite: favorites.contains(character.id.toString()),
                  onFavoriteTap: () {
                    toggleFavorite(
                      character.id.toString(), 
                      character.name, 
                    );
                  },
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                        character: characterMap,
                        isFavorite: favorites.contains(character.id.toString()),
                        onFavoriteTap: () {
                          toggleFavorite(
                            character.id.toString(), 
                            character.name, 
                          );
                        },
                      ),
                      )
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Daftar halaman yang akan ditampilkan
    final List<Widget> pages = [
      buildHomeContent(),

      FavoritePage(
        favoriteCharacters: favoriteCharacters,
        isLoading: isFavoriteLoading,
        onRemoveFavorite: removeFavorite,
        onExplore: () {
          setState(() {
            currentIndex = 0;
          });
        },
      ),

      const EpisodePage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,

      // Menampilkan halaman berdasarkan index
      body: SafeArea(
        child: pages[currentIndex],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
