import '../../../in_app_purchase/in_app_purchase_button.dart';
import '/models/course.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'card_payment_screen.dart';

class PriceButton extends StatelessWidget {
  final Course? course;

  const PriceButton({Key? key, this.course}) : super(key: key);

  Future<void> _navigatePayment(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardPaymentScreen(
          courseData: course,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isIOS) {
      return InAppPurchaseButton(course: course);
    }
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xffffdf00),
        ),
        child: Text(
          '\$ ${course?.price ?? 'N/A'}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () => _navigatePayment(context));
  }
}
