import 'dart:convert';

class CategoryRequestModel {
  int? categoryId;
  String? date;
  CategoryRequestModel({
    this.categoryId,
    this.date,
  });

  CategoryRequestModel copyWith({
    int? categoryId,
    String? date,
  }) {
    return CategoryRequestModel(
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'date': date,
    };
  }

  factory CategoryRequestModel.fromMap(Map<String, dynamic> map) {
    return CategoryRequestModel(
      categoryId: map['categoryId'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryRequestModel.fromJson(String source) =>
      CategoryRequestModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CategoryRequestModel(categoryId: $categoryId, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryRequestModel &&
        other.categoryId == categoryId &&
        other.date == date;
  }

  @override
  int get hashCode => categoryId.hashCode ^ date.hashCode;
}
