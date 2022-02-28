import 'dart:convert';

class CategoryRequestModel {
  int? categoryId;
  String? date;
  String? from;
  String? to;
  CategoryRequestModel({
    this.categoryId,
    this.date,
    this.from,
    this.to,
  });

  CategoryRequestModel copyWith({
    int? category_id,
    String? date,
    String? from,
    String? to,
  }) {
    return CategoryRequestModel(
      categoryId: category_id ?? this.categoryId,
      date: date ?? this.date,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'date': date,
      'from': from,
      'to': to,
    };
  }

  factory CategoryRequestModel.fromMap(Map<String, dynamic> map) {
    return CategoryRequestModel(
      categoryId: map['category_id']?.toInt(),
      date: map['date'],
      from: map['from'],
      to: map['to'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryRequestModel.fromJson(String source) =>
      CategoryRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryRequestModel(category_id: $categoryId, date: $date, from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryRequestModel &&
        other.categoryId == categoryId &&
        other.date == date &&
        other.from == from &&
        other.to == to;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^ date.hashCode ^ from.hashCode ^ to.hashCode;
  }
}
