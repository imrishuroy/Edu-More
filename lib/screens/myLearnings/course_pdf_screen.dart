import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/course_pdf.dart';
import '/repositories/course/course_repository.dart';
import '/screens/myLearnings/view_course_pdf.dart';
import '/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursePdfScreen extends StatelessWidget {
  final String? courseId;
  // static const String routeName = '/pdf';

  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: RouteSettings(name: routeName),
  //     builder: (_) => CoursePdfScreen(),
  //   );
  // }

  const CoursePdfScreen({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _courseRepo = context.read<CourseRepository>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PDFs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot<CoursePdf?>>(
              future: _courseRepo.getCoursePdfs(courseId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: NoData());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: NoData());
                }

                return ListView.builder(
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    final pdfData = snapshot.data?.docs[index].data();
                    return OnePdfTile(pdf: pdfData, index: index);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class OnePdfTile extends StatelessWidget {
  final CoursePdf? pdf;
  final int index;

  const OnePdfTile({Key? key, required this.pdf, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10.0,
      ),
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ViewPdf(
                  pdfUrl: pdf?.pdf,
                ),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 13.0,
            child: Text('${index + 1}'),
          ),
          title: Text(
            pdf?.name ?? '',
            style: const TextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(
            Icons.picture_as_pdf,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
