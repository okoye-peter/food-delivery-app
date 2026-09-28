import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/product_image_tile.dart';
import 'package:yummy/ui/screens/home/widgets/home_section_card.dart';
import 'package:yummy/ui/screens/home/widgets/promo_badge.dart';

/// "Top discounts" card: title with a countdown, subtitle, and a horizontal
/// list of discounted products.
class HomeTopDiscounts extends StatefulWidget {
  const HomeTopDiscounts({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<HomeTopDiscounts> createState() => _HomeTopDiscountsState();
}

class _HomeTopDiscountsState extends State<HomeTopDiscounts> {
  // Shuffled once per widget, not per build, so the colours don't flash on
  // every setState
  final _tileColors = [...ProductImageTile.backgroundColors]..shuffle();

  @override
  Widget build(BuildContext context) {
    final promos = widget.products;
    final timerSeparator = Text(
      ':',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: context.colors.timerSeparator,
      ),
    );

    return HomeSectionCard(
      title: 'Top discounts',
      // TODO: drive the countdown from the promo end time
      titleSuffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _TimerBox('01'),
          const SizedBox(width: 4),
          timerSeparator,
          const SizedBox(width: 4),
          const _TimerBox('23'),
          const SizedBox(width: 4),
          timerSeparator,
          const SizedBox(width: 4),
          const _TimerBox('25'),
        ],
      ),
      subtitle: '\$10 off orders from \$50',
      trailing: const HomeSectionChevron(),
      // A horizontal list needs a fixed height
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 10, left: 5),
            itemBuilder: (_, index) => SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Stack(
                      // let the badge poke out above the image
                      clipBehavior: Clip.none,
                      children: [
                        ProductImageTile(
                          image: promos[index].image,
                          backgroundColor:
                              _tileColors[index % _tileColors.length],
                        ),
                        const Positioned(
                          top: -10,
                          left: -5,
                          child: PromoBadge(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    promos[index].name,
                    style: GoogleFonts.inter(
                      color: context.colors.inputText,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    promos[index].category.name,
                    style: GoogleFonts.inter(
                      color: context.colors.inputHint,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFF3AE2B),
                        size: 20,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        promos[index].rating.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: context.colors.inputText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '(${promos[index].ratingCount})',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: context.colors.inputLabel,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            separatorBuilder: (_, _) => const SizedBox(width: 15),
            itemCount: promos.length,
          ),
        ),
      ),
    );
  }
}

/// One two-digit segment of the countdown, e.g. "23".
class _TimerBox extends StatelessWidget {
  const _TimerBox(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: context.colors.timerFill,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: context.colors.onTimerFill,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
