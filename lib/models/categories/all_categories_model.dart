import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:htask/models/categories/category_model.dart';

class AllCategoriesModel {
  final bool status;
  final List<CategoryModel> categories;
  AllCategoriesModel({
    required this.status,
    required this.categories,
  });

  AllCategoriesModel copyWith({
    bool? status,
    List<CategoryModel>? categories,
  }) {
    return AllCategoriesModel(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory AllCategoriesModel.fromMap(Map<String, dynamic> map) {
    return AllCategoriesModel(
      status: map['status'] ?? false,
      categories: List<CategoryModel>.from(
          map['categories']?.map((x) => CategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllCategoriesModel.fromJson(String source) =>
      AllCategoriesModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AllCategoriesModel(status: $status, categories: $categories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllCategoriesModel &&
        other.status == status &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode => status.hashCode ^ categories.hashCode;
}
