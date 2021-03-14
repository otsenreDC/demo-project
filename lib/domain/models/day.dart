import 'package:cloud_firestore/cloud_firestore.dart';

class Day {
  final int id;
  final bool workday;
  final bool holiday;
  final List<DaySlot> daySlots;

  Day({this.id, this.workday, this.holiday, this.daySlots});

  DateTime toDateTime() {
    print(DateTime(2021, 0, id, 0, 0, 0, 0, 0).toString());
    return DateTime.now();
  }
}

class DaySlot {
  String appointmentReference;
  bool taken;
  bool _inOrderOfArrival = false;
  Timestamp start;

  bool get inOrderOfArrival {
    return _inOrderOfArrival;
  }

  DaySlot({
    this.appointmentReference,
    this.taken,
    this.start,
  });

  DaySlot.inOrderOfArrival() {
    this._inOrderOfArrival = true;
  }

  DateTime startInDateTime() {
    return this.start != null ? this.start.toDate() : DateTime(2021);
  }

  DaySlot copy() {
    final copy = DaySlot(
        taken: this.taken,
        start: this.start,
        appointmentReference: this.appointmentReference);
    copy._inOrderOfArrival = this._inOrderOfArrival;
    return copy;
  }
}
