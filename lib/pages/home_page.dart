
import 'package:flutter/material.dart';
import 'package:latres/components/filter_bottom_sheet.dart';
import 'package:latres/components/favorite_snackbar.dart';
import 'package:latres/pages/episode_page.dart';
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
  final Set<String> favorites = {};
  List<Map<String, String>> get favoriteCharacters {
    return characters.where((character) {
      return favorites.contains(character['name']);
    }).toList();
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

  int currentIndex = 0;

  final characters = [
    {
      'name': 'Rick Sanchez',
      'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      'status': 'Alive',
      'species': 'Human',
      'gender': 'Male',
      'origin': 'Earth (C-137)',
      'location': 'Earth',
    },
    {
      'name': 'Morty Smith',
      'image': 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      'status': 'Alive',
      'species': 'Human',
      'gender': 'Male',
      'origin': 'Earth (C-137)',
      'location': 'Earth',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  
  Widget buildHomeContent() {
    final filteredCharacters = characters.where((character) {
      final matchesSearch = character['name']!
          .toLowerCase()
          .contains(searchController.text.toLowerCase());

      final matchesStatus = selectedStatus == null ||
          character['status']!.toLowerCase() ==
              selectedStatus!.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            title: "Character Explore", 
            onLogout: (){},
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
                final name = character['name']!;

                return CharacterCard(
                  imageUrl: character['image']!,
                  name: name,
                  status: character['status']!,
                  isFavorite: favorites.contains(name),
                  onFavoriteTap: () {
                    toggleFavorite(name);
                  },
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: ((context) => DetailPage(character: character)
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
