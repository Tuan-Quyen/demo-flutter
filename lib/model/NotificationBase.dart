class NotificationData {
  String title;
  String overview;
  int badge;

  NotificationData.storeData(String title, String overview, int badge) {
    this.title = title;
    this.overview = overview;
    this.badge = badge;
  }
}

// Parse data for iOS Notification
class NotificationIOS {
  String status;
  String id;
  Aps aps;
  String title;
  String overview;

  NotificationIOS({
    this.status,
    this.id,
    this.aps,
    this.title,
    this.overview,
  });

  factory NotificationIOS.fromJson(Map<String, dynamic> json) =>
      new NotificationIOS(
        status: json["status"],
        id: json["id"],
        aps: Aps.fromJson(Map.from(json["aps"])),
        title: json["title"],
        overview: json["overview"],
      );
}

class Aps {
  int badge;
  Alert alert;

  Aps({
    this.badge,
    this.alert,
  });

  factory Aps.fromJson(Map<String, dynamic> json) {
    return Aps(
      badge: json["badge"],
      alert: Alert.fromJson(Map.from(json["alert"])),
    );
  }
}

class Alert {
  String title;
  String body;

  Alert({
    this.title,
    this.body,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => new Alert(
        title: json["title"],
        body: json["body"],
      );
}

// Parse data for Android Notification
class NotificationAndroid {
  Alert notification;
  Data data;

  NotificationAndroid({
    this.notification,
    this.data,
  });

  factory NotificationAndroid.fromJson(Map<String, dynamic> json) {
    return NotificationAndroid(
      notification: Alert.fromJson(Map.from(json["notification"])),
      data: Data.fromJson(Map.from(json["data"])),
    );
  }
}

class Data {
  String status;
  String title;
  String overview;
  String badge;

  Data({
    this.status,
    this.title,
    this.overview,
    this.badge,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      status: json["status"],
      title: json["title"],
      overview: json["overview"],
      badge: json["badge"],
    );
  }
}
