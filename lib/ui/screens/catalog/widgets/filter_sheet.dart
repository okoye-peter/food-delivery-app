import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/product_filter.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/core/widgets/primary_button.dart';
import 'package:yummy/utils/formatters.dart';

/// Opens the sort and filter options. Returns the new filter, or null when
/// dismissed.
Future<ProductFilter?> showFilterSheet(
  BuildContext context, {
  required ProductFilter filter,
  required double highestPrice,
}) => showModalBottomSheet<ProductFilter>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  // over the bottom navigation bar
  useRootNavigator: true,
  backgroundColor: context.colors.cardBackground,
  builder: (_) => _FilterSheet(filter: filter, highestPrice: highestPrice),
);

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({required this.filter, required this.highestPrice});

  final ProductFilter filter;
  final double highestPrice;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  static const _ratingOptions = [0.0, 3.5, 4.0, 4.5];

  late var _filter = widget.filter;

  // whole dollars, so the slider has clean steps
  late final _priceCap = widget.highestPrice.ceilToDouble();

  @override
  Widget build(BuildContext context) {
    final maxPrice = _filter.maxPrice ?? _priceCap;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: context.colors.sectionTitle,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      setState(() => _filter = _filter.resetSheet()),
                  child: Text(
                    'Reset',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: context.colors.link,
                    ),
                  ),
                ),
              ],
            ),

            const _Heading('Sort by'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final sort in ProductSort.values)
                  _OptionChip(
                    label: sort.label,
                    selected: _filter.sort == sort,
                    onTap: () =>
                        setState(() => _filter = _filter.copyWith(sort: sort)),
                  ),
              ],
            ),

            _Heading(
              'Max price',
              trailing: _filter.maxPrice == null
                  ? 'Any price'
                  : 'Up to ${formatPrice(maxPrice)}',
            ),
            Slider(
              value: maxPrice,
              min: 1,
              max: _priceCap,
              divisions: (_priceCap - 1).round(),
              label: formatPrice(maxPrice),
              onChanged: (value) => setState(
                // the far right end means no limit
                () => _filter = _filter.copyWith(
                  maxPrice: value >= _priceCap ? null : value,
                ),
              ),
            ),

            const _Heading('Rating'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final rating in _ratingOptions)
                  _OptionChip(
                    label: rating == 0 ? 'Any' : '$rating+',
                    icon: rating == 0 ? null : Icons.star,
                    selected: _filter.minRating == rating,
                    onTap: () => setState(
                      () => _filter = _filter.copyWith(minRating: rating),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _filter.dealsOnly,
              onChanged: (value) =>
                  setState(() => _filter = _filter.copyWith(dealsOnly: value)),
              title: Text(
                'Deals only',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: context.colors.sectionTitle,
                ),
              ),
              subtitle: Text(
                'Meals with a discount right now',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: context.colors.subtitle,
                ),
              ),
            ),

            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Show results',
              onPressed: () => Navigator.pop(context, _filter),
            ),
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text, {this.trailing});

  final String text;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: context.colors.sectionTitle,
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.colors.subtitle,
              ),
            ),
        ],
      ),
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = selected
        ? colorScheme.onPrimary
        : context.colors.inputText;

    return ChoiceChip(
      label: Text(label),
      avatar: icon == null ? null : Icon(icon, size: 16, color: foreground),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      labelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: foreground,
      ),
      selectedColor: colorScheme.primary,
      backgroundColor: context.colors.searchFill,
      side: BorderSide.none,
      shape: const StadiumBorder(),
    );
  }
}
