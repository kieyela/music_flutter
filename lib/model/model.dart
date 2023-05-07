class Album {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final bool audiodownloadAllowed;
  final String downloadLink;
  final String audio;

  const Album({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.audiodownloadAllowed,
    required this.downloadLink,
    required this.audio
  });

  factory Album.fromJson(json) {
    return Album(
      id: json['id'].toString(),
      title: json['name'].toString(),
      subtitle: json['album_name'].toString(),
      image: json['image'].toString(),
      audiodownloadAllowed: json['audiodownload_allowed'],
      downloadLink: json['audiodownload'],
      audio:json['audio'].toString()
    );
  }
}