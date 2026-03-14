import '../../../core/utils/service_locator.dart';
import 'cubit/book_details_cubit.dart';
import 'widgets/related_books_section.dart';
import '../../home/data/models/book_model.dart';
import '../../home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/spacing.dart';
import '../../../core/widgets/book_rating.dart';
import '../../../core/widgets/section_header.dart';
import 'widgets/books_action.dart';
import 'widgets/custom_book_image.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final query = _buildRelatedQuery();

    return BlocProvider(
      create: (_) =>
          BookDetailsCubit(getIt<HomeRepo>())..fetchRelatedBooks(query: query),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(26),
                  CustomBookImage(
                    imageUrl: book.volumeInfo.imageLinks?.thumbnail,
                  ),

                  verticalSpace(24),
                  Text(
                    book.volumeInfo.title ?? 'Unknown title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),

                  verticalSpace(6),
                  Text(
                    _authorLabel(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  verticalSpace(12),
                  BookRating(
                    mainAxisAlignment: MainAxisAlignment.center,
                    rating: book.volumeInfo.averageRating ?? 0,
                    ratingCount: book.volumeInfo.ratingsCount ?? 0,
                  ),

                  verticalSpace(20),
                  BooksAction(book: book),

                  verticalSpace(24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      book.volumeInfo.description ?? 'No description available.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),

                  verticalSpace(24),
                  const SectionHeader(title: 'Related Books'),
                  verticalSpace(20),
                  const RelatedBooksSection(),
                  verticalSpace(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _authorLabel() {
    final authors = book.volumeInfo.authors;
    if (authors == null || authors.isEmpty) {
      return 'Unknown author';
    }

    return authors.join(', ');
  }

  String _buildRelatedQuery() {
    final categories = book.volumeInfo.categories;
    if (categories != null && categories.isNotEmpty) {
      return categories.first;
    }

    final title = book.volumeInfo.title;
    if (title != null && title.trim().isNotEmpty) {
      return title;
    }

    return 'sport';
  }
}
