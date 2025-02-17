class Activity {
  String? activity;
  String? type;
  int? participants;
  double? price;
  String? link;
  String? key;
  double? accessibility;

  Activity({
    this.activity,
    this.type,
    this.participants,
    this.price,
    this.link,
    this.key,
    this.accessibility,
  });

  // From JSON
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'],
      type: json['type'],
      participants: json['participants'],
      price: (json['price'] as num).toDouble(), // Convert to double
      link: json['link'],
      key: json['key'],
      accessibility: (json['accessibility'] as num).toDouble(), // Convert to double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'type': type,
      'participants': participants,
      'price': price,
      'link': link,
      'key': key,
      'accessibility': accessibility,
    };
  }
}
