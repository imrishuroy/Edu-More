import 'dart:convert';

import 'package:equatable/equatable.dart';

class CoursePdf extends Equatable {
  final String? name;
  final String? pdf;
  final String? pdfId;

  const CoursePdf({
    this.name,
    this.pdf,
    this.pdfId,
  });

  CoursePdf copyWith({
    String? name,
    String? pdf,
    String? pdfId,
  }) {
    return CoursePdf(
      name: name ?? this.name,
      pdf: pdf ?? this.pdf,
      pdfId: pdfId ?? this.pdfId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pdf': pdf,
      'pdfId': pdfId,
    };
  }

  factory CoursePdf.fromMap(Map<String, dynamic> map) {
    return CoursePdf(
      name: map['name'],
      pdf: map['pdf'],
      pdfId: map['pdfId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoursePdf.fromJson(String source) =>
      CoursePdf.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, pdf, pdfId];
}
