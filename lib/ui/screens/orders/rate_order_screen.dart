import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/data/repositories/order_repository.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/empty_state.dart';
import 'package:yummy/ui/core/widgets/page_app_bar.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/core/widgets/rating_label.dart';

/// Stars, quick tags and a comment for a delivered order.
class RateOrderScreen extends StatefulWidget {
  const RateOrderScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  static const _starLabels = ['Terrible', 'Bad', 'Okay', 'Good', 'Excellent'];
  static const _tags = [
    'Tasty',
    'Hot & fresh',
    'Good portion',
    'Fast delivery',
    'Well packed',
    'Friendly rider',
  ];

  late final _order = OrderRepository.instance.findById(widget.orderId);
  final _commentController = TextEditingController();
  final _selectedTags = <String>{};
  var _stars = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    final comment = _commentController.text.trim();
    OrderRepository.instance.rate(
      widget.orderId,
      OrderRating(
        stars: _stars,
        tags: _selectedTags.toList(),
        comment: comment.isEmpty ? null : comment,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Thanks for your feedback!'),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final order = _order;
    if (order == null || order.status != OrderStatus.delivered) {
      return const Scaffold(
        appBar: PageAppBar(title: 'Rate order'),
        body: EmptyState(
          icon: Icons.star_border,
          title: 'Nothing to rate yet',
          message: 'You can rate an order once it has been delivered.',
        ),
      );
    }

    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: PageAppBar(title: 'Rate order #${order.id}'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Center(
            child: Wrap(
              spacing: 8,
              children: [
                for (final item in order.items.take(4))
                  Container(
                    width: 56,
                    height: 56,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ProductImageTile.colorFor(item.product.id),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(item.product.image),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'How was your order?',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: context.colors.sectionTitle,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your rating helps the kitchen and rider do better.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.colors.subtitle,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 1; i <= 5; i++)
                IconButton(
                  tooltip: '$i star${i == 1 ? '' : 's'}',
                  onPressed: () => setState(() => _stars = i),
                  iconSize: 44,
                  icon: Icon(
                    i <= _stars
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: i <= _stars
                        ? RatingLabel.starColor
                        : context.colors.inputLabel,
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 24,
            child: Text(
              _stars == 0 ? '' : _starLabels[_stars - 1],
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: RatingLabel.starColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'What went well?',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.colors.sectionTitle,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in _tags)
                FilterChip(
                  label: Text(tag),
                  selected: _selectedTags.contains(tag),
                  onSelected: (selected) => setState(
                    () => selected
                        ? _selectedTags.add(tag)
                        : _selectedTags.remove(tag),
                  ),
                  labelStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _selectedTags.contains(tag)
                        ? Theme.of(context).colorScheme.onPrimary
                        : context.colors.inputText,
                  ),
                  checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                  selectedColor: primary,
                  backgroundColor: context.colors.searchFill,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Anything else?',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.colors.sectionTitle,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _commentController,
            maxLines: 4,
            minLines: 3,
            textCapitalization: TextCapitalization.sentences,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: context.colors.inputText,
            ),
            decoration: InputDecoration(
              hintText: 'Tell us about the food and delivery',
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: context.colors.searchHint,
              ),
              filled: true,
              fillColor: context.colors.searchFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: PrimaryButton(
            label: 'Submit rating',
            // a star rating is required
            onPressed: _stars == 0 ? null : _submit,
          ),
        ),
      ),
    );
  }
}
