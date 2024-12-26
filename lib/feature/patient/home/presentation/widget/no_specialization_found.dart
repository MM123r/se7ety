// feature/patient/presentation/views/home/widget/no_specialization_found.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_123/core/utils/text_style.dart';

class NoSpecializationFound extends StatelessWidget {
  const NoSpecializationFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/no-search.svg',
              width: 250,
            ),
            Text(
              'لا يوجد دكتور بهذا التخصص حاليا',
              style: getBodyStyle(),
            ),
          ],
        ),
      ),
    );
  }
}