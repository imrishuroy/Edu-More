import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);
  static const String routeName = '/contact';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const Contact(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Mob No - '),
                            TextSpan(
                              text: ' +1 (615) 804 7798',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Email - '),
                            TextSpan(
                              text: 'support@discovergeniuswithin.com',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SelectableText.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Address - '),
                            TextSpan(
                              text: '53 Penn Rd, Voorhees, NJ 08043',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

// Contact :
// Mobile Number : +1 (615) 804 7798
// Email : support@discovergeniuswithin.com
// Address : 53 Penn Rd, Voorhees, NJ 08043
