// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '/models/app_user.dart';
// import '/repositories/profile/profile_repository.dart';
// import '/repositories/repositories.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:intl/intl.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class EditProfileScreen extends StatefulWidget {
//   @override
//   EditProfileScreenState createState() => EditProfileScreenState();
// }

// class EditProfileScreenState extends State<EditProfileScreen> {
//   //bool _status = true;
//   final FocusNode myFocusNode = FocusNode();

//   final CollectionReference usersRef =
//       FirebaseFirestore.instance.collection('users');

//   final CollectionReference courseRef =
//       FirebaseFirestore.instance.collection('courses');

//   AppUser? _user;
//   String? email;
//   final _name = TextEditingController();
//   final _email = TextEditingController();
//   final _age = TextEditingController();

//   final _city = TextEditingController();

//   final TextEditingController _phController = TextEditingController();
//   String initialCountry = 'IN';
//   PhoneNumber number = PhoneNumber(isoCode: 'IN');
//   final _formKey = GlobalKey<FormState>();

//   PhoneNumber? _initialPhoneNumber;

//   PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN', dialCode: '+91');
//   String _isoCode = 'IN';

//   bool _loading = false;

//   getCurrentUser() async {
//     setState(() => _loading = true);
//     final auth = RepositoryProvider.of<AuthRepository>(context, listen: false);
//     final user = await auth.currentUser;
//     setState(() {
//       _user = user;

//       _loading = false;
//     });
//     print(_user?.uid);
//   }

//   getCurrentUserData() async {
//     setState(() => _loading = true);
//     final profileRepo =
//         RepositoryProvider.of<ProfileRepository>(context, listen: false);
//     final _auth = context.read<AuthRepository>();

//     if (_user != null) {
//       final user = await profileRepo.getUser(_auth.userId!);
//       print(_user);
//       print(user.data()?.email);
//       setState(() {
//         email = user.data()?.email;
//         _email.text = user.data()?.email ?? '';
//         _name.text = user.data()?.name ?? '';
//         _age.text = user.data()?.age ?? '';
//         _phController.text = user.data()?.number ?? '';
//         //   _phoneNumber.phoneNumber = user.data()?.number ?? '';
//         _city.text = user.data()?.city ?? '';

//         _initialPhoneNumber = PhoneNumber(
//           isoCode: user.data()?.country,
//           phoneNumber: user.data()?.number,
//         );

//         final date = int.tryParse(user.data()!.dob!);

//         if (date != null) {
//           final dateTime = DateTime.fromMillisecondsSinceEpoch(date);
//           selectedDate = dateTime;
//           _dateController.text = DateFormat('dd/MM/y').format(dateTime);
//         } else {
//           _dateController.text = '';
//         }

//         dropdownValue = user.data()!.gender!.isEmpty
//             ? 'Male'
//             : user.data()?.gender ?? 'Male';

//         _loading = false;
//       });
//     }
//   }

//   _updateUserData() async {
//     setState(() => _loading = true);
//     try {
//       if (_user?.uid != null) {
//         print('this runs');
//         // print('---------------------');
//         // print(_formKey.currentState!.validate());
//         // if (_formKey.currentState!.validate()) {
//         _formKey.currentState!.validate();
//         _formKey.currentState!.save();
//         print('---------------------');
//         print(number.phoneNumber);
//         print(_phoneNumber.dialCode);
//         print(_phoneNumber.isoCode);
//         print(_phoneNumber.phoneNumber);
//         print('---------------------');

//         final profileRepo =
//             RepositoryProvider.of<ProfileRepository>(context, listen: false);

//         final _auth = context.read<AuthRepository>();

//         final user = await profileRepo.getUser(_auth.userId!);
//         AppUser? appUser = user.data();

//         if (appUser != null) {
//           AppUser updatedUser = appUser.copyWith(
//             name: _name.text,
//             uid: _user!.uid,
//             number: _phoneNumber.phoneNumber,
//             age: _age.text,
//             gender: dropdownValue,
//             dob: selectedDate.millisecondsSinceEpoch.toString(),
//             city: _city.text,
//             country: _phoneNumber.isoCode,
//           );

//           await usersRef.doc(_user?.uid).update(updatedUser.toMap());
//         }
//       }

//       setState(() => _loading = false);
//       Navigator.of(context).pop();
//     } catch (error) {
//       print(error.toString());
//       setState(() => _loading = false);
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser().then((_) {
//       getCurrentUserData();
//     });
//   }

//   String? dropdownValue;

//   double? _height;
//   double? _width;

//   String? dateTime;

//   DateTime selectedDate = DateTime.now();

//   TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

//   TextEditingController _dateController = TextEditingController();

//   Future _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         initialDatePickerMode: DatePickerMode.day,
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2022));
//     if (picked != null)
//       setState(() {
//         selectedDate = picked;
//         _dateController.text = DateFormat('dd/MM/y').format(selectedDate);
//       });
//   }

//   @override
//   void dispose() {
//     myFocusNode.dispose();
//     _name.dispose();
//     _email.dispose();
//     _dateController.dispose();
//     _phController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;
//     dateTime = DateFormat('dd/MM/yy').format(DateTime.now());
//     print('$email');
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           elevation: 0,
//           title: const Text('Edit Profile'),
//         ),
//         body: _loading
//             ? Center(child: CircularProgressIndicator())
//             : Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 40),
//                       Container(
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 0.0),
//                           child: new Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 25.0,
//                                   right: 25.0,
//                                 ),
//                                 child: new Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[],
//                                 ),
//                               ),
//                               Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 25.0, right: 25.0, top: 25.0),
//                                   child: new Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: <Widget>[
//                                       new Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           new Text(
//                                             'Name',
//                                             style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   )),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 2.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Flexible(
//                                       child: new TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter some text';
//                                           }
//                                           return null;
//                                         },
//                                         controller: _name,
//                                         decoration: const InputDecoration(
//                                           hintText: 'Enter Your Name',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 25, vertical: 20.0),
//                                 child: InternationalPhoneNumberInput(
//                                   onInputChanged: (PhoneNumber number) {
//                                     print(number.phoneNumber);
//                                     setState(() {
//                                       _isoCode = number.isoCode!;
//                                       print(_isoCode);
//                                       _phoneNumber = number;
//                                     });
//                                   },
//                                   onInputValidated: (bool value) {
//                                     print(value);
//                                   },
//                                   selectorConfig: SelectorConfig(
//                                     selectorType:
//                                         PhoneInputSelectorType.BOTTOM_SHEET,
//                                   ),
//                                   ignoreBlank: false,
//                                   // autoValidateMode: AutovalidateMode.disabled,
//                                   selectorTextStyle:
//                                       TextStyle(color: Colors.white),
//                                   initialValue:
//                                       _initialPhoneNumber ?? _phoneNumber,

//                                   formatInput: false,
//                                   keyboardType: TextInputType.numberWithOptions(
//                                       signed: true, decimal: true),
//                                   inputBorder: OutlineInputBorder(),
//                                   onSaved: (PhoneNumber number) {
//                                     print('On Saved: $number');
//                                     setState(() {
//                                       _phoneNumber = number;
//                                       _isoCode = number.isoCode!;
//                                     });
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Container(
//                                       child: new Text(
//                                         'D.O.B',
//                                         style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold),
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
//                                     Stack(
//                                       //    alignment: Alignment.topRight,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             _selectDate(context);
//                                           },
//                                           child: Container(
//                                             width: _width! / 2.8,
//                                             height: _height! / 22,
//                                             margin: EdgeInsets.only(
//                                                 top: 7, right: 7),
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                                 color: Colors.grey[200]),
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 10.0),
//                                               child: TextFormField(
//                                                 validator: (value) {
//                                                   if (value == null ||
//                                                       value.isEmpty) {
//                                                     return 'Please enter some text';
//                                                   }
//                                                   return null;
//                                                 },
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     color: Colors.black),
//                                                 enabled: false,
//                                                 keyboardType:
//                                                     TextInputType.text,
//                                                 controller: _dateController,
//                                                 onChanged: (String? val) {},
//                                                 onSaved: (String? val) {},
//                                                 decoration: InputDecoration(
//                                                   disabledBorder:
//                                                       UnderlineInputBorder(
//                                                     borderSide: BorderSide.none,
//                                                   ),
//                                                   contentPadding:
//                                                       EdgeInsets.only(
//                                                     bottom: 8.0,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           bottom: 14.8,
//                                           left: 112,
//                                           child: _getEditIcon(),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(right: 5),
//                                       child: DropdownButton<String>(
//                                         value: dropdownValue,
//                                         icon: const Icon(Icons.arrow_downward),
//                                         iconSize: 24,
//                                         elevation: 16,
//                                         style: const TextStyle(
//                                             color: Colors.deepPurple),
//                                         underline: Container(
//                                           height: 2,
//                                           color: Colors.deepPurpleAccent,
//                                         ),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             dropdownValue = newValue!;
//                                           });
//                                         },
//                                         items: <String>[
//                                           'Male',
//                                           'Female',
//                                           'Other'
//                                         ].map<DropdownMenuItem<String>>(
//                                             (String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(value),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 25.0),
//                                 child: new Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     //SizedBox(width: 1.0),
//                                     Text(
//                                       'Age',
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(width: 1.0),
//                                     Text(
//                                       'City',
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(width: 1.0),
//                                     //Spacer()
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 25.0, right: 25.0, top: 2.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     SizedBox(
//                                       width: 120.0,
//                                       child: TextFormField(
//                                         keyboardType: TextInputType.number,
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter some text';
//                                           }
//                                           return null;
//                                         },
//                                         controller: _age,
//                                         decoration: const InputDecoration(
//                                           hintText: 'Enter your age',
//                                         ),
//                                         //  enabled: !_status,
//                                         enabled: true,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 120.0,
//                                       child: TextFormField(
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please enter some text';
//                                           }
//                                           return null;
//                                         },
//                                         controller: _city,
//                                         decoration: const InputDecoration(
//                                           hintText: 'Enter your city',
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 25.0, vertical: 55.0),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 55.0, vertical: 5),
//                                           primary: Colors.green,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                               20.0,
//                                             ),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           'Update Profile',
//                                           style: TextStyle(
//                                             fontSize: 17.0,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           _updateUserData();
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ));
//   }

//   Widget _getEditIcon() {
//     return new CircleAvatar(
//       backgroundColor: Colors.red,
//       radius: 14.0,
//       child: new Icon(
//         Icons.edit,
//         color: Colors.white,
//         size: 16.0,
//       ),
//     );
//   }
// }

// // // Create a Form widget.
// // class EditProfileScreen extends StatefulWidget {
// //   @override
// //   EditProfileScreenState createState() {
// //     return EditProfileScreenState();
// //   }
// // }

// // // Create a corresponding State class.
// // // This class holds data related to the form.
// // class EditProfileScreenState extends State<EditProfileScreen> {
// //   // Create a global key that uniquely identifies the Form widget
// //   // and allows validation of the form.
// //   //
// //   // Note: This is a GlobalKey<FormState>,
// //   // not a GlobalKey<MyCustomFormState>.
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     // Build a Form widget using the _formKey created above.
// //     return Scaffold(
// //       body: Form(
// //         key: _formKey,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             TextFormField(
// //               // The validator receives the text that the user has entered.

// //               validator: (value) {
// //                 if (value == null || value.isEmpty) {
// //                   return 'Please enter some text';
// //                 }
// //                 return null;
// //               },
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 16.0),
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   // Validate returns true if the form is valid, or false otherwise.
// //                   if (_formKey.currentState!.validate()) {
// //                     // If the form is valid, display a snackbar. In the real world,
// //                     // you'd often call a server or save the information in a database.
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                         SnackBar(content: Text('Processing Data')));
// //                   }
// //                 },
// //                 child: Text('Submit'),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
