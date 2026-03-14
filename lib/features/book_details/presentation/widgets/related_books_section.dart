import '../../../../core/widgets/book_cover_image.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';
import '../book_details_screen.dart';
import '../cubit/book_details_cubit.dart';
import '../../../home/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RelatedBooksSection extends StatelessWidget {
  const RelatedBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      builder: (context, state) {
        if (state is BookDetailsSuccess) {
          if (state.books.isEmpty) {
            return const CustomErrorWidget(errMessage: 'No related books found.');
          }

          return SizedBox(
            height: 190.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.books.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final book = state.books[index];
                return _RelatedBookCard(book: book);
              },
            ),
          );
        }

        if (state is BookDetailsFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        }

        return const CustomLoadingIndicator();
      },
    );
  }
}

class _RelatedBookCard extends StatelessWidget {
  const _RelatedBookCard({required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => BookDetailsScreen(book: book)),
        );
      },
      child: SizedBox(
        width: 110.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BookCoverImage(
                imageUrl: book.volumeInfo.imageLinks?.thumbnail,
                borderRadius: 14.r,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              book.volumeInfo.title ?? 'Unknown title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
