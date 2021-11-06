import 'dart:convert';

import 'package:equatable/equatable.dart';

class CourseAudio extends Equatable {
  final String? audio;
  final String? audioId;
  final String? name;

  const CourseAudio({
    this.audio,
    this.audioId,
    this.name,
  });

  CourseAudio copyWith({
    String? audio,
    String? audioId,
    String? name,
  }) {
    return CourseAudio(
      audio: audio ?? this.audio,
      audioId: audioId ?? this.audioId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'audio': audio,
      'audioId': audioId,
      'name': name,
    };
  }

  factory CourseAudio.fromMap(Map<String, dynamic> map) {
    return CourseAudio(
      audio: map['audio'],
      audioId: map['audioId'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAudio.fromJson(String source) =>
      CourseAudio.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [audio, audioId, name];
}
