
import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/data/repos/home_repo.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<BookModel>>> fetchNewsetBooks() async {
    try {
      final data = await apiService.get(
        endPoint: 'search.json?q=computer%20science&sort=new',
      );

      return right(_parseBooks(data));
    } catch (e) {
      return left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      final data = await apiService.get(
        endPoint: 'search.json?q=subject:programming',
      );

      return right(_parseBooks(data));
    } catch (e) {
      return left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks({
    required String category,
  }) async {
    try {
      final query = Uri.encodeQueryComponent('subject:$category');
      final data = await apiService.get(
        endPoint: 'search.json?q=$query',
      );

      return right(_parseBooks(data));
    } catch (e) {
      return left(_handleError(e));
    }
  }

  List<BookModel> _parseBooks(Map<String, dynamic> data) {
    final docs = data['docs'] as List? ?? [];

    return docs
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        // Prefer results with a real cover ID so the list shows book covers
        // instead of placeholders whenever the API has cover data available.
        .where((item) => item['cover_i'] is num && (item['cover_i'] as num) > 0)
        .map(BookModel.fromJson)
        .toList();
  }

  Failure _handleError(Object error) {
    if (error is DioException) {
      return ServerFailure.fromDioError(error);
    }
    return ServerFailure(error.toString());
  }
}
