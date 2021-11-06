import 'package:cloud_firestore/cloud_firestore.dart';
import '/blocs/auth/auth_bloc.dart';
import '/widgets/custom_app_bar.dart';

import '/models/course.dart';

import '/repositories/course/course_repository.dart';
import '/screens/home/widgets/one_course_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  // Future _delteUser() async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc('M99087MfDnSpeWRmDiBd1sSeXnR2')
  //         .delete();
  //     //FirebaseAuth.instance.
  //   } catch (error) {
  //     print('Error ${error.toString()}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
    final _currentUser = _authBloc.state.user;
    final String? name = _currentUser?.name?.split(' ')[0] ?? '';

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _delteUser,
        // ),
        appBar: PreferredSize(
          child: CustomAppBar(
              title: 'Welcome ${name!.isNotEmpty ? name : 'User'}',
              leading: false),
          preferredSize: const Size.fromHeight(60),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CourseList(currentUserId: _currentUser?.uid),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

class CourseList extends StatefulWidget {
  final String? currentUserId;
  const CourseList({Key? key, required this.currentUserId}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    final _courseRepo = context.read<CourseRepository>();
    return FutureBuilder<QuerySnapshot<Course>>(
      future: _courseRepo.getAllCourses(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error ?? 'Something went wrong'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Expanded(
          child: AnimationLimiter(
            child: RefreshIndicator(
              strokeWidth: 4.0,
              onRefresh: () async {
                setState(() {});

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.grey.shade700,
                    content: const Text(
                      'Course loaded',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  final Course? courseData = snapshot.data?.docs[index].data();
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: OneCourseCard(
                          courseData: courseData,
                          currentUserId: widget.currentUserId,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

// Get the course
// Purchase the course to watch its contents