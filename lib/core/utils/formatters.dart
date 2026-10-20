class Formatters {
  Formatters._();

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static String dateTime(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.day} ${_months[d.month - 1]} ${d.year}, '
        '${two(d.hour)}:${two(d.minute)}';
  }

  static String duration(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return m > 0 ? '${m}m ${s.toString().padLeft(2, '0')}d' : '${s}d';
  }
}
