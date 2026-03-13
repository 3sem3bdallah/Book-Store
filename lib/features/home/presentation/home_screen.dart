import 'package:book_store/core/helper/spacing.dart';
import 'package:book_store/features/home/presentation/widgets/best_seller_books.dart';
import 'package:book_store/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:book_store/core/widgets/discovering_books.dart';
import 'package:book_store/core/widgets/section_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomAppBar(),
                    verticalSpace(25),
                    const SectionHeader(title: 'Discover Books'),
                    verticalSpace(10),
                    const DiscoveringBooks(),
                    verticalSpace(10),
                    const SectionHeader(title: 'Best Seller'),
                    verticalSpace(10),
                  ],
                ),
              ),

              const BestSellerBooks(),
            ],
          ),
        ),
      ),
    );
  }
}
