import 'package:care_app/colours/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {

  static Widget buildHeading(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w900,
            fontSize: 36,
          ),
        ),
      ],
    );
  }

static const TextStyle mediumHeading = TextStyle(
    color: AppColors.darkBlue,
    fontWeight: FontWeight.w900,
    fontSize: 26,
  );

static const TextStyle normalText = TextStyle(
    color: AppColors.darkBlue,
    fontSize: 20,
  );

  static const TextStyle smallHeading = TextStyle(
    color: AppColors.darkBlue,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static const TextStyle tabTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
  );

  static const TextStyle labelTextStyle = TextStyle(
    color: AppColors.darkBlue,
  );

  static const TextStyle errorTextStyle = TextStyle(
    color: AppColors.red,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: AppColors.darkBlue,
    fontSize: 16,
  );

  static const TextStyle googleButtonTextStyle = TextStyle(
    color: AppColors.darkBlue,
    fontSize: 16,
  );

//Normal Text
  static const TextStyle richTextStyle = TextStyle(
    color: AppColors.darkBlue,
    fontSize: 24
  );

  static const TextStyle richTextBoldStyle = TextStyle(
    color: AppColors.neonBlue,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle smallerText = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );
}

class IconStyles{
  static Icon smallIcon(IconData iconData) {
    return Icon(
      iconData,
      color: Colors.white,
      size: 30,
    );
  }
}
