import 'dart:convert';

class PaginnationLinks {
  String first;
  String last;
  String? previous;
  String? next;
  PaginnationLinks({
    required this.first,
    required this.last,
    this.previous,
    this.next,
  });

  PaginnationLinks copyWith({
    String? first,
    String? last,
    String? previous,
    String? next,
  }) {
    return PaginnationLinks(
      first: first ?? this.first,
      last: last ?? this.last,
      previous: previous ?? this.previous,
      next: next ?? this.next,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'last': last,
      'previous': previous,
      'next': next,
    };
  }

  factory PaginnationLinks.fromMap(Map<String, dynamic> map) {
    return PaginnationLinks(
      first: map['first'] ?? '',
      last: map['last'] ?? '',
      previous: map['previous'],
      next: map['next'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginnationLinks.fromJson(String source) =>
      PaginnationLinks.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaginnationLinks(first: $first, last: $last, previous: $previous, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginnationLinks &&
        other.first == first &&
        other.last == last &&
        other.previous == previous &&
        other.next == next;
  }

  @override
  int get hashCode {
    return first.hashCode ^ last.hashCode ^ previous.hashCode ^ next.hashCode;
  }
}
