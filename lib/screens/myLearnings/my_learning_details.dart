import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/chapter.dart';
import '/models/course.dart';
import '/repositories/auth/auth_repository.dart';
import '/repositories/course/course_repository.dart';
import '/screens/myLearnings/widgets/percentage_indicator.dart';
import '/screens/video/video_player.dart';
import '/widgets/display_message.dart';
import '/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLearningDetails extends StatefulWidget {
  final String courseId;

  const MyLearningDetails({Key? key, required this.courseId}) : super(key: key);

  @override
  _MyLearningDetailsState createState() => _MyLearningDetailsState();
}

class _MyLearningDetailsState extends State<MyLearningDetails> {
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection(Paths.users);

  final CollectionReference courseRef =
      FirebaseFirestore.instance.collection(Paths.courses);

  Future<void> _updateWatchedAndViewVideo({
    required int index,
    required String? video,
    required String? chapterId,
    required String? courseId,
    required Chapter? chapter,
  }) async {
    try {
      print(courseId);
      print(chapterId);
      if (video != null) {
        var result = Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => VideoPlayer(
                    videoUrl: video,
                  )

              // videoUrl:    video,
              ),
        );

        final bool upload = await result ?? false;

        if (upload) {
          final courseRepo = context.read<CourseRepository>();
          final authRepo = context.read<AuthRepository>();
          await courseRepo.updateCourseProgress(
            courseId: courseId,
            chapterId: chapterId,
            userId: authRepo.userId,
          );
        }
      }
    } catch (error) {
      print('Error updatig watch video ${error.toString()}');
      ShowMessage.showErrorMessage(context);
    }
  }

  Future<void> _resetCourse(String? courseId) async {
    try {
      final result = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Reset Course'),
          content: const Text('Do you want to reset course progress ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      );
      print(result);
      if (result) {
        final authRepo = context.read<AuthRepository>();
        final courseRepo = context.read<CourseRepository>();

        final succuss = await courseRepo.resetCourseProgress(
            courseId: courseId, userId: authRepo.userId);

        if (succuss) {
          ShowMessage.showSuccussMessage(context,
              message: 'Successfully reset the course progress!');
        } else {
          ShowMessage.showErrorMessage(context,
              message: 'Please make some progress to reset');
        }
      }
    } catch (error) {
      print(error.toString());
      ShowMessage.showErrorMessage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = context.read<AuthRepository>();
    final String? userId = authRepo.userId;
    print('${authRepo.userId}');
    final courseRepo = context.read<CourseRepository>();
    return StreamBuilder<DocumentSnapshot<Course?>>(
      stream: courseRepo.courseStream(widget.courseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final courseData = snapshot.data?.data();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Details'),
            actions: [
              IconButton(
                onPressed: () {
                  if (courseData != null) {
                    _resetCourse(courseData.courseId);
                  }
                },
                icon: const Icon(Icons.restart_alt),
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 200,
                  width: 350.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: widget.courseId,
                              child: Image.network(
                                courseData!.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VideoPlayer(
                                videoUrl: courseData.video!,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white,
                          size: 60.0,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  courseData.name ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  courseData.description ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: StreamBuilder<List<Chapter?>>(
                    stream: courseRepo.courseCapters(courseData.courseId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final chapters = snapshot.data ?? [];

                      print('List of chapters = ${chapters.length}');

                      if (chapters.isNotEmpty) {
                        int _count = 0;

                        for (var element in chapters) {
                          List? watchedList = element?.watched ?? [];

                          if (watchedList.contains(userId)) {
                            _count++;
                          }
                        }

                        print('Count $_count');

                        final _percentage =
                            ((_count / chapters.length) * 100).ceil();

                        print(courseData);

                        return Column(
                          children: [
                            ExtraButtonsAndPercentage(
                              percentage: _percentage,
                              courseId: courseData.courseId,
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: chapters.length,
                                itemBuilder: (context, index) {
                                  final chapterData = chapters[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Card(
                                      child: ListTile(
                                        onTap: () async {
                                          //final watched = currentChapter['name'];
                                          await _updateWatchedAndViewVideo(
                                            index: index,
                                            video: chapterData?.video!,
                                            chapterId: chapterData?.chapterId,
                                            courseId: courseData.courseId,
                                            chapter: chapterData,
                                          );
                                        },
                                        title: Text(chapterData?.name ?? 'N/A'),
                                        trailing: Icon(
                                          Icons.check_circle_outline,
                                          color: chapterData?.watched != null
                                              ? chapterData!.watched!
                                                      .contains(userId)
                                                  ? Colors.amber
                                                  : null
                                              : null,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: NoData());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
