/// "$12.50"
String formatPrice(double value) => '\$${value.toStringAsFixed(2)}';

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _twoDigits(int n) => n.toString().padLeft(2, '0');

/// "14:05"
String formatTime(DateTime date) =>
    '${_twoDigits(date.hour)}:${_twoDigits(date.minute)}';

/// "9 Oct 2026"
String formatDate(DateTime date) =>
    '${date.day} ${_months[date.month - 1]} ${date.year}';

/// "9 Oct 2026, 14:05"
String formatDateTime(DateTime date) =>
    '${formatDate(date)}, ${formatTime(date)}';
