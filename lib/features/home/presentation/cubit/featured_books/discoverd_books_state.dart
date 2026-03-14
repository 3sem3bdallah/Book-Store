part of 'discoverd_books_cubit.dart';

sealed class DiscoverdBooksState extends Equatable {
  const DiscoverdBooksState();

  @override
  List<Object> get props => [];
}

final class DiscoverdBooksInitial extends DiscoverdBooksState {}

final class DiscoverdBooksLoading extends DiscoverdBooksState {}

final class DiscoverdBooksSuccess extends DiscoverdBooksState {
  final List<BookModel> books;

  const DiscoverdBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class DiscoverdBooksFailure extends DiscoverdBooksState {
  final String errorMessage;

  const DiscoverdBooksFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
