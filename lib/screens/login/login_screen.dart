import '/repositories/repositories.dart';
import '/screens/splash/animation_screen.dart';
import '/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:universal_platform/universal_platform.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
        create: (_) =>
            LoginCubit(authRepository: context.read<AuthRepository>()),
        child: const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // context.read<AuthRepository>().signOut();
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: Stack(
          children: [
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.error) {
                  print('ERROR ${state.failure!.message} ');
                  showDialog(
                    context: context,
                    builder: (context) => ErrorDialog(
                      content: state.failure!.message,
                    ),
                  );
                }
              },
              builder: (context, state) {
                // print('Width - $width');
                //print("Height - $height");
                return Scaffold(
                  backgroundColor: Colors.grey[900],

                  // backgroundColor: Colors.grey[100],
                  body: state.status == LoginStatus.submitting
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: height * 0.5,
                            //color: Colors.red,

                            width: width * 0.9,
                            child: Card(
                              color: Colors.white,
                              elevation: 10.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(height: 10.0),
                                  const Text(
                                    'Discover Genius Within',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  //  SizedBox(height: 50.0),
                                  SizedBox(
                                    width: 282.0,
                                    //width: width * 1.3,
                                    height: 50.0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<LoginCubit>()
                                            .logInWithGoogle();
                                        // RepositoryProvider.of<AuthRepository>(context,
                                        //         listen: false)
                                        //     .signInWithApple();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.zero,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                              ),
                                            ),
                                            padding: EdgeInsets.zero,
                                            height: 50.0,
                                            //width: 50.0,
                                            width: width * 0.09,
                                            child: SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: SvgPicture.asset(
                                                'assets/images/google.svg',
                                                fit: BoxFit.contain,
                                                height: 20.0,
                                                width: 20.0,
                                                // fit: BoxFit.contain,

                                                // fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 20.0),
                                          Text(
                                            'Sign in with Google',
                                            style: TextStyle(
                                              fontSize: width < 900 ? 18 : 20.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          // // Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (UniversalPlatform.isIOS)
                                    SizedBox(
                                      width: 250.0,
                                      child: SignInWithAppleButton(
                                        onPressed: () {
                                          context
                                              .read<LoginCubit>()
                                              .appleLogin();
                                        },
                                        style: SignInWithAppleButtonStyle.black,
                                      ),
                                    ),
                                  //   SizedBox(height: 45.0),
                                  // Center(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 20.0),
                                  //     child: Text(
                                  //       '"This has nothing to do with your life.\nBut by adding some todos you can organize it better."',
                                  //       style: TextStyle(
                                  //         fontSize: width < 900 ? 14.0 : 20.0,
                                  //         letterSpacing: 1.2,
                                  //       ),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        // '" Embark Journey Of Memory Genius Today "',
                                        '" Embark Journey Of Genius Today "',
                                        style: TextStyle(
                                          fontSize: width < 900 ? 16.0 : 20.0,
                                          letterSpacing: 1.2,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                  //  Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     // crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Center(
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             context.read<LoginCubit>().logInWithGoogle();
                  //           },
                  //           child: Text('Google Sign In'),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  //         child: TextField(
                  //           onChanged: (value) => context
                  //               .read<LoginCubit>()
                  //               .phoneNumberChanged(value),
                  //           decoration: InputDecoration(
                  //             hintText: 'Enter phone number eg-918540928489',
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 20.0),
                  //       Center(
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             context.read<LoginCubit>().loginWithPhone();
                  //           },
                  //           child: Text('Phone Sign In'),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                );
              },
            ),
            const IgnorePointer(
                child: AnimationScreen(color: Colors.amberAccent))
          ],
        ),
      ),
    );
  }
}
