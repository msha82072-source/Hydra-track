class Reminder {
  final String id;
  final String time;
  final String title;
  final int amount;
  bool isActive;

  Reminder({
    required this.id,
    required this.time,
    required this.title,
    required this.amount,
    this.isActive = true,
  });
}
