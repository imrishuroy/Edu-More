// import 'package:cloud_firestore/cloud_firestore.dart';
// import '/models/app_user.dart';
// import '/repositories/profile/profile_repository.dart';
// import '/repositories/repositories.dart';
// import '/screens/profile/edit_profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:intl/intl.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class ViewProfileScreen extends StatelessWidget {
//   static const String routeName = '/viewProfile';

//   static Route route() {
//     return MaterialPageRoute(
//       settings: RouteSettings(name: routeName),
//       builder: (_) => ViewProfileScreen(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _height = MediaQuery.of(context).size.height;
//     final _width = MediaQuery.of(context).size.width;

//     final _profile =
//         RepositoryProvider.of<ProfileRepository>(context, listen: false);

//     final _auth = context.read<AuthRepository>();

//     // PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN', dialCode: '+91');

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         title: const Text('Profile'),
//       ),
//       body: StreamBuilder<DocumentSnapshot<AppUser>>(
//         stream: _profile.getUserSnapshot(_auth.userId!),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final data = snapshot.data?.data();

//           print(data?.email);
//           if (data != null) {
//             return Container(
//               //  color: Colors.white,
//               child: ListView(
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       new Container(
//                         height: 210.0,
//                         //color: Colors.white,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(top: 20.0),
//                               child: CircleAvatar(
//                                 radius: 60.0,
//                                 backgroundImage: NetworkImage(_auth.userImage ??
//                                     'https://image.flaticon.com/icons/png/512/1077/1077012.png'),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Container(
//                         // color: Color(0xffFFFFFF),
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 0.0),
//                           child: new Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, bottom: 20.0),
//                                 child: new Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         new Text(
//                                           'Parsonal Information',
//                                           style: TextStyle(
//                                               fontSize: 18.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     new Column(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         _getEditIcon(context),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               _profileLabel('Name'),
//                               _profileValue('${data.name}'),
//                               _profileLabel('Email ID'),
//                               _profileValue('${data.email}'),
//                               _profileLabel('Mobile'),
//                               data.country!.isNotEmpty &&
//                                       data.number!.isNotEmpty
//                                   ? Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 25, vertical: 10.0),
//                                       child: InternationalPhoneNumberInput(
//                                         textStyle:
//                                             TextStyle(color: Colors.white),

//                                         onInputChanged: (PhoneNumber number) {
//                                           print(number.phoneNumber);
//                                         },

//                                         onInputValidated: (bool value) {
//                                           print(value);
//                                         },
//                                         selectorConfig: SelectorConfig(
//                                           selectorType: PhoneInputSelectorType
//                                               .BOTTOM_SHEET,
//                                         ),
//                                         ignoreBlank: false,

//                                         selectorTextStyle:
//                                             TextStyle(color: Colors.white),

//                                         initialValue: PhoneNumber(
//                                           phoneNumber: '${data.number}',
//                                           isoCode: data.country,
//                                         ),
//                                         isEnabled: false,
//                                         // initialValue: number,
//                                         // textFieldController: TextEditingController(
//                                         //     text:
//                                         //         '${data.number!.isNotEmpty ? data.number : 'NA'}'),
//                                         formatInput: false,
//                                         keyboardType:
//                                             TextInputType.numberWithOptions(
//                                                 signed: true, decimal: true),
//                                         inputBorder: OutlineInputBorder(),
//                                       ),
//                                     )
//                                   : _profileValue('NA'),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 25.0, vertical: 10),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.only(right: 120.0),
//                                       child: new Text(
//                                         'D.O.B',
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.only(right: 15.0),
//                                       child: Text(
//                                         'Gender',
//                                         style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Text(
//                                       'Age',
//                                       style: TextStyle(
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 16.0,
//                                   right: 25.0,
//                                 ),
//                                 //    _selectDate(context);
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Container(
//                                       width: _width / 3,
//                                       height: _height / 22,
//                                       child: Center(
//                                         child: Text(
//                                           // '${_dateController.text}',
//                                           '${data.dob!.isNotEmpty ? DateFormat('dd/MM/y').format(DateTime.fromMillisecondsSinceEpoch(int.parse(data.dob!))) : 'NA'}',
//                                           style: TextStyle(
//                                             fontSize: 18.0,
//                                             color: Colors.black,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       margin: EdgeInsets.all(8),
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey[200],
//                                       ),
//                                     ),
//                                     Text(
//                                       '${data.gender!.isNotEmpty ? data.gender : 'NA'}',
//                                       style: TextStyle(fontSize: 17.0),
//                                     ),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 5.0),
//                                       child: Text(
//                                         '${data.age!.isNotEmpty ? data.age : 'NA'}',
//                                         style: TextStyle(fontSize: 17.0),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 5.0),
//                               Row(
//                                 children: [
//                                   _profileLabel('City'),
//                                   Text(
//                                     '${data.city!.isNotEmpty ? data.city : 'NA'}',
//                                     style: TextStyle(fontSize: 17.0),
//                                   ),
//                                 ],
//                               ),
//                               // Divider(),
//                               // _profileLabel('About')
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }

//   Padding _profileValue(String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
//       child: Text(
//         '$value',
//         style: TextStyle(
//           fontSize: 16.0,
//         ),
//       ),
//     );
//   }

//   Padding _profileLabel(String label) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10.0),
//       child: Text(
//         '$label',
//         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _getEditIcon(BuildContext context) {
//     return GestureDetector(
//       child: CircleAvatar(
//         backgroundColor: Colors.red,
//         radius: 16.0,
//         child: Icon(
//           Icons.edit,
//           color: Colors.white,
//           size: 17.0,
//         ),
//       ),
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (_) => EditProfileScreen(),
//           ),
//         );
//       },
//     );
//   }
// }
