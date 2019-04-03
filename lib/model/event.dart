


enum EventType {
  projectFilter
}


class Event {
  EventType eventType;

  String payload;

  DateTime get dateTime {
    return DateTime.now();
  }

  Event(this.eventType, this.payload);
}