import 'package:get/get.dart';
import '../../data/models/reminder_model.dart';

class RemindersController extends GetxController {
  var reminders = <Reminder>[
    Reminder(id: '1', time: '07:30 AM', title: 'Early Morning', amount: 250),
    Reminder(id: '2', time: '09:45 AM', title: 'Work Start', amount: 200),
    Reminder(id: '3', time: '12:30 PM', title: 'Lunch Break', amount: 350),
    Reminder(id: '4', time: '03:00 PM', title: 'Afternoon Tea', amount: 200, isActive: false),
    Reminder(id: '5', time: '06:00 PM', title: 'Post Work', amount: 200),
    Reminder(id: '6', time: '09:30 PM', title: 'Bedtime', amount: 200),
  ].obs;

  void toggleReminder(String id) {
    var index = reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      reminders[index].isActive = !reminders[index].isActive;
      reminders.refresh();
    }
  }

  void addReminder(Reminder reminder) {
    reminders.add(reminder);
  }

  void removeReminder(String id) {
    reminders.removeWhere((r) => r.id == id);
  }
}
