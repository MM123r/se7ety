// feature/auth/login/presentation/widget/doctor_text.dart
// feature/auth/login/presentation/widget/doctor_text.dartst
import 'package:flutter/material.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
class DoctorText extends StatelessWidget {
   DoctorText({super.key,required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getBodyStyle(
          color: AppColors.black, fontWeight: FontWeight.bold),
    );
  }
}