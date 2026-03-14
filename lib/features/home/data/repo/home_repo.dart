import '../../../../core/error_handler/failures.dart';
import '../models/book_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks();
  Future<Either<Failure, List<BookModel>>> fetchDiscoverdBooks();
  Future<Either<Failure, List<BookModel>>> fetchRelatedBooks({
    required String query,
  });
}
