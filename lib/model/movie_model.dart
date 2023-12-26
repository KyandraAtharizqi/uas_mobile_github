class Movie {
  final int id;
  final String title;
  final String year;
  final String runtime;
  final List<String> genres;
  final String director;
  final String actors;
  final String plot;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.runtime,
    required this.genres,
    required this.director,
    required this.actors,
    required this.plot,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      runtime: json['runtime'],
      genres: List<String>.from(json['genres']),
      director: json['director'],
      actors: json['actors'],
      plot: json['plot'],
      posterUrl: json['posterUrl'],
    );
  }
}