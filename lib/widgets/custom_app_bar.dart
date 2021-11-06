import 'package:flutter/material.dart';

import '/config/constants.dart';
import '/screens/about/setting_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool leading;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading,
      title: Text(
        title,
        style: kHeadingextStyle,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SettingScreen.routeName);
          },
          icon: const Icon(Icons.settings),
        ),
        const SizedBox(width: 5)
      ],
    );
  }
}













// import '/screens/about/about_screen.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_svg/flutter_svg.dart';

// class CustomAppBar extends StatelessWidget {
//   final GlobalKey<ScaffoldState>? scaffoldKey;

//   const CustomAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             InkWell(
//               onTap: () {
//                 scaffoldKey?.currentState?.openDrawer();
//               },
//               child: SvgPicture.asset('assets/icons/menu.svg'),
//             ),
//             SizedBox(
//               height: 35.0,
//               child: InkWell(
//                 onTap: () {
//                   // BlocProvider.of<TabBloc>(context, listen: false).add(
//                   //   ChangeTab(AppTab.profile),
//                   // );
//                   Navigator.of(context).pushNamed(AboutScreen.routeName);
//                 },
//                 child: Icon(Icons.settings),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
