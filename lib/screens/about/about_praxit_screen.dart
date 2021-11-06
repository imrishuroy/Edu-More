import 'package:flutter/material.dart';

class AboutPraxitScreen extends StatelessWidget {
  const AboutPraxitScreen({Key? key}) : super(key: key);
  static const String routeName = '/aboutPraxit';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AboutPraxitScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About Praxit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: const [
              SizedBox(height: 20.0),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    parixit,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String parixit =
    "If you're visiting this page, you're likely here because you're searching for a random sentence. Sometimes a random word just isn't enough, and that is where the random sentence generator comes into play. By inputting the desired number, you can make a list of as many random sentences as you want or need. Producing random sentences can be helpful in a number of different ways.";
