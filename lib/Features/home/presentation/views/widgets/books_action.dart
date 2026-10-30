import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/core/utils/function/launch_url.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_button.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    // Open Library records usually have a page URL in selfLink. Use it as a
    // fallback so the buttons remain useful when no dedicated preview exists.
    final bookUrl = bookModel.selfLink;
    final previewUrl = bookModel.volumeInfo.previewLink ?? bookUrl;
    final canOpenBook = bookUrl != null && bookUrl.isNotEmpty;
    final canPreview = previewUrl != null && previewUrl.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onPressed: canOpenBook
                  ? () => launchCustomUr(context, bookUrl)
                  : () => _showUnavailable(context),
              text: canOpenBook ? 'Open Book' : 'Unavailable',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: CustomButton(
              onPressed: canPreview
                  ? () => launchCustomUr(context, previewUrl)
                  : () => _showUnavailable(context),
              fontSize: 16,
              text: canPreview ? 'Preview' : 'Unavailable',
              backgroundColor: const Color(0xffEF8262),
              textColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUnavailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This book link is not available.')),
    );
  }
}
