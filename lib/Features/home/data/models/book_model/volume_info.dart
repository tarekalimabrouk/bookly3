
class VolumeInfo {
  final String? title;
  final List<dynamic>? authors;
  final List<dynamic>? categories;
  final ImageLinks? imageLinks;
  final String? previewLink;

  VolumeInfo({
    this.title,
    this.authors,
    this.categories,
    this.imageLinks,
    this.previewLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    final coverId = json['cover_i'];

    final int? validCoverId =
        coverId is num && coverId > 0 ? coverId.toInt() : null;

    return VolumeInfo(
      title: json['title'] as String?,
      authors: json['author_name'] as List<dynamic>?,
      categories: json['subject'] as List<dynamic>?,
      // Open Library search results do not provide Google's previewLink.
      // Use the book's Open Library page as a working fallback destination.
      previewLink: json['previewLink'] as String? ??
          (json['key'] is String
              ? 'https://openlibrary.org${json['key']}'
              : null),
      imageLinks: validCoverId == null
          ? null
          : ImageLinks(
              smallThumbnail:
                  'https://covers.openlibrary.org/b/id/$validCoverId-S.jpg',
              thumbnail:
                  'https://covers.openlibrary.org/b/id/$validCoverId-M.jpg',
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author_name': authors,
        'subject': categories,
        'previewLink': previewLink,
        'imageLinks': imageLinks?.toJson(),
      };
}

class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        'smallThumbnail': smallThumbnail,
        'thumbnail': thumbnail,
      };
}
