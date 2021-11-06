import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/course_audio.dart';
import '/repositories/course/course_repository.dart';
import '/screens/myLearnings/listen_course_audio.dart';

import '/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseAudioScreen extends StatelessWidget {
  final String? courseId;

  const CourseAudioScreen({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _courseRepo = context.read<CourseRepository>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Audios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot<CourseAudio?>>(
              future: _courseRepo.getCourseAudios(courseId),
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
                    final audioData = snapshot.data?.docs[index].data();
                    return OneAudioTile(audio: audioData, index: index);
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

class OneAudioTile extends StatelessWidget {
  final CourseAudio? audio;
  final int index;

  const OneAudioTile({Key? key, required this.audio, required this.index})
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
                  builder: (_) => ListenCourseAudio(audioUrl: audio?.audio)),
            );
          },
          leading: CircleAvatar(
            radius: 13.0,
            child: Text('${index + 1}'),
          ),
          title: Text(
            audio?.name ?? '',
            style: const TextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(
            Icons.audiotrack,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
