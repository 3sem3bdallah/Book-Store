import '../../../data/models/book_model.dart';
import '../../../data/repo/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'discoverd_books_state.dart';

class DiscoverdBooksCubit extends Cubit<DiscoverdBooksState> {
  DiscoverdBooksCubit(this.homeRepo) : super(DiscoverdBooksInitial()) {
    fetchDiscoverdBooks();
  }

  final HomeRepo homeRepo;

  Future<void> fetchDiscoverdBooks() async {
    emit(DiscoverdBooksLoading());
    var result = await homeRepo.fetchDiscoverdBooks();
    result.fold(
      (failure) {
        emit(DiscoverdBooksFailure(failure.errMessage));
      },
      (books) {
        emit(DiscoverdBooksSuccess(books));
      },
    );
  }
}