import 'package:edu_more/widgets/display_message.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '/repositories/auth/auth_repository.dart';
import '/screens/about/about_dgw_screen.dart';
import '/screens/about/contact.dart';
import '/screens/about/terms_and_conditions.dart';
import '/screens/myLearnings/my_learning_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const TextStyle kHeading = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

class SettingScreen extends StatefulWidget {
  static const String routeName = '/about';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SettingScreen(),
    );
  }

  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;
  Future<void> _signOut(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Do you want to sign out of the app?'),
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
      RepositoryProvider.of<AuthRepository>(context, listen: false).signOut();
      // Navigator.of(context).pushNamed('/');
    }
  }

  Future<void> _restorePurchases(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final bool available = await InAppPurchase.instance.isAvailable();
      if (available) {
        print('available');
        await InAppPurchase.instance.restorePurchases();
      }
      setState(() {
        _isLoading = false;
      });
      ShowMessage.showSuccussMessage(context,
          message: 'All Purchases Restored');
    } catch (error) {
      print('Error in restore purchase ${error.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //automaticallyImplyLeading: false,
        // backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _accountCard(
                onTap: () =>
                    Navigator.of(context).pushNamed(AboutDGWScreen.routeName),
                title: 'About Discover Genius Within',
                leading: const Icon(
                  Icons.info,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 20),
              _accountCard(
                onTap: () => Navigator.of(context)
                    .pushNamed(TermsAndConditions.routeName),
                title: 'Terms and Conditions',
                leading: const Icon(
                  Icons.document_scanner_sharp,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(height: 20),
              _accountCard(
                title: 'My Learning',
                leading: const Icon(
                  Icons.library_books,
                  //color: Color(0xffffdf00),
                  color: Colors.amber,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(MyLearningScreen.routeName),
              ),
              const SizedBox(height: 20),

              _accountCard(
                title: 'Contact',
                leading: const Icon(
                  Icons.phone,
                  //color: Color(0xffffdf00),
                  color: Colors.amber,
                ),
                onTap: () => Navigator.of(context).pushNamed(Contact.routeName),
              ),

              const SizedBox(height: 20),
              // if (UniversalPlatform.isIOS)

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _accountCard(
                      title: ' Restore Purchases',
                      leading: const Icon(
                        Icons.monetization_on,
                        //color: Color(0xffffdf00),
                        color: Colors.amber,
                      ),
                      onTap: () => _restorePurchases(context),
                    ),
              // _accountCard(
              //   onTap: () => Navigator.of(context)
              //       .pushNamed(AboutPraxitScreen.routeName),
              //   title: 'Parixit Khatri',
              //   leading: Icon(
              //     Icons.person,
              //     color: Colors.amber,
              //   ),
              // ),
              // SizedBox(height: 20),
              // _accountCard(
              //   title: 'Profile',
              //   onTap: () => Navigator.of(context)
              //       .pushNamed(ViewProfileScreen.routeName),
              //   leading: Container(
              //     height: 35,
              //     width: 35,
              //     child: Image.asset(
              //       'assets/images/user.png',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Terms and Conditions',
              //       style: kHeading,
              //     ),
              //     // IconButton(
              //     //   onPressed: () {},
              //     //   icon: Icon(
              //     //     Icons.picture_as_pdf,
              //     //     color: Colors.red,
              //     //   ),
              //     // )
              //   ],
              // ),
              // SizedBox(height: 10.0),
              // Card(
              //   child: Padding(
              //     padding: EdgeInsets.all(10.0),
              //     child: Text(
              //       terms,
              //       style: TextStyle(
              //         fontSize: 16.0,
              //       ),
              //     ),
              //   ),
              // ),

              // Text('Contact', style: kHeading),

              const SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Push Notification',
              //       style: kHeading,
              //     ),
              //     NotificationSwitch(),
              //   ],
              // ),

              const SizedBox(height: 40.0),
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () => _signOut(context),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Center(
                child: Text(
                  'version 1.0.0',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Card _accountCard({
    required String title,
    required Widget leading,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
        ),
        leading: leading,
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({Key? key}) : super(key: key);

  // final bool value;

  // const NotificationSwitch(this.value);

  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: isOn,
        onChanged: (value) {
          setState(() {
            isOn = !isOn;
          });
        });
  }
}

const String terms =
    'Please read these Terms carefully, paying particular attention to clause 6, which sets out the extent of Reallyenglish’s potential liability in relation to the Demo Products and their use.DEFINITIONS In these Terms, words and phrases defined below (and elsewhere in these Terms) have the meanings provided: Confidential Information: all confidential information of Reallyenglish (however recorded or preserved) directly or indirectly disclosed or made available, including any information that would be regarded as confidential by a reasonable business person. For clarity, all information relating to the pricing, terms of use, functioning, coding and operation of the Demo Products shall be Confidential Information of Reallyenglish. Demo Products: a limited demo version of Reallyenglish’s cloud-based language learning platform, together with any related documentation, materials, products or services, as the same are updated from time to time.End Users: individuals provided with authorisation keys enabling them to access the Demo Products.';
