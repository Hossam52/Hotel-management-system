import 'package:htask/models/pagination/pagination.dart';
import 'package:htask/models/pagination/pagination_links.dart';
import 'package:htask/models/supervisor/supervisor_employees/supervisor_employee_model.dart';

class NotificationsModel {
  bool? status;
  int? countUnreadNotify;
  Notifications? notifications;

  NotificationsModel({this.status, this.countUnreadNotify, this.notifications});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    countUnreadNotify = json['countUnreadNotify'];
    notifications = json['notifications'] != null
        ? Notifications.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['countUnreadNotify'] = countUnreadNotify;
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    return data;
  }

  NotificationsModel copyWith({
    bool? status,
    int? countUnreadNotify,
    Notifications? notifications,
  }) {
    return NotificationsModel(
      status: status ?? this.status,
      countUnreadNotify: countUnreadNotify ?? this.countUnreadNotify,
      notifications: notifications ?? this.notifications,
    );
  }
}

class Notifications {
  List<NotificationData>? data;
  PaginnationLinks? links;
  PaginnationMeta? meta;

  Notifications({this.data, this.links, this.meta});

  Notifications.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
    links =
        json['links'] != null ? PaginnationLinks.fromMap(json['links']) : null;
    meta = json['meta'] != null ? PaginnationMeta.fromMap(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }

  Notifications copyWith({
    List<NotificationData>? data,
    PaginnationLinks? links,
    PaginnationMeta? meta,
  }) {
    return Notifications(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }
}

class NotificationData {
  int? id;
  String? title;
  String? body;
  String? type;
  ReciverId? reciverId;
  int? orderId;
  String? readAt;

  NotificationData(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.reciverId,
      this.orderId,
      this.readAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    reciverId = json['reciver_id'] != null
        ? ReciverId.fromJson(json['reciver_id'])
        : null;
    orderId = json['order_id'];
    readAt = json['read_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['type'] = type;
    if (reciverId != null) {
      data['reciver_id'] = reciverId!.toJson();
    }
    data['order_id'] = orderId;
    data['read_at'] = readAt;
    return data;
  }
}

class ReciverId {
  int? id;
  String? name;
  String? email;
  String? block;
  String? image;
  List<EmployeeResponsibilitiesModel>? res;

  ReciverId({this.id, this.name, this.email, this.block, this.image, this.res});

  ReciverId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    block = json['block'];
    image = json['image'];
    if (json['res'] != null) {
      res = <EmployeeResponsibilitiesModel>[];
      json['res'].forEach((v) {
        res!.add(EmployeeResponsibilitiesModel.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['block'] = block;
    data['image'] = image;
    if (res != null) {
      data['res'] = res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
