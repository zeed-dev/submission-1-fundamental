import 'package:flutter/material.dart';
import 'package:food_store_app/common/constants.dart';
import 'package:food_store_app/presentation/pages/main_page.dart';

class OnboardingPage extends StatelessWidget {
  static const ROUTE_NAME = "/onboarding-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 157,
            ),
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/splash_image.png",
                width: 324,
                height: 294,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Searching Restaurant",
              style: kHeading6.copyWith(
                color: KBlue,
              ),
            ),
            Text(
              "No need to worry about how hard it is \nYou find a restaurant.\nStart now.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 141,
              height: 47,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, MainPage.ROUTE_NAME);
                },
                child: Text(
                  "Get Started",
                  style: kHeading6,
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
