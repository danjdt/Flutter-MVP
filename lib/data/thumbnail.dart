class Thumbnail {
  final String path;
  final String extension;

  const Thumbnail({this.path, this.extension});

  Thumbnail.fromMap(Map<String, dynamic> map):
        path = "${map['path']}",
        extension = "${map['extension']}";
}