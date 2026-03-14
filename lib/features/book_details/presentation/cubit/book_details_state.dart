part of 'book_details_cubit.dart';

sealed class BookDetailsState extends Equatable {
  const BookDetailsState();

  @override
  List<Object> get props => [];
}

final class BookDetailsInitial extends BookDetailsState {}

final class BookDetailsLoading extends BookDetailsState {}

final class BookDetailsSuccess extends BookDetailsState {
  final List<BookModel> books;

  const BookDetailsSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class BookDetailsFailure extends BookDetailsState {
  final String errMessage;

  const BookDetailsFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
