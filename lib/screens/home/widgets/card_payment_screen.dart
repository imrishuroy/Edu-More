import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../in_app_purchase/in_app_purchase_button.dart';
import '/blocs/auth/auth_bloc.dart';
import '/config/paths.dart';
import '/models/course.dart';
import '/repositories/course/course_repository.dart';
import '/repositories/repositories.dart';
import '/widgets/display_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPaymentScreen extends StatefulWidget {
  final Course? courseData;

  const CardPaymentScreen({Key? key, required this.courseData})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CardPaymentScreenState();
  }
}

const border = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white),
  borderRadius: BorderRadius.all(
    Radius.circular(12.0),
  ),
);

const color = Color(0xffffdf00);
const textStyle = TextStyle(color: Colors.white);

class CardPaymentScreenState extends State<CardPaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection(Paths.users);

  final CollectionReference courseRef =
      FirebaseFirestore.instance.collection(Paths.courses);

  bool _loading = false;

  Future<void> _buyCourse(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      try {
        print('valid!');
        print(cardNumber);
        print(expiryDate);
        print(cvvCode);

        String month = expiryDate.split('/')[0];
        print(month);

        String year = expiryDate.split('/')[1];

        print(year); //
        // final CardField card = CardField(onCardChanged: (card) {

        // });
        final CreditCard card = CreditCard(
          number: cardNumber,
          expMonth: int.tryParse(month),
          expYear: int.tryParse(year),
        );

        final PaymentMethod paymentMethod =
            await StripePayment.createPaymentMethod(
                PaymentMethodRequest(card: card));

        final courseRepo = context.read<CourseRepository>();
        final authRepo = context.read<AuthRepository>();
        print('User Id ${authRepo.userId}');

        final courseData =
            await courseRepo.getCourseDetails(widget.courseData?.courseId);

        final authbloc = context.read<AuthBloc>();

        print('${courseData?.name}');

        List? buyers = courseData?.buyers;
        print(buyers);
        final bool paymentStatus = await _makePayment(
            price: courseData?.price,
            // userId: authRepo.userId!,
            userId: authbloc.state.user?.uid,
            paymentMethod: paymentMethod);

        if (paymentStatus) {
          await courseRepo.updateCourse(
              courseId: widget.courseData!.courseId!, userId: authRepo.userId!);
          Navigator.of(context).pop(true);
          ShowMessage.showSuccussMessage(context,
              message: 'Payment Succussfull');
          setState(() {
            _loading = false;
          });
        } else {
          print('Payment Failed');
          Navigator.of(context).pop(false);
          ShowMessage.showErrorMessage(context,
              message: 'Payment Failed, try again!');
        }

        setState(() => _loading = false);
      } on PlatformException catch (error) {
        print('Error payment ${error.message}');
        Navigator.of(context).pop(false);
        ShowMessage.showErrorMessage(context,
            message: error.message ?? 'Payment Failed, try again!');
        setState(() => _loading = false);
      } catch (error) {
        print(error.toString());
        Navigator.of(context).pop(false);
        ShowMessage.showErrorMessage(context,
            message: 'Payment Failed, try again!');
        setState(() => _loading = false);
      }
    }
  }

  Future<bool> _makePayment({
    required double? price,
    required String? userId,
    required PaymentMethod paymentMethod,
  }) async {
    bool succuss = false;

    try {
      // final paymentMethod = await StripePayment.paymentRequestWithCardForm(
      //     CardFormPaymentRequest());

      String apiBase = 'https://api.stripe.com/v1';
      String secretKey =
          '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';
      //'sk_test_51J2NG7EQrpNdjijuy2jr4NTF7XcIMbvp4YJMB3JuAzOK9NqGDlZzwq0zoA32QfL6TY5GPhlmPTFsJIuAdPYHoFfO00lMCrmrBS';
      String paymentUrl = '$apiBase/payment_intents';

      Map<String, dynamic> body = {
        'amount': '${price?.round()}00',
        'currency': 'USD',
        'payment_method_types[]': 'card'
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final response = await http.post(
        Uri.parse(
          paymentUrl,
        ),
        body: body,
        headers: headers,
      );
      final data = jsonDecode(response.body);

      print(data.runtimeType);

      final paymentIntent = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: data['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      print('Payement Intent --------------- ${paymentIntent.status}');

      if (paymentIntent.status == 'succeeded') {
        succuss = true;
      }
      return succuss;
    } catch (error) {
      print('Payment Error --- ${error.toString()}');
      // return false;
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    //_checkBrought();

    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_live_51J2NG7EQrpNdjijuLtT8cPJkobCJvkeXjqG2nQDZVKVoZQsS1U9xNzZw0PdTEOFAX56iC5GHHq0tS2BHGglSifiQ00RxqnOqjq'));
    // publishableKey:
    //  'pk_test_51J2NG7EQrpNdjijui24x7eECAQ9wAx0Y4ud9WVbHlLWBTcYRrGmKoBx9n6w0EPVBMqbhUs4YUcQEH2aWGsjPJ1y6005QhHCa71'));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.courseData?.price);
    return WillPopScope(
      onWillPop: () async {
        return !_loading;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        // backgroundColor: Colors.black54,
        resizeToAvoidBottomInset: true,
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: <Widget>[
                    InAppPurchaseButton(
                      course: widget.courseData,
                    ),
                    const SizedBox(height: 7.0),
                    const Text(
                      'or',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      cardBgColor: color,
                      textStyle: const TextStyle(
                        fontFamily: 'halter',
                        fontSize: 17,
                        color: Colors.black87,
                        package: 'flutter_credit_card',
                      ),
                      //  textStyle: TextStyle(color: Colors.black87),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                              textColor: Colors.white,
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: cardNumber,
                              cvvCode: cvvCode,
                              cardHolderName: cardHolderName,
                              expiryDate: expiryDate,
                              themeColor: Colors.blue,
                              cardNumberDecoration: const InputDecoration(
                                border: border,
                                disabledBorder: border,
                                enabled: true,
                                enabledBorder: border,
                                labelText: 'Card Number',
                                hintText: 'XXXX XXXX XXXX XXXX',
                                hintStyle: textStyle,
                                labelStyle: textStyle,
                              ),
                              expiryDateDecoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                enabled: true,
                                enabledBorder: border,
                                disabledBorder: border,
                                labelText: 'Expired Date',
                                hintText: 'XX/XX',
                                labelStyle: textStyle,
                                hintStyle: textStyle,
                              ),
                              cvvCodeDecoration: const InputDecoration(
                                border: border,
                                enabled: true,
                                enabledBorder: border,
                                disabledBorder: border,
                                labelText: 'CVV',
                                hintText: 'XXX',
                                labelStyle: textStyle,
                                hintStyle: textStyle,
                              ),
                              cardHolderDecoration: const InputDecoration(
                                border: border,
                                labelText: 'Card Holder Name ( Optional )',
                                hintStyle: textStyle,
                                labelStyle: textStyle,
                                enabled: true,
                                enabledBorder: border,
                                disabledBorder: border,
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),
                            const SizedBox(height: 30.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                // primary: const Color(0xff1b447b),
                                primary: color,
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                child: const Text(
                                  'Pay',
                                  style: TextStyle(
                                    //  fontFamily: 'halter',
                                    fontSize: 18.0,
                                    color: Colors.black87,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w500,
                                    //package: 'flutter_credit_card',
                                  ),
                                ),
                              ),
                              onPressed: () {
                                //_submit();
                                _buyCourse(context);
                              },
                            )
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

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
