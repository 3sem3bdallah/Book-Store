import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/book_details/presentation/book_details_screen.dart';
import '../../features/home/presentation/cubit/featured_books/discoverd_books_cubit.dart';
import '../utils/router_transitions.dart';
import 'book_cover_image.dart';
import 'custom_error_widget.dart';
import 'custom_loading_indicator.dart';

class DiscoveringBooks extends StatelessWidget {
  const DiscoveringBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverdBooksCubit, DiscoverdBooksState>(
      builder: (context, state) {
        if (state is DiscoverdBooksSuccess) {
          if (state.books.isEmpty) {
            return const CustomErrorWidget(errMessage: 'No books found.');
          }

          return SizedBox(
            height: 200.h,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final book = state.books[index];
                return AspectRatio(
                  aspectRatio: 2 / 4,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        RouterTransitions.buildScale(
                          BookDetailsScreen(book: book),
                        ),
                      );
                    },
                    child: BookCoverImage(
                      imageUrl:
                          book.volumeInfo.imageLinks?.thumbnail ??
                          'https://via.placeholder.com/150',
                      borderRadius: 16.r,
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is DiscoverdBooksFailure) {
          return CustomErrorWidget(errMessage: state.errorMessage);
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
