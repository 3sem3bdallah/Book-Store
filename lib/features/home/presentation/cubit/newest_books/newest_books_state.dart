part of 'newest_books_cubit.dart';

sealed class NewestBooksState extends Equatable {
  const NewestBooksState();

  @override
  List<Object> get props => [];
}

final class NewestBooksInitial extends NewestBooksState {}

final class NewestBooksLoading extends NewestBooksState {}

class NewsetBooksSuccess extends NewestBooksState {
  final List<BookModel> books;

  const NewsetBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

class NewestBooksFailure extends NewestBooksState {
  final String errMessage;

  const NewestBooksFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
