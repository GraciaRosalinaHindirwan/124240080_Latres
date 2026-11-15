import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _favoriteKey = 'favoriteCharacters';

  // Mengambil daftar ID karakter favorit
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_favoriteKey) ?? [];
  }

  // Menambahkan karakter ke favorite
  static Future<void> addFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(_favoriteKey) ?? [];

    if (!favorites.contains(id)) {
      favorites.add(id);
      await prefs.setStringList(_favoriteKey, favorites);
    }
  }

  // Menghapus karakter dari favorite
  static Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(_favoriteKey) ?? [];

    favorites.remove(id);

    await prefs.setStringList(_favoriteKey, favorites);
  }
}
