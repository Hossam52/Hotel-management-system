import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:htask/models/orders/order_model.dart';
import 'package:htask/models/pagination/pagination.dart';

class OrderStatusModel {
  List<OrderModel> data;
  PaginnationLinks links;
  PaginnationMeta meta;
  OrderStatusModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  OrderStatusModel copyWith({
    List<OrderModel>? data,
    PaginnationLinks? links,
    PaginnationMeta? meta,
  }) {
    return OrderStatusModel(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'links': links.toMap(),
      'meta': meta.toMap(),
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      data:
          List<OrderModel>.from(map['data']?.map((x) => OrderModel.fromMap(x))),
      links: PaginnationLinks.fromMap(map['links']),
      meta: PaginnationMeta.fromMap(map['meta']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusModel.fromJson(String source) =>
      OrderStatusModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderStatusModel(data: $data, links: $links, meta: $meta)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderStatusModel &&
        listEquals(other.data, data) &&
        other.links == links &&
        other.meta == meta;
  }

  @override
  int get hashCode => data.hashCode ^ links.hashCode ^ meta.hashCode;
}
