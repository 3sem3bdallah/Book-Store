import 'package:book_store/core/helper/spacing.dart';
import 'package:book_store/presentation/widgets/custom_app_bar.dart';
import 'package:book_store/presentation/widgets/discovering_books.dart';
import 'package:book_store/presentation/widgets/section_header.dart';
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
          child: Column(
            children: [
              CustomAppBar(),
              verticalSpace(25),
              SectionHeader(title: 'Discover Books'),
              verticalSpace(15),
              DiscoveringBooks(),
              verticalSpace(15),
              SectionHeader(title: 'Best Seller'),
            ],
          ),
        ),
      ),
    );
  }
}
