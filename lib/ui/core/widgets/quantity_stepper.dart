import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

/// − 2 + control.
///
/// With [removable], the minus button turns into a bin at 1 and goes down to
/// 0, so the caller can remove the item.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.removable = false,
    this.compact = false,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final bool removable;

  /// Smaller buttons, for list rows.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final showBin = removable && quantity <= 1;
    final canDecrease = removable || quantity > 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepButton(
          icon: showBin ? Icons.delete_outline : Icons.remove,
          tooltip: showBin ? 'Remove' : 'Decrease',
          compact: compact,
          onPressed: canDecrease ? () => onChanged(quantity - 1) : null,
        ),
        SizedBox(
          width: compact ? 28 : 36,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: compact ? 15 : 17,
              fontWeight: FontWeight.w700,
              color: context.colors.inputText,
            ),
          ),
        ),
        _StepButton(
          icon: Icons.add,
          tooltip: 'Increase',
          compact: compact,
          filled: true,
          onPressed: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.compact,
    required this.onPressed,
    this.filled = false,
  });

  final IconData icon;
  final String tooltip;
  final bool compact;
  final bool filled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = compact ? 30.0 : 40.0;

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      iconSize: compact ? 16 : 20,
      style: IconButton.styleFrom(
        fixedSize: Size.square(size),
        minimumSize: Size.square(size),
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: filled
            ? colorScheme.primary
            : context.colors.searchFill,
        foregroundColor: filled
            ? colorScheme.onPrimary
            : context.colors.inputText,
        disabledBackgroundColor: context.colors.searchFill,
        disabledForegroundColor: context.colors.inputLabel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(icon),
    );
  }
}
