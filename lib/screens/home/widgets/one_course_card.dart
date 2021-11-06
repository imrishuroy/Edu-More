import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/screens/home/widgets/price_button.dart';

import '/screens/myLearnings/my_learning_details.dart';
import '/config/paths.dart';
import '/models/course.dart';

import '/repositories/course/course_repository.dart';

import '/widgets/display_message.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

const String errorImage =
    'https://developers.google.com/maps/documentation/maps-static/images/error-image-generic.png';

class OneCourseCard extends StatefulWidget {
  final Course? courseData;
  final String? currentUserId;

  const OneCourseCard({
    Key? key,
    required this.courseData,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _OneCourseCardState createState() => _OneCourseCardState();
}

class _OneCourseCardState extends State<OneCourseCard> {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection(Paths.users);

  final CollectionReference courseRef =
      FirebaseFirestore.instance.collection(Paths.courses);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    // print('Width $_width');
    // print('Hight $_height');
    final _courseRepo = context.read<CourseRepository>();

    ///   print('3.6 ${_height / 3.6}');

    if (widget.courseData != null) {
      if (widget.courseData!.buyers != null ||
          widget.courseData?.courseId != null) {
        return StreamBuilder<DocumentSnapshot<Course?>>(
          stream: _courseRepo.courseStream(widget.courseData!.courseId!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorOneCourse();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            final courseData = snapshot.data?.data();
            return InkWell(
              onTap: () {
                if (courseData!.buyers!.contains(widget.currentUserId)) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          MyLearningDetails(courseId: courseData.courseId!),
                    ),
                  );
                } else {
                  ShowMessage.showErrorMessage(context,
                      message: 'Please buy this course to watch videos!');
                }
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 5,
                        ),
                        // height: _height / 3.6,
                        height: _height / 3.7,
                        width: _width,
                        child: Card(
                            elevation: 7,
                            child: CachedNetworkImage(
                              imageUrl:
                                  widget.courseData?.imageUrl ?? errorImage,
                              fit: BoxFit.fill,
                              errorWidget: (context, _, __) => const Center(
                                child: Icon(Icons.error),
                              ),
                              progressIndicatorBuilder: (context, _, value) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: value.progress,
                                    strokeWidth: 2.0,
                                  ),
                                );
                              },
                            )

                            //  Image.network(
                            //   widget.courseData?.imageUrl ?? errorImage,
                            //   fit: BoxFit.fill,
                            // ),
                            ),
                      ),
                      if (courseData?.upcomming ?? false)
                        Positioned(
                          right: 6.0,
                          top: 5.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            decoration:
                                const BoxDecoration(color: Color(0xffffdf00)),
                            child: const Text(
                              'Upcoming',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        right: 40.0,
                        top: 42.0,
                        child:
                            !courseData!.buyers!.contains(widget.currentUserId)
                                ? const Icon(Icons.lock)
                                : const Icon(Icons.visibility),
                      ),
                      if (!courseData.buyers!.contains(widget.currentUserId) &&
                          !courseData.upcomming)
                        Positioned(
                            left: 30,
                            top: 30,
                            child: PriceButton(course: courseData)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Container(
                      color: Colors.black45,
                      width: _width - 20.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          '${courseData.name?.toUpperCase()}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      }
    }

    return const ErrorOneCourse();
  }
}

class ErrorOneCourse extends StatelessWidget {
  const ErrorOneCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      child: Container(
        color: Colors.white,
        height: _height / 4.1,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error,
              color: Colors.black,
            ),
            SizedBox(height: 10.0),
            Text(
              'No data found :(',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
