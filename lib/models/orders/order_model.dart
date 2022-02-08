import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:htask/models/orders/order_details_model.dart';

class OrderModel {
  int id;
  String guestName;
  String supervisorName;
  String status;
  String roomNumber;
  String payment;
  String date;
  String endTime;
  String actualEndTime;
  List<OrderDetailModel> orderdetails;
  OrderModel({
    required this.id,
    required this.guestName,
    required this.supervisorName,
    required this.status,
    required this.roomNumber,
    required this.payment,
    required this.date,
    required this.endTime,
    required this.actualEndTime,
    required this.orderdetails,
  });

  OrderModel copyWith({
    int? id,
    String? guestName,
    String? supervisorName,
    String? status,
    String? roomNumber,
    String? payment,
    String? date,
    String? endTime,
    String? actualEndTime,
    List<OrderDetailModel>? orderdetails,
  }) {
    return OrderModel(
      id: id ?? this.id,
      guestName: guestName ?? this.guestName,
      supervisorName: supervisorName ?? this.supervisorName,
      status: status ?? this.status,
      roomNumber: roomNumber ?? this.roomNumber,
      payment: payment ?? this.payment,
      date: date ?? this.date,
      endTime: endTime ?? this.endTime,
      actualEndTime: actualEndTime ?? this.actualEndTime,
      orderdetails: orderdetails ?? this.orderdetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guest_name': guestName,
      'supervisor_name': supervisorName,
      'status': status,
      'room_number': roomNumber,
      'payment': payment,
      'date': date,
      'endTime': endTime,
      'actualEndTime': actualEndTime,
      'orderdetails': orderdetails.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      guestName: map['guestName'] ?? '',
      supervisorName: map['supervisorName'] ?? '',
      status: map['status'] ?? '',
      roomNumber: map['roomNumber'] ?? '',
      payment: map['payment'] ?? '',
      date: map['date'] ?? '',
      endTime: map['endTime'] ?? '',
      actualEndTime: map['actualEndTime'] ?? '',
      orderdetails: List<OrderDetailModel>.from(
          map['orderdetails']?.map((x) => OrderDetailModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, guestName: $guestName, supervisorName: $supervisorName, status: $status, roomNumber: $roomNumber, payment: $payment, date: $date, endTime: $endTime, actualEndTime: $actualEndTime, orderdetails: $orderdetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.guestName == guestName &&
        other.supervisorName == supervisorName &&
        other.status == status &&
        other.roomNumber == roomNumber &&
        other.payment == payment &&
        other.date == date &&
        other.endTime == endTime &&
        other.actualEndTime == actualEndTime &&
        listEquals(other.orderdetails, orderdetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        guestName.hashCode ^
        supervisorName.hashCode ^
        status.hashCode ^
        roomNumber.hashCode ^
        payment.hashCode ^
        date.hashCode ^
        endTime.hashCode ^
        actualEndTime.hashCode ^
        orderdetails.hashCode;
  }
}
