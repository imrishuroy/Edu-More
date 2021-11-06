import '/models/course.dart';

import '/repositories/auth/auth_repository.dart';
import '/repositories/course/course_repository.dart';
import '/screens/home/widgets/one_course_card.dart';

import '/screens/myLearnings/my_learning_details.dart';
import '/widgets/no_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyLearningScreen extends StatelessWidget {
  static const String routeName = '/myLearing';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MyLearningScreen(),
    );
  }

  const MyLearningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authRepo = context.read<AuthRepository>();
    final _courseRepo =
        RepositoryProvider.of<CourseRepository>(context, listen: false);
    return Scaffold(
      //
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Learning'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          FutureBuilder<List<Course>>(
              future: _courseRepo.currentUserCourse(_authRepo.userId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<Course>? courseList = snapshot.data;
                if (courseList != null) {
                  if (courseList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: NoData(),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        final courseData = courseList[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => MyLearningDetails(
                                          courseId: '${courseData.courseId}',
                                        ),
                                      ),
                                    );
                                  },
                                  leading: SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      courseData.imageUrl ?? errorImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(courseData.name ?? 'N/A'),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              })
        ],
      ),
    );
  }
}
