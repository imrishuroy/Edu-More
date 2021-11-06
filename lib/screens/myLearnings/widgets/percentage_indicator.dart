import '/screens/myLearnings/course_audio_screen.dart';
import '/screens/myLearnings/course_pdf_screen.dart';
import 'package:flutter/material.dart';

class ExtraButtonsAndPercentage extends StatelessWidget {
  final int? percentage;
  final String? courseId;

  const ExtraButtonsAndPercentage({
    Key? key,
    this.percentage,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ExtraButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CourseAudioScreen(
                    courseId: courseId,
                  ),
                ),
              );
            },
            icon: Icons.audiotrack),
        ExtraButton(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CoursePdfScreen(
                  courseId: courseId,
                ),
              ),
            );
          },
          icon: Icons.picture_as_pdf_rounded,
          color: Colors.red,
        ),
        // Text(
        //   //   'Chapters',
        //   '',
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.w600,
        //     letterSpacing: 1.2,
        //   ),
        // ),
        Chip(
          backgroundColor: const Color(0xffffdf00),
          label: Text(
            '$percentage %',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class ExtraButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;

  const ExtraButton(
      {Key? key,
      required this.onTap,
      required this.icon,
      this.color = Colors.amber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Icon(
            icon,
            color: color,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
