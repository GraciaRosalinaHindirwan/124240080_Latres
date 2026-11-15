class CharacterModel {
  final int id; 
  final String name; 
  final String status; 
  final String species; 
  final String gender;
  final String image; 
  final String origin; 
  final String location; 

  CharacterModel({
    required this.id,
    required this.name, 
    required this.status, 
    required this.species, 
    required this.gender, 
    required this.image, 
    required this.origin, 
    required this.location, 
  });

  //ubah JSON jadi data object 
  factory CharacterModel.fromJson(Map<String, dynamic> json){
    return CharacterModel(
    id: json['id'],
    name: json['name'] ?? 'Unknown',
    status: json['status'] ?? 'Unknown',
    species: json['species'] ?? 'Unknown',
    gender: json['gender'] ?? 'Unknown',
    image: json['image'] ?? '',
    origin: json['origin']?['name'] ?? 'Unknown',
    location: json['location']?['name'] ?? 'Unknown',
    ); 
  }
}