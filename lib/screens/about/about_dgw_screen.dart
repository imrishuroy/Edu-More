import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDGWScreen extends StatelessWidget {
  const AboutDGWScreen({Key? key}) : super(key: key);
  static const String routeName = '/aboutDGW';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AboutDGWScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About DGW'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 13.5),
                    child: Linkify(
                      onOpen: (link) async {
                        await launch(link.url);
                      },
                      text: aboutDGW,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

const String aboutDGW =
    'All men are created equal and so all are capable to be GENIUS. "Let\'s discover GENIUS within",  we embark on the mission by introducing our courses which are introducing memorization mental tools. Handing over memorization tools to you so you can start discovering GENIUS within yourself.\n\nKids journey starts with the study.  The study includes various courses and the objective of these courses is to introduce you to specifics within the respective course.  However, when you get evaluated, you are evaluated against what you can recall and demonstrate. Eventually, kids go through an education system where they get constantly tested against the basic fundamentals of memorization.\n\nSurprisingly there is no course in an education system that teaches you how to remember!\n\nThe objective of DGW is exactly this: Identify gaps and introduce you to these tools.  Practicing these tools will bring out your full potentials.   Each course is a collection of tools that serve a common purpose.';
// 'All men are created equal and so all are capable to be GENIUS. "Let\'s discover GENIUS within",  we embark on the mission by introducing the Memory Genius course which is introducing memorization mental tools. Handing over memorization tools to you so you can start discovering GENIUS within yourself.\n\nKids journey starts with the study.  The study includes various courses and the objective of these courses is to introduce you to specifics within the respective course.  However, when you get evaluated, you are evaluated against what you can recall and demonstrate.   Eventually, kids go through an education system where they get constantly tested against the basic fundamentals of memorization.\n\nSurprisingly there is no course in an education system that teaches you how to remember!\n\nThe objective of DGW is exactly this: Identify gaps and introduce you to these tools.  Practicing these tools will bring out your full potentials.   Each course is a collection of tools that serve a common purpose.   To begin with, I am glad to introduce you to the course "Memory Genius"';

const TextStyle kHeading = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);
