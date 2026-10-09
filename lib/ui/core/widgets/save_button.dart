import 'package:flutter/material.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/data/repositories/saved_repository.dart';

/// Heart on a white circle that saves or unsaves [product].
class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.product, this.size = 32});

  final ProductModel product;

  /// Diameter of the circle.
  final double size;

  @override
  Widget build(BuildContext context) {
    final saved = SavedRepository.instance;

    return ListenableBuilder(
      listenable: saved,
      builder: (context, _) {
        final isSaved = saved.isSaved(product.id);
        return IconButton(
          tooltip: isSaved ? 'Remove from saved' : 'Save',
          onPressed: () => saved.toggle(product),
          iconSize: size * 0.55,
          style: IconButton.styleFrom(
            fixedSize: Size.square(size),
            minimumSize: Size.square(size),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // always white: it sits on the pastel product backgrounds
            backgroundColor: Colors.white,
          ),
          icon: Icon(
            isSaved ? Icons.favorite : Icons.favorite_border,
            color: isSaved ? const Color(0xFFE5484D) : const Color(0xFF313337),
          ),
        );
      },
    );
  }
}
