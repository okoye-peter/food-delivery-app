import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/category_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// Horizontal "All" + one chip per category. [selectedId] null is "All".
class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<CategoryModel> categories;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          if (index == 0) {
            return _Chip(
              label: 'All',
              selected: selectedId == null,
              onTap: () => onSelected(null),
            );
          }
          final category = categories[index - 1];
          return _Chip(
            label: category.name,
            selected: selectedId == category.id,
            onTap: () => onSelected(category.id),
            avatar: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: category.gradient,
              ),
              child: Image.asset(category.logo),
            ),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.avatar,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChoiceChip(
      label: Text(label),
      avatar: avatar,
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      labelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: selected ? colorScheme.onPrimary : context.colors.inputText,
      ),
      selectedColor: colorScheme.primary,
      backgroundColor: context.colors.searchFill,
      side: BorderSide.none,
      shape: const StadiumBorder(),
    );
  }
}
