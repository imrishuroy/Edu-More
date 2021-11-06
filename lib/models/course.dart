import 'dart:convert';

import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String? courseId;
  final String? name;
  final String? video;
  final String? description;
  final String? imageUrl;
  final double? price;
  final List? buyers;
  final bool upcomming;

  const Course({
    this.courseId,
    this.name,
    this.video,
    this.description,
    this.imageUrl,
    this.price,
    this.buyers,
    this.upcomming = false,
  });

  Course copyWith({
    String? courseId,
    String? name,
    String? video,
    String? description,
    String? imageUrl,
    double? price,
    List<String?>? buyers,
    bool? upcomming,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      video: video ?? this.video,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      buyers: buyers ?? this.buyers,
      upcomming: upcomming ?? this.upcomming,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'name': name,
      'video': video,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'buyers': buyers,
      'upcomming': upcomming,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['courseId'],
      name: map['name'] ?? '',
      video: map['video'],
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      price: double.tryParse(map['price'].toString()),
      buyers: map['buyers'] ?? [],
      upcomming: map['upcomming'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      courseId,
      name,
      video,
      description,
      imageUrl,
      price,
      buyers,
      upcomming,
    ];
  }
}

// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// import 'package:course_app/models/chapter.dart';

// class Course extends Equatable {
//   final String? courseId;
//   final String? name;
//   final String? video;
//   final String? description;
//   final String? imageUrl;
//   final double? price;
//   final List<Chapter?>? chapters;
//   final List? buyers;

//   Course({
//     this.courseId,
//     this.name,
//     this.video,
//     this.description,
//     this.imageUrl,
//     this.price,
//     this.chapters,
//     this.buyers,
//   });

//   Course copyWith({
//     String? courseId,
//     String? name,
//     String? video,
//     String? description,
//     String? imageUrl,
//     double? price,
//     List<Chapter?>? chapters,
//     List<String?>? buyers,
//   }) {
//     return Course(
//       courseId: courseId ?? this.courseId,
//       name: name ?? this.name,
//       video: video ?? this.video,
//       description: description ?? this.description,
//       imageUrl: imageUrl ?? this.imageUrl,
//       price: price ?? this.price,
//       chapters: chapters ?? this.chapters,
//       buyers: buyers ?? this.buyers,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'courseId': courseId,
//       'name': name,
//       'video': video,
//       'description': description,
//       'imageUrl': imageUrl,
//       'price': price,
//       'chapters': chapters?.map((x) => x?.toMap()).toList(),
//       'buyers': buyers,
//     };
//   }

//   factory Course.fromMap(Map<String, dynamic> map) {
//     return Course(
//       courseId: map['courseId'],
//       name: map['name'],
//       video: map['video'],
//       description: map['description'],
//       imageUrl: map['imageUrl'],
//       price: map['price'],
//       chapters:
//           List<Chapter?>.from(map['chapters']?.map((x) => Chapter?.fromMap(x))),
//       // buyers: List<String?>.from(map['buyers']?.map((x) => x.toString())),
//       buyers: map['buyers'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

//   @override
//   bool get stringify => true;

//   @override
//   List<Object?> get props {
//     return [
//       courseId,
//       name,
//       video,
//       description,
//       imageUrl,
//       price,
//       chapters,
//       buyers,
//     ];
//   }
// }
