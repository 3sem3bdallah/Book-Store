import 'dart:developer';

import '../../../../core/error_handler/failures.dart';
import '../../../../core/utils/api_service.dart';
import '../models/book_model.dart';
import 'home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  List<BookModel>? _cachedNewestBooks;
  List<BookModel>? _cachedDiscoverdBooks;
  final Map<String, List<BookModel>> _relatedBooksCache = {};

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
    try {
      final data = await apiService.get(
        endPoint:
            'volumes?q=computer science&filter=free-ebooks&orderBy=newest',
      );
      log(data.toString());

      final books = _mapBooks(data);
      _cachedNewestBooks = books;
      return right(books);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 429) {
        return right(_cachedNewestBooks ?? _fallbackNewestBooks);
      }
      if (_cachedNewestBooks != null && _cachedNewestBooks!.isNotEmpty) {
        return right(_cachedNewestBooks!);
      }
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      if (_cachedNewestBooks != null && _cachedNewestBooks!.isNotEmpty) {
        return right(_cachedNewestBooks!);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchDiscoverdBooks() async {
    try {
      final data = await apiService.get(
        endPoint: 'volumes?q=subject:programming&filter=free-ebooks',
      );
      log(data.toString());

      final books = _mapBooks(data);
      _cachedDiscoverdBooks = books;
      return right(books);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 429) {
        return right(_cachedDiscoverdBooks ?? _fallbackDiscoverdBooks);
      }
      if (_cachedDiscoverdBooks != null && _cachedDiscoverdBooks!.isNotEmpty) {
        return right(_cachedDiscoverdBooks!);
      }
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      if (_cachedDiscoverdBooks != null && _cachedDiscoverdBooks!.isNotEmpty) {
        return right(_cachedDiscoverdBooks!);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchRelatedBooks({
    required String query,
  }) async {
    final normalizedQuery = _normalizeQuery(query);

    try {
      final data = await apiService.get(
        endPoint: 'volumes?q=$normalizedQuery&filter=free-ebooks',
      );
      log(data.toString());

      final books = _mapBooks(data);
      _relatedBooksCache[normalizedQuery] = books;
      return right(books);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 429) {
        return right(_relatedBooksCache[normalizedQuery] ?? _fallbackRelatedBooks);
      }
      final cachedBooks = _relatedBooksCache[normalizedQuery];
      if (cachedBooks != null && cachedBooks.isNotEmpty) {
        return right(cachedBooks);
      }
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      final cachedBooks = _relatedBooksCache[normalizedQuery];
      if (cachedBooks != null && cachedBooks.isNotEmpty) {
        return right(cachedBooks);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  List<BookModel> _mapBooks(Map<String, dynamic> data) {
    final items = data['items'] as List<dynamic>? ?? [];
    return items
        .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  String _normalizeQuery(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return 'sport';
    }

    return trimmedQuery.replaceAll(' ', '+');
  }

  static final List<BookModel> _fallbackDiscoverdBooks = [
    _buildFallbackBook(
      id: 'clean-code',
      title: 'Clean Code',
      authors: ['Robert C. Martin'],
      thumbnail:
          'https://books.google.com/books/content?id=_i6bDeoCQzsC&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.5,
      ratingsCount: 120,
    ),
    _buildFallbackBook(
      id: 'pragmatic-programmer',
      title: 'The Pragmatic Programmer',
      authors: ['Andrew Hunt', 'David Thomas'],
      thumbnail:
          'https://books.google.com/books/content?id=5wBQEp6ruIAC&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.7,
      ratingsCount: 98,
    ),
    _buildFallbackBook(
      id: 'refactoring',
      title: 'Refactoring',
      authors: ['Martin Fowler'],
      thumbnail:
          'https://books.google.com/books/content?id=1MsETFPD3I0C&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.6,
      ratingsCount: 88,
    ),
    _buildFallbackBook(
      id: 'design-patterns',
      title: 'Design Patterns',
      authors: ['Erich Gamma', 'Richard Helm'],
      thumbnail:
          'https://books.google.com/books/content?id=6oHuKQe3TjQC&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.4,
      ratingsCount: 76,
    ),
  ];

  static final List<BookModel> _fallbackNewestBooks = [
    _buildFallbackBook(
      id: 'flutter-cookbook',
      title: 'Flutter Cookbook',
      authors: ['Simone Alessandria'],
      thumbnail:
          'https://books.google.com/books/content?id=Zr9NEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.3,
      ratingsCount: 41,
    ),
    _buildFallbackBook(
      id: 'learning-dart',
      title: 'Learning Dart',
      authors: ['Ivo Balbaert'],
      thumbnail:
          'https://books.google.com/books/content?id=ej6xDwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.2,
      ratingsCount: 34,
    ),
    _buildFallbackBook(
      id: 'api-design-patterns',
      title: 'API Design Patterns',
      authors: ['JJ Geewax'],
      thumbnail:
          'https://books.google.com/books/content?id=3uQUEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.1,
      ratingsCount: 22,
    ),
    _buildFallbackBook(
      id: 'software-engineering-at-google',
      title: 'Software Engineering at Google',
      authors: ['Titus Winters', 'Tom Manshreck', 'Hyrum Wright'],
      thumbnail:
          'https://books.google.com/books/content?id=nd9TEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.5,
      ratingsCount: 53,
    ),
  ];

  static final List<BookModel> _fallbackRelatedBooks = [
    _buildFallbackBook(
      id: 'sports-psychology',
      title: 'Sport Psychology',
      authors: ['Arnold LeUnes'],
      thumbnail:
          'https://books.google.com/books/content?id=F2eNAgAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.1,
      ratingsCount: 18,
    ),
    _buildFallbackBook(
      id: 'sports-marketing',
      title: 'Sport Marketing',
      authors: ['Windy Dees', 'Patrick Walsh'],
      thumbnail:
          'https://books.google.com/books/content?id=utMPEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.0,
      ratingsCount: 11,
    ),
    _buildFallbackBook(
      id: 'sport-finance',
      title: 'The Business of Sport',
      authors: ['Scott Rosner', 'Kenneth Shropshire'],
      thumbnail:
          'https://books.google.com/books/content?id=zAUwDwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
      averageRating: 4.2,
      ratingsCount: 14,
    ),
  ];

  static BookModel _buildFallbackBook({
    required String id,
    required String title,
    required List<String> authors,
    required String thumbnail,
    required double averageRating,
    required int ratingsCount,
  }) {
    return BookModel.fromJson({
      'id': id,
      'volumeInfo': {
        'title': title,
        'authors': authors,
        'averageRating': averageRating,
        'ratingsCount': ratingsCount,
        'imageLinks': {'thumbnail': thumbnail},
      },
      'saleInfo': {
        'saleability': 'FREE',
        'isEbook': true,
      },
    });
  }
}
