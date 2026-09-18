
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;

  const ProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Icon(
        Icons.image_not_supported_outlined,
        size: 55,
        color: Colors.grey.shade400,
      );
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.contain,
      width: double.infinity,
      errorBuilder: (_, _, _) => Icon(
        Icons.image_not_supported_outlined,
        size: 55,
        color: Colors.grey.shade400,
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      },
    );
  }
}
