// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  int? status;
  String? message;
  AppointmentData? data;

  Appointment({
    this.status,
    this.message,
    this.data,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AppointmentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AppointmentData {
  int? currentPage;
  List<AppointmentListData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  AppointmentData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) => AppointmentData(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<AppointmentListData>.from(json["data"]!.map((x) => AppointmentListData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class AppointmentListData {
  int? id;
  int? businessId;
  String? name;
  String? email;
  String? phone;
  DateTime? date;
  String? time;
  Status? status;
  String? note;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? businessName;

  AppointmentListData({
    this.id,
    this.businessId,
    this.name,
    this.email,
    this.phone,
    this.date,
    this.time,
    this.status,
    this.note,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.businessName,
  });

  factory AppointmentListData.fromJson(Map<String, dynamic> json) => AppointmentListData(
    id: json["id"],
    businessId: json["business_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    status: statusValues.map[json["status"]]!,
    note: json["note"],
    createdBy: json["created_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    businessName: json["business_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "name": name,
    "email": email,
    "phone": phone,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "status": statusValues.reverse[status],
    "note": note,
    "created_by": createdBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "business_name": businessName,
  };
}

enum Status {
  COMPLETED,
  PENDING
}

final statusValues = EnumValues({
  "completed": Status.COMPLETED,
  "pending": Status.PENDING
});

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
