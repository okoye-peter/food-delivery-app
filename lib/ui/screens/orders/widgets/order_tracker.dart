import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/data/models/order_model.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';
import 'package:yummy/ui/screens/orders/widgets/order_status_chip.dart';
import 'package:yummy/utils/formatters.dart';

/// Vertical timeline of the order's statuses: done steps are ticked with
/// their time, the current one is highlighted, later ones are greyed out.
class OrderTracker extends StatelessWidget {
  const OrderTracker({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    const steps = OrderStatus.values;

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          _Step(
            status: steps[i],
            time: order.statusTimes[steps[i]],
            reached: i <= order.status.index,
            current: i == order.status.index && order.status.isActive,
            isLast: i == steps.length - 1,
            // the line below a step is coloured once the next step is reached
            lineReached: i < order.status.index,
          ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.status,
    required this.time,
    required this.reached,
    required this.current,
    required this.isLast,
    required this.lineReached,
  });

  final OrderStatus status;
  final DateTime? time;
  final bool reached;
  final bool current;
  final bool isLast;
  final bool lineReached;

  @override
  Widget build(BuildContext context) {
    final color = orderStatusColor(status);
    final muted = context.colors.divider;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: reached ? color : Colors.transparent,
                    border: Border.all(
                      color: reached ? color : muted,
                      width: 2,
                    ),
                    boxShadow: current
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.35),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    reached && !current ? Icons.check : orderStatusIcon(status),
                    size: 18,
                    color: reached ? Colors.white : context.colors.inputLabel,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: lineReached ? color : muted,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 6, bottom: isLast ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          status.label,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: reached
                                ? context.colors.sectionTitle
                                : context.colors.inputLabel,
                          ),
                        ),
                      ),
                      Text(
                        time == null ? '' : formatTime(time!),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: context.colors.subtitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: reached
                          ? context.colors.subtitle
                          : context.colors.inputLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
