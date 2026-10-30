
import 'package:equatable/equatable.dart';
import 'volume_info.dart';

class BookModel extends Equatable {
  final String? kind;
  final String? id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo volumeInfo;

  const BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    required this.volumeInfo,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      kind: json['type'] as String?,
      id: json['key'] as String?,
      etag: null,
      selfLink: json['key'] == null
          ? null
          : 'https://openlibrary.org${json['key']}',
      volumeInfo: VolumeInfo.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'id': id,
        'etag': etag,
        'selfLink': selfLink,
        'volumeInfo': volumeInfo.toJson(),
      };

  @override
  List<Object?> get props => [
        kind,
        id,
        etag,
        selfLink,
        volumeInfo,
      ];
}
