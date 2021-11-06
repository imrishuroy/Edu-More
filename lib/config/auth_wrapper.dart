import '/screens/home/home_screen.dart';

import '/blocs/blocs.dart';

import '/screens/login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/authwrapper';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          print('Auth State user - ${state.user?.uid}');
          // Navigator.of(context).push(
          //  MaterialPageRoute(builder: (_) => SucussScreen(state.user!.uid)));
          // Navigator.pushNamed(context, AppTabController.routName);
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
        // } else if (state.status == AuthStatus.unknown) {
        //   Navigator.of(context).pushNamed(LoginScreen.routeName);
        // }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
