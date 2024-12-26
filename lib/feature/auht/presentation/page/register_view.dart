// feature/auth/login/presentation/view/signup_view.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/enums/user_type_enum.dart';
import 'package:se7ety_123/core/functions/dialogs.dart';
import 'package:se7ety_123/core/functions/email_validate.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/core/widgets/custom_button.dart';
import 'package:se7ety_123/feature/auht/presentation/bloc/auth_bloc.dart';
import 'package:se7ety_123/feature/auht/presentation/page/doctor_registeration.dart';
import 'package:se7ety_123/feature/auht/presentation/page/login_view.dart';
import 'package:se7ety_123/feature/patient/nav_bar/nav_bar_screen.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key, required this.userType});
  final UserType userType;

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;

  String handleUserType() {
    return widget.userType == UserType.doctor ? 'دكتور' : 'مريض';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessstate) {
            if (widget.userType == UserType.doctor) {
              pushAndRemoveUntil(context, const DoctorRegisterView());
            } else {
              pushReplacement(context, const NavBarScreen());
            }
          } else if (state is AuthErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, state.error);
          } else if (state is RegisterLoadingstate) {
            showLoadingDialog(context);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'سجل حساب جديد كـ "${handleUserType()}"',
                      style: getTitleStyle(),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _displayName,
                      style: const TextStyle(
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'الاسم',
                        hintStyle: getBodyStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل الاسم';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: 'user@example.com',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.email_rounded),
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الايميل';
                        } else if (!emailValidate(value)) {
                          return 'من فضلك ادخل الايميل صحيحا';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: AppColors.black),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                        hintText: '********',
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon((isVisable)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_rounded)),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                        return null;
                      },
                    ),
                    const Gap(30),
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(RegisterEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _displayName.text,
                              userType: widget.userType));
                        }
                      },
                      text: "تسجيل حساب",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لدي حساب ؟',
                            style: getBodyStyle(color: AppColors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                pushReplacement(context,
                                    LoginView(userType: widget.userType));
                              },
                              child: Text(
                                'سجل دخول',
                                style: getBodyStyle(color: AppColors.color1),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}