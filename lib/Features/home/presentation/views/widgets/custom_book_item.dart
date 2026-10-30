import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 2.6 / 4,
        child: url.isEmpty
            ? const _BookImagePlaceholder()
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.white10,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const _BookImagePlaceholder(),
              ),
      ),
    );
  }
}

class _BookImagePlaceholder extends StatelessWidget {
  const _BookImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      alignment: Alignment.center,
      child: const Icon(
        Icons.menu_book,
        size: 40,
        color: Colors.white70,
      ),
    );
  }
}
