
import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/presentation/manger/smila_books_cubit/similar_books_cubit.dart';
import 'package:bookly/Features/home/presentation/views/widgets/book_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    super.initState();

    final categories = widget.bookModel.volumeInfo.categories;
    final category = (categories != null && categories.isNotEmpty &&
            categories.first.toString().trim().isNotEmpty)
        ? categories.first.toString().trim()
        : 'programming';

    // Always start the request. If the selected book has no subjects,
    // use a sensible fallback instead of leaving the loading spinner forever.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<SimilarBooksCubit>().fetchSimilarBooks(
            category: category,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BookDetailsViewBody(
          bookModel: widget.bookModel,
        ),
      ),
    );
  }
}
