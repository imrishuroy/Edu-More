import 'dart:convert';

import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final String? name;
  final String? video;
  final List? watched;
  final String? chapterId;

  const Chapter({
    this.name,
    this.video,
    this.watched,
    this.chapterId,
  });

  @override
  List<Object?> get props => [name, video, watched, chapterId];

  Chapter copyWith({
    String? name,
    String? video,
    List? watched,
    String? chapterId,
  }) {
    return Chapter(
      name: name ?? this.name,
      video: video ?? this.video,
      watched: watched ?? this.watched,
      chapterId: chapterId ?? this.chapterId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'video': video,
      'watched': watched,
      'chapterId': chapterId,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
        name: map['name'],
        video: map['video'],
        watched: map['watched'],
        chapterId: map['chapterId']);
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
