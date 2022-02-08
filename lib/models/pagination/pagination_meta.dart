import 'dart:convert';

class PaginnationMeta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;
  PaginnationMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  PaginnationMeta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) {
    return PaginnationMeta(
      currentPage: currentPage ?? this.currentPage,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentPage': currentPage,
      'from': from,
      'lastPage': lastPage,
      'path': path,
      'perPage': perPage,
      'to': to,
      'total': total,
    };
  }

  factory PaginnationMeta.fromMap(Map<String, dynamic> map) {
    return PaginnationMeta(
      currentPage: map['currentPage']?.toInt() ?? 0,
      from: map['from']?.toInt() ?? 0,
      lastPage: map['lastPage']?.toInt() ?? 0,
      path: map['path'] ?? '',
      perPage: map['perPage']?.toInt() ?? 0,
      to: map['to']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginnationMeta.fromJson(String source) =>
      PaginnationMeta.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaginnationMeta(currentPage: $currentPage, from: $from, lastPage: $lastPage, path: $path, perPage: $perPage, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginnationMeta &&
        other.currentPage == currentPage &&
        other.from == from &&
        other.lastPage == lastPage &&
        other.path == path &&
        other.perPage == perPage &&
        other.to == to &&
        other.total == total;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        from.hashCode ^
        lastPage.hashCode ^
        path.hashCode ^
        perPage.hashCode ^
        to.hashCode ^
        total.hashCode;
  }
}
