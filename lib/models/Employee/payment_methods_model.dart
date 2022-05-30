// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class PaymentMethodsModel {
  bool status;
  int api;
  List<PaymentItemModel> payments;
  PaymentMethodsModel({
    required this.status,
    required this.api,
    required this.payments,
  });

  factory PaymentMethodsModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodsModel(
      status: map['status'] ?? false,
      api: map['api']?.toInt() ?? 0,
      payments: List<PaymentItemModel>.from(map['payments']
          ?.map((x) => PaymentItemModel.fromMap(map['api']?.toInt() ?? 0, x))),
    );
  }
}

abstract class PaymentItemModel {
  PaymentItemModel();
  String getId();

  String getName();

  factory PaymentItemModel.fromMap(int api, Map<String, dynamic> map) {
    if (api == 0) {
      return _OrganizationPayments.fromMap(map);
    } else {
      return _GatewayPaymets.fromMap(map);
    }
  }
}

class _OrganizationPayments extends PaymentItemModel {
  int id;
  String name;
  int hotel_id;
  String status;
  String type;
  String createdAt;
  String updatedAt;
  _OrganizationPayments({
    required this.id,
    required this.name,
    required this.hotel_id,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'hotel_id': hotel_id,
      'status': status,
      'type': type,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory _OrganizationPayments.fromMap(Map<String, dynamic> map) {
    return _OrganizationPayments(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      hotel_id: map['hotel_id']?.toInt() ?? 0,
      status: map['status'] ?? '',
      type: map['type'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  @override
  String getId() {
    return id.toString();
  }

  @override
  String getName() {
    return name;
  }
}

class _GatewayPaymets extends PaymentItemModel {
  String PayMethodId;
  String PaymentID;
  String Name;
  String ShortCode;
  String Type;
  String CardProcessing;
  String SurchargeApplicable;
  String SurchargeType;
  String SurchargeValue;
  String SurchargeID;
  String SurchargeName;
  _GatewayPaymets({
    required this.PayMethodId,
    required this.PaymentID,
    required this.Name,
    required this.ShortCode,
    required this.Type,
    required this.CardProcessing,
    required this.SurchargeApplicable,
    required this.SurchargeType,
    required this.SurchargeValue,
    required this.SurchargeID,
    required this.SurchargeName,
  });

  factory _GatewayPaymets.fromMap(Map<String, dynamic> map) {
    return _GatewayPaymets(
      PayMethodId: map['PayMethodId'] ?? '',
      PaymentID: map['PaymentID'] ?? '',
      Name: map['Name'] ?? '',
      ShortCode: map['ShortCode'] ?? '',
      Type: map['Type'] ?? '',
      CardProcessing: map['CardProcessing'] ?? '',
      SurchargeApplicable: map['SurchargeApplicable'] ?? '',
      SurchargeType: map['SurchargeType'] ?? '',
      SurchargeValue: map['SurchargeValue'] ?? '',
      SurchargeID: map['SurchargeID'] ?? '',
      SurchargeName: map['SurchargeName'] ?? '',
    );
  }

  @override
  String getId() {
    return PaymentID;
  }

  @override
  String getName() {
    return '$Name ($ShortCode)';
  }
}
