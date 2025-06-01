String formatDateToExtensive(DateTime date) {
  const months = [
    'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
  ];

  final day = date.day;
  final month = months[date.month - 1];
  final year = date.year;

  return '$day de $month de $year';
}
