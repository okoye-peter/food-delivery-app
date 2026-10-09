import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/category_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// Horizontal row of food categories, each a gradient circle with its
/// logo and name underneath.
class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onCategoryTap(categories[index]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: categories[index].gradient,
                ),
                child: Image.asset(
                  categories[index].logo,
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                categories[index].name,
                style: GoogleFonts.inter(
                  color: context.colors.inputText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (_, _) => const SizedBox(width: 24),
        itemCount: categories.length,
      ),
    );
  }
}
