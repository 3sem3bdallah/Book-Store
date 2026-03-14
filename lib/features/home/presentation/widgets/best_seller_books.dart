import '../../../../core/constant/app_colors.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/utils/router_transitions.dart';
import '../../../../core/widgets/book_cover_image.dart';
import '../../../book_details/presentation/book_details_screen.dart';
import '../../../../core/widgets/book_rating.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../../data/models/book_model.dart';
import '../cubit/newest_books/newest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerBooks extends StatelessWidget {
  const BestSellerBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewsetBooksSuccess) {
          if (state.books.isEmpty) {
            return const SliverToBoxAdapter(
              child: CustomErrorWidget(errMessage: 'No books found.'),
            );
          }

          return SliverList.builder(
            itemCount: state.books.length,
            itemBuilder: (BuildContext context, int index) {
              final book = state.books[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    RouterTransitions.buildScale(
                      BookDetailsScreen(book: book),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: SizedBox(
                    height: 125.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 2.5 / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: BookCoverImage(
                              imageUrl:
                                  state
                                      .books[index]
                                      .volumeInfo
                                      .imageLinks
                                      ?.thumbnail ??
                                  '',
                              borderRadius: 10.r,
                            ),
                          ),
                        ),

                        horizontalSpace(16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                book.volumeInfo.title ?? 'Unknown title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark,
                                ),
                              ),

                              verticalSpace(6),

                              Text(
                                _getAuthorName(book),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),

                              verticalSpace(10),

                              Row(
                                children: [
                                  Text(
                                    _getSaleLabel(book),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const Spacer(),
                                  BookRating(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    rating: book.volumeInfo.averageRating ?? 0,
                                    ratingCount:
                                        book.volumeInfo.ratingsCount ?? 0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        if (state is NewestBooksFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(errMessage: state.errMessage),
          );
        }

        return SliverToBoxAdapter(
          child: SizedBox(height: 140.h, child: const CustomLoadingIndicator()),
        );
      },
    );
  }

  String _getAuthorName(BookModel book) {
    final authors = book.volumeInfo.authors;
    if (authors == null || authors.isEmpty) {
      return 'Unknown author';
    }

    return authors.join(', ');
  }

  String _getSaleLabel(BookModel book) {
    if (book.saleInfo?.saleability?.toLowerCase() == 'free' ||
        book.saleInfo?.isEbook == true) {
      return 'Free';
    }

    return 'Preview';
  }
}
