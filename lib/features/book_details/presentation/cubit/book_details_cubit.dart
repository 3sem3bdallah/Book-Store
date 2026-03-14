import '../../../home/data/models/book_model.dart';
import '../../../home/data/repo/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit(this.homeRepo) : super(BookDetailsInitial());

  final HomeRepo homeRepo;

  Future<void> fetchRelatedBooks({required String query}) async {
    emit(BookDetailsLoading());
    final result = await homeRepo.fetchRelatedBooks(query: query);
    result.fold(
      (failure) => emit(BookDetailsFailure(failure.errMessage)),
      (books) => emit(BookDetailsSuccess(books)),
    );
  }
}
