import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latres/models/character_model.dart';

class ApiService {
  static const String baseUrl = 'rickandmortyapi.com';

  static Future<List<CharacterModel>> getCharacters({String? status}) async { 
    final uri = Uri.https(
      baseUrl, 
      '/api/character', 
      status == null || status == 'All'
        ? null 
        : {'status': status?.toLowerCase()}, 
    );

    final response = await http.get(uri).timeout(const Duration(seconds: 15),);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      return results
          .map((json) => CharacterModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}