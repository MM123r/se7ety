// feature/patient/presentation/views/home/widget/no_doctor_found.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_123/core/utils/text_style.dart';

class NoDoctorFound extends StatelessWidget {
  const NoDoctorFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/no-search.svg',
            ),
            Text(
              'لا يوجد دكتور بهذا الاسم',
              style: getTitleStyle(),
            ),
          ],
        ),
      ),
    );
  }
}