import '/screens/about/about_praxit_screen.dart';
import '/screens/about/contact.dart';
import '/screens/about/terms_and_conditions.dart';

import '/screens/about/about_dgw_screen.dart';
import '/screens/about/setting_screen.dart';

import '/screens/home/home_screen.dart';
import '/screens/login/login_screen.dart';
import '/screens/myLearnings/my_learning_screen.dart';
import 'package:flutter/material.dart';

import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case HomeScreen.routeName:
        return HomeScreen.route();

      // case AppTabController.routName:
      //   return AppTabController.route();

      case SettingScreen.routeName:
        return SettingScreen.route();

      // case ViewProfileScreen.routeName:
      //   return ViewProfileScreen.route();

      case MyLearningScreen.routeName:
        return MyLearningScreen.route();

      case AboutDGWScreen.routeName:
        return AboutDGWScreen.route();

      case AboutPraxitScreen.routeName:
        return AboutPraxitScreen.route();

      case TermsAndConditions.routeName:
        return TermsAndConditions.route();

      case Contact.routeName:
        return Contact.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
