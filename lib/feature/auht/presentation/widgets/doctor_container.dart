// feature/auth/login/presentation/widget/doctor_container.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se7ety_123/core/utils/colors.dart';

class DoctorContainer extends StatelessWidget {
  DoctorContainer({
    super.key,
    this.bioController,
    this.maxlines,
    this.hinttext,
    this.validator,
    this.suffixIcon,
    this.inputFormatters,
    this.keyboardType,
  });
  TextEditingController? bioController = TextEditingController();
  int? maxlines = 1;
  String? hinttext;
  FormFieldValidator<String>? validator;
  Widget? suffixIcon;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        cursorColor: AppColors.black,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxlines,
        controller: bioController,
        style: const TextStyle(color: AppColors.black),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: AppColors.accentColor),
          hintText: hinttext,
        ),
        validator: validator,
      ),
    );
  }
}