
class EpisodeModel {
  final int id;
  final String name;
  final String episode;
  final String airDate;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.episode,
    required this.airDate,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      episode: json['episode'] ?? 'Unknown',
      airDate: json['air_date'] ?? 'Unknown',
    );
  }
}
