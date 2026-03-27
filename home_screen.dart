import 'package:flutter/material.dart';
import '../models/reminder.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController controller = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  save() {
    if (controller.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) return;

    final finalDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    Navigator.pop(
      context,
      Reminder(title: controller.text, dateTime: finalDateTime),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Reminder")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Medicine"),
            ),
            ElevatedButton(onPressed: pickDate, child: Text("Pick Date")),
            ElevatedButton(onPressed: pickTime, child: Text("Pick Time")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
