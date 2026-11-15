
import 'package:flutter/material.dart';
import 'package:latres/api/api_service.dart';
import 'package:latres/components/filter_bottom_sheet.dart';
import 'package:latres/components/favorite_snackbar.dart';
import 'package:latres/models/character_model.dart';
import 'package:latres/pages/episode_page.dart';
import 'package:latres/pages/login_page.dart';
import 'package:latres/services/auth_service.dart';
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

  final Set<String> favorites = {};

  List<CharacterModel> characters = []; 

  bool isLoading = true; 
  String? errorMessage; 

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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

  List<Map<String, String>> get favoriteCharacters {
    return characters
        .where((character) => favorites.contains(character.name))
        .map(characterToMap)
        .toList();
  }

  void removeFavorite(String name) {
    setState(() {
      favorites.remove(name);
    });
  }

  void toggleFavorite(String name) {
  final isRemoving = favorites.contains(name);

  setState(() {
    if (isRemoving) {
      favorites.remove(name);
    } else {
      favorites.add(name);
    }
  });

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
                  isFavorite: favorites.contains(name),
                  onFavoriteTap: () {
                    toggleFavorite(name);
                  },
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                        character: characterMap,
                        isFavorite: favorites.contains(name),
                        onFavoriteTap: () {
                          toggleFavorite(name);
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
