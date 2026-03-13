import '../../../core/helper/spacing.dart';
import 'widgets/best_seller_books.dart';
import 'widgets/custom_app_bar.dart';
import '../../../core/widgets/discovering_books.dart';
import '../../../core/widgets/section_header.dart';
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
