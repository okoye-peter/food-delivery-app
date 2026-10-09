import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yummy/data/repositories/saved_repository.dart';
import 'package:yummy/routing/route_path.dart';
import 'package:yummy/ui/core/widgets/cart_button.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/product_card.dart';

/// Saved tab: the meals the user hearted.
class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saved = SavedRepository.instance;

    return Scaffold(
      appBar: const PageAppBar(
        title: 'Saved',
        showBack: false,
        actions: [CartButton()],
      ),
      body: ListenableBuilder(
        listenable: saved,
        builder: (context, _) {
          final items = saved.items;
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.favorite_border,
              title: 'No saved meals yet',
              message: 'Tap the heart on any meal to keep it here for later.',
              actionLabel: 'Browse menu',
              onAction: () => context.go(AppRoutes.menu),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisExtent: ProductCard.height,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) => ProductCard(product: items[index]),
          );
        },
      ),
    );
  }
}
