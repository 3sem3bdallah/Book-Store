import 'package:flutter/material.dart';

class BookCoverImage extends StatelessWidget {
  const BookCoverImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
  });

  final String? imageUrl;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final normalizedImageUrl = _normalizeImageUrl(imageUrl);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: normalizedImageUrl == null
          ? const _BookCoverPlaceholder()
          : Image.network(
              normalizedImageUrl,
              fit: fit,
              errorBuilder: (context, error, stackTrace) {
                return const _BookCoverPlaceholder();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const _BookCoverPlaceholder(isLoading: true);
              },
            ),
    );
  }

  String? _normalizeImageUrl(String? url) {
    if (url == null || url.trim().isEmpty) {
      return null;
    }

    return url.replaceFirst('http://', 'https://');
  }
}

class _BookCoverPlaceholder extends StatelessWidget {
  const _BookCoverPlaceholder({this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F3F5),
      alignment: Alignment.center,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(
              Icons.menu_book_rounded,
              size: 32,
              color: Color(0xFF9AA0A6),
            ),
    );
  }
}