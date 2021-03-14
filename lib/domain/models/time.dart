class Time {
  final int hour;
  final int minute;
  final bool indifferent;

  Time({this.hour, this.minute, this.indifferent});

  @override
  String toString() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  @override
  bool operator ==(Object other) {
    if (other is Time) {
      return other.minute == this.minute && other.hour == other.hour;
    } else {
      return false;
    }
  }

  factory Time.fromInt(int time) {
    if (time == null) return null;

    final hour = (time / 100).round();
    final minute = time % 100;

    return Time(hour: hour, minute: minute, indifferent: false);
  }

  factory Time.indifferent() {
    return Time(hour: 0, minute: 0, indifferent: true);
  }

  DateTime toDateTime() {
    DateTime dt = DateTime.now();
    dt = new DateTime(dt.year, dt.month, dt.day, hour, minute, dt.second,
        dt.millisecond, dt.microsecond);

    return dt;
  }
}
