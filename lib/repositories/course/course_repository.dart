import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/chapter.dart';
import '/models/course.dart';
import '/models/course_audio.dart';
import '/models/course_pdf.dart';

class CourseRepository {
  final _firestore = FirebaseFirestore.instance;

  // final CollectionReference _firestore.collection(Paths.courses) =
  //     FirebaseFirestore.instance.collection('dev-course');

  // final CollectionReference _userRef =
  //     FirebaseFirestore.instance.collection(Paths.users);

  Future<QuerySnapshot<Course>> getAllCourses() async {
    try {
      return await _firestore
          .collection(Paths.courses)

          // return await _firestore.collection(Paths.courses)
          .withConverter<Course>(
              fromFirestore: (snapshot, _) => Course.fromMap(snapshot.data()!),
              toFirestore: (course, _) => course.toMap())
          .get();
    } catch (error) {
      print('Error getting courses ${error.toString()}');
      rethrow;
    }
  }

  Stream<QuerySnapshot<Course>> streamAllCourses() {
    //  List<QuerySnapshot<Courses>> allCourses = [];
    try {
      return _firestore
          .collection(Paths.courses)
          .withConverter<Course>(
              fromFirestore: (snapshot, _) => Course.fromMap(snapshot.data()!),
              toFirestore: (course, _) => course.toMap())
          .snapshots();
    } catch (error) {
      rethrow;
    }
  }

  Stream<List<Chapter>> courseCapters(String? coureId) {
    try {
      return _firestore
          .collection(Paths.courses)
          .doc(coureId)
          .collection(Paths.chapters)
          .withConverter<Chapter>(
              fromFirestore: (snapshot, _) => Chapter.fromMap(snapshot.data()!),
              toFirestore: (chapter, _) => chapter.toMap())
          .snapshots()
          .map((snaps) {
        return snaps.docs.map((doc) => doc.data()).toList();
      });
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<bool> updateCourseProgress({
    required String? courseId,
    required String? chapterId,
    required String? userId,
  }) async {
    bool succuss = false;
    try {
      final courseData = await _firestore
          .collection(Paths.courses)
          .doc(courseId)
          .collection(Paths.chapters)
          .doc(chapterId)
          .withConverter<Chapter>(
            fromFirestore: (snapshot, _) => Chapter.fromMap(snapshot.data()!),
            toFirestore: (chapter, _) => chapter.toMap(),
          )
          .get();

      final chapter = courseData.data();
      if (chapter != null) {
        List? watched = chapter.watched;
        if (watched != null) {
          if (!watched.contains(userId)) {
            watched.add(userId);
            await _firestore
                .collection(Paths.courses)
                .doc(courseId)
                .collection('chapters')
                .doc(chapterId)
                .update({'watched': watched});
          }
          succuss = true;
        }
      }
      return succuss;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<bool> resetCourseProgress({
    required String? courseId,
    required String? userId,
  }) async {
    bool succuss = false;
    try {
      final chapters = await _firestore
          .collection(Paths.courses)
          .doc(courseId)
          .collection('chapters')
          .get();

      for (var element in chapters.docs) {
        Chapter? chapter = Chapter.fromMap(element.data());
        List? watched = chapter.watched;
        if (watched != null) {
          if (watched.contains(userId)) {
            watched.remove(userId);
            Chapter newChapter = chapter.copyWith(watched: watched);
            _firestore
                .collection(Paths.courses)
                .doc(courseId)
                .collection(Paths.chapters)
                .doc(newChapter.chapterId)
                .update({'watched': newChapter.watched});

            succuss = true;
          }
        }
      }
      return succuss;
    } catch (error) {
      print(error.toString());

      ///throw error;
      return false;
    }
  }

  Future<DocumentSnapshot<Course>> getSingleCourse(
      DocumentReference? reference) async {
    return await reference!
        .withConverter<Course>(
            fromFirestore: (snapshot, _) => Course.fromMap(snapshot.data()!),
            toFirestore: (course, _) => course.toMap())
        .get();
  }

  Future<void> updateCourse(
      {required String? courseId, required String? userId}) async {
    try {
      final courseData = await getCourseDetails(courseId);
      List? buyers = courseData?.buyers;
      if (buyers != null) {
        buyers.add(userId);

        await _firestore.collection(Paths.courses).doc(courseId).update({
          'buyers': buyers,
        });
      }
    } catch (error) {
      print('Error Uploading Course Data');
    }
  }

  Future<Course?> getCourseDetails(String? courseId) async {
    try {
      if (courseId != null) {
        return await _firestore
            .collection(Paths.courses)
            .doc(courseId)
            .withConverter<Course>(
                fromFirestore: (snapshot, _) =>
                    Course.fromMap(snapshot.data()!),
                toFirestore: (course, _) => course.toMap())
            .get()
            .then((value) => value.data());
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<List<Course>>? currentUserCourse(String? userId) async {
    List<Course> userCourses = [];
    try {
      final allCourses = await _firestore
          .collection(Paths.courses)
          .withConverter<Course>(
            fromFirestore: (snapshot, _) => Course.fromMap(snapshot.data()!),
            toFirestore: (course, _) => course.toMap(),
          )
          .get();

      // print(allCourses.docs);

      for (var element in allCourses.docs) {
        List? buyers = element.data().buyers;
        if (buyers != null) {
          if (buyers.contains(userId)) {
            userCourses.add(element.data());
          }
        }

        //print(element.data());
        // print(element.data().name);
        //  print('Buyers $buyers');
      }

      // print(userCourses);
      return userCourses;
    } catch (error) {
      print('Error stream of current user course ${error.toString()}');
      rethrow;
    }
  }

  // Stream<DocumentSnapshot<Course?>>? userCourseStream({
  //   required String userId,
  //   required String? courseId,
  // }) {
  //   try {
  //     _firestore.collection(Paths.users)
  //         .doc(userId)
  //         .collection(Paths.courses)
  //         .withConverter<Course>(
  //             fromFirestore: (snapshot, _) => Course.fromMap(snapshot.data()!),
  //             toFirestore: (course, _) => course.toMap())
  //         .snapshots();
  //   } catch (error) {
  //     print(error.toString());
  //     throw error;
  //   }
  // }

  // Stream<List<Chapter>>? chapterStream({
  //   required String userId,
  //   required String? courseId,
  // }) {
  //   try {
  //     _firestore.collection(Paths.users)
  //         .doc(userId)
  //         .collection('courses')
  //         .withConverter<Chapter>(
  //             fromFirestore: (snapshot, _) => Chapter.fromMap(snapshot.data()!),
  //             toFirestore: (chapter, _) => chapter.toMap())
  //         .snapshots();
  //   } catch (error) {
  //     print(error.toString());
  //     throw error;
  //   }
  // }

  // Stream<List<Chapter>>? chapters({
  //   required String? courseId,
  // }) {
  //   try {
  //     _firestore.collection(Paths.courses)
  //         .doc(courseId)
  //         .withConverter<Chapter>(
  //             fromFirestore: (snapshot, _) => Chapter.fromMap(snapshot.data()!),
  //             toFirestore: (chapter, _) => chapter.toMap())
  //         .snapshots();
  //   } catch (error) {
  //     print(error.toString());
  //     throw error;
  //   }
  // }

  Stream<DocumentSnapshot<Course?>>? courseStream(String courseId) {
    try {
      return _firestore
          .collection(Paths.courses)
          .doc(courseId)
          .withConverter<Course>(
              fromFirestore: (snapshot, _) => Course.fromMap(snapshot.data()!),
              toFirestore: (course, _) => course.toMap())
          .snapshots();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<QuerySnapshot<CoursePdf?>> getCoursePdfs(String? courseId) async {
    try {
      return await _firestore
          .collection(Paths.courses)
          .doc(courseId)
          .collection('pdfs')
          .withConverter<CoursePdf>(
              fromFirestore: (snapshot, _) =>
                  CoursePdf.fromMap(snapshot.data()!),
              toFirestore: (pdf, _) => pdf.toMap())
          .get();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<QuerySnapshot<CourseAudio?>> getCourseAudios(String? courseId) async {
    try {
      return await _firestore
          .collection(Paths.courses)
          .doc(courseId)
          .collection('audios')
          .withConverter<CourseAudio>(
              fromFirestore: (snapshot, _) =>
                  CourseAudio.fromMap(snapshot.data()!),
              toFirestore: (pdf, _) => pdf.toMap())
          .get();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  // helper methods exracted from course screens

  // Future<bool> resetUserCourse(
  //     {required String courseId, required String userId}) async {
  //   bool succuss = false;
  //   try {
  //     final Course? course = await getCourseDetails(courseId);
  //     List<Chapter?>? chapters = course?.chapters;
  //     if (chapters != null) {
  //       chapters.forEach((element) {
  //         List? watched = element?.watched;
  //         if (watched != null) {
  //           if (watched.contains(userId)) {
  //             watched.remove(userId);
  //             succuss = true;
  //           }
  //         }
  //       });

  //       await coursesRef.doc(courseId).update({
  //         'chapters': chapters.map((x) => x?.toMap()).toList(),
  //       });
  //       // return succuss;
  //     }
  //     return succuss;
  //   } catch (error) {
  //     print('Error Resetting Course ${error.toString()}');
  //     //throw error;
  //     return false;
  //   }
  // }

  // Future<bool> updateCurrentChapterProgress({
  //   required String courseId,
  //   required String userId,
  //   required int currentIndex,
  // }) async {
  //   bool succuss = false;
  //   try {
  //     final Course? course = await getCourseDetails(courseId);
  //     if (course != null) {
  //      // final List<Chapter?>? chapters = course.chapters;
  //       if (chapters != null) {
  //         final Chapter? chapter = chapters[currentIndex];
  //         if (chapter != null) {
  //           List? watchedList = chapter.watched;
  //           if (watchedList != null) {
  //             watchedList.add(userId);
  //             // succuss = true;
  //           }
  //         }
  //         await coursesRef.doc(courseId).update({
  //           'chapters': chapters.map((x) => x?.toMap()).toList(),
  //         });
  //         succuss = true;
  //       }
  //     }
  //     return succuss;
  //   } catch (error) {
  //     print('Error updating current chapter progress ${error.toString()}');
  //     return false;
  //   }
  // }

  // Future<List<Courses>> getAllCourses(
  //     List<DocumentReference>? allRefrence) async {
  //   // List<DocumentSnapshot<Courses>> allCourses = [];
  //   List<Courses> allCourses = [];
  //   try {
  //     if (allRefrence != null) {
  //       print('this runs');
  //       print(allRefrence.length);

  //       for (var element in allRefrence) {
  //         print(element);
  //         print('---------------');
  //         print(element.runtimeType);

  //         print(element);
  //         final course = await element
  //             .withConverter<Courses>(
  //                 fromFirestore: (snapshot, _) =>
  //                     Courses.fromMap(snapshot.data()!),
  //                 toFirestore: (course, _) => course.toMap())
  //             .get();
  //         print(course);

  //         Courses courses = course.data()!;

  //         allCourses.add(courses);
  //       }

  //       print('-----------$allCourses');
  //       return allCourses;
  //     }
  //     return allCourses;
  //   } catch (error) {
  //     print(error.toString());
  //     return [];
  //   }
  // }

}
//mycams
