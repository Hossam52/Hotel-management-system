import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:htask/models/orders/order_details_model.dart';

class OrderModel {
  final int id;
  final String guestName;
  final String employeeName;
  final String supervisorName;
  final String status;
  final int roomNum;
  final int roomId;
  final String payment;
  final String? floor;
  final String date;
  final String note;
  final String endTime;
  final String? actualEndTime;
  final List<OrderDetailModel> orderdetails;
  double totalPrice;
  OrderModel(
      {required this.id,
      required this.guestName,
      required this.employeeName,
      required this.supervisorName,
      required this.status,
      required this.roomNum,
      required this.payment,
      required this.floor,
      required this.date,
      required this.note,
      required this.endTime,
      required this.actualEndTime,
      required this.orderdetails,
      required this.roomId,
      this.totalPrice = 0}) {
    for (var element in orderdetails) {
      totalPrice += element.price * element.quantity;
    }
  }

  OrderModel copyWith({
    int? id,
    String? guestName,
    String? employeeName,
    String? supervisorName,
    String? status,
    int? roomNum,
    int? roomId,
    String? payment,
    String? floor,
    String? date,
    String? note,
    String? endTime,
    String? actualEndTime,
    List<OrderDetailModel>? orderdetails,
  }) {
    return OrderModel(
        id: id ?? this.id,
        guestName: guestName ?? this.guestName,
        employeeName: employeeName ?? this.employeeName,
        supervisorName: supervisorName ?? this.supervisorName,
        status: status ?? this.status,
        roomNum: roomNum ?? this.roomNum,
        payment: payment ?? this.payment,
        date: date ?? this.date,
        note: note ?? this.note,
        endTime: endTime ?? this.endTime,
        actualEndTime: actualEndTime ?? this.actualEndTime,
        orderdetails: orderdetails ?? this.orderdetails,
        floor: floor ?? this.floor,
        roomId: roomId ?? this.roomId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guest_name': guestName,
      'employee_name': employeeName,
      'supervisor_name': supervisorName,
      'status': status,
      'room_num': roomNum,
      'room_id': roomId,
      'payment': payment,
      'floor': floor,
      'date': date,
      'end_time': endTime,
      'actual_end_time': actualEndTime,
      'orderdetails': orderdetails.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      guestName: map['guest_name'] ?? '',
      employeeName: map['employee_name'] ?? '',
      supervisorName: map['supervisor_name'] ?? '',
      status: map['status'] ?? '',
      roomNum: map['room_num'] ?? '',
      roomId: map['room_id'] ?? '',
      payment: map['payment'] ?? '',
      floor: map['floor'],
      date: map['date'] ?? '',
      note: map['note'] ?? '',
      endTime: map['end_time'] ?? '',
      actualEndTime: map['actual_end_time'],
      orderdetails: List<OrderDetailModel>.from(
          map['orderdetails']?.map((x) => OrderDetailModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, guestName: $guestName, employeeName: $employeeName, supervisorName: $supervisorName, status: $status, roomNum: $roomNum, payment: $payment,floor: $floor date: $date, endTime: $endTime, actualEndTime: $actualEndTime, orderdetails: $orderdetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.guestName == guestName &&
        other.employeeName == employeeName &&
        other.supervisorName == supervisorName &&
        other.status == status &&
        other.roomNum == roomNum &&
        other.payment == payment &&
        other.floor == floor &&
        other.date == date &&
        other.endTime == endTime &&
        other.actualEndTime == actualEndTime &&
        listEquals(other.orderdetails, orderdetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        guestName.hashCode ^
        employeeName.hashCode ^
        supervisorName.hashCode ^
        status.hashCode ^
        roomNum.hashCode ^
        payment.hashCode ^
        date.hashCode ^
        floor.hashCode ^
        endTime.hashCode ^
        actualEndTime.hashCode ^
        orderdetails.hashCode;
  }
}
