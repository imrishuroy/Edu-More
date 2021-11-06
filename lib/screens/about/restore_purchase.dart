// import 'package:flutter/material.dart';

// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_functions/cloud_functions.dart';
// import '/blocs/auth/auth_bloc.dart';
// import '/models/course.dart';
// import '/repositories/course/course_repository.dart';
// import '/widgets/display_message.dart';
// import '/constants/purchase_const.dart';

// import 'package:flutter/material.dart';

// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// //import for AppStorePurchaseDetails
// // import 'package:in_app_purchase_ios/in_app_purchase_ios.dart';
// //import for SKProductWrapper
// import 'package:in_app_purchase_ios/store_kit_wrappers.dart';

// class RestorePurchase extends StatefulWidget {
//   const RestorePurchase({Key? key}) : super(key: key);

//   @override
//   _RestorePurchaseState createState() => _RestorePurchaseState();
// }

// class _RestorePurchaseState extends State<RestorePurchase> {
//   final _iap = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>>? _subscription;

//   @override
//   void initState() {
//     super.initState();
//     final purchaseUpdated = _iap.purchaseStream;
//     _subscription = purchaseUpdated.listen(
//       _onPurchaseUpdate,
//       onDone: _updateStreamOnDone,
//       onError: _updateStreamOnError,
//       //  cancelOnError: true,
//     );
//   }

//   bool _isLoading = false;

//   Future<void> _onPurchaseUpdate(
//       List<PurchaseDetails> purchaseDetailsList) async {
//     for (var purchaseDetails in purchaseDetailsList) {
//       await _handlePurchase(purchaseDetails);
//     }
//   }

//   Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
//     print('Purchase Details Status ${purchaseDetails.status}');

//     final _authBloc = context.read<AuthBloc>();
//     final _courseRepo = context.read<CourseRepository>();
//     try {
//       if (purchaseDetails.status == PurchaseStatus.purchased) {
//         // Send to server
//         var validPurchase = await _verifyPurchase(purchaseDetails);
//         print('Payment Result $validPurchase');

//         // if (validPurchase) {
//         //   await _courseRepo.updateCourse(
//         //     courseId: widget.course?.courseId,
//         //     userId: _authBloc.state.user?.uid,
//         //   );

//         //   Navigator.of(context).pop(true);
//         //   ShowMessage.showSuccussMessage(context,
//         //       message: 'Payment Succussfull');
//         // }
//       }
//       if (purchaseDetails.pendingCompletePurchase) {
//         await _iap.completePurchase(purchaseDetails);
//       }
//       if (purchaseDetails.status == PurchaseStatus.error) {
//         print('Error purchase details ${purchaseDetails.error?.message}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               '${purchaseDetails.error?.message}',
//             ),
//           ),
//         );
//       }
//     } catch (error) {
//       print('Handle Purchase error ${error.toString()}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             error.toString(),
//           ),
//         ),
//       );
//     }
//   }

//   Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
//     //await Firebase.initializeApp();
//     var functions = FirebaseFunctions.instanceFor(region: cloudRegion);
//     final callable = functions.httpsCallable('verifyPurchase');
//     final results = await callable({
//       'source': purchaseDetails.verificationData.source,
//       'verificationData':
//           purchaseDetails.verificationData.serverVerificationData,
//       'productId': purchaseDetails.productID,
//     });
//     return results.data as bool;
//   }

//   void _updateStreamOnDone() {
//     _subscription?.cancel();
//   }

//   void _updateStreamOnError(dynamic error) {
//     // ignore: avoid_print
//     print(error);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           error.toString(),
//         ),
//       ),
//     );
//   }

//   Future<void> _pay() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       final bool available = await _iap.isAvailable();
//       print(available);
//       if (available) {
//         // Workaround to mark as finished failed transactions on iOS
//         if (Platform.isIOS) {
//           final queueWrapper = SKPaymentQueueWrapper();
//           final transactions = await queueWrapper.transactions();
//           final failedTransactions = transactions.where((t) =>
//               t.transactionState == SKPaymentTransactionStateWrapper.failed);

//           final result = await Future.wait(
//               failedTransactions.map((t) => queueWrapper.finishTransaction(t)));
//           print('Payment Cancelation result $result');
//         }

//         const Set<String> _kIds = <String>{storeKeyConsumable};
//         print('KIDS $_kIds');
//         final ProductDetailsResponse response =
//             await InAppPurchase.instance.queryProductDetails(_kIds);
//         print('Response ${response.productDetails}');
//         print(response.productDetails[0].description);
//         final productDetails = response.productDetails[0];
//         print('Product Details $productDetails');

//         PurchaseParam purchaseParam = PurchaseParam(
//           productDetails: productDetails,
//           applicationUserName: null,
//         );
//         print('Purchase Params $purchaseParam');
//         final result = await _iap.buyConsumable(
//           purchaseParam: purchaseParam,
//           autoConsume: true,
//         );
//         print('Payment Result $result');
//       }
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (error) {
//       print('Payment Error ${error.toString()}');
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             error.toString(),
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
// //Get the course
// //Purchase the course to watch its contents
// //To buy a course you have to click on the price chip displaying the price of the course, after that, you will be navigated to the payments screen. We have provided two payments methods, you can click on the top button for in-app purchases and at the bottom, there is card payment.