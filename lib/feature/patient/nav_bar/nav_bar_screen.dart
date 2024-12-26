// feature/patient/presentation/views/nav_bar/nav_bar_screen.dart
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/feature/patient/appointment/views/patient_appointment.dart';
import 'package:se7ety_123/feature/patient/home/presentation/views/home.dart';
import 'package:se7ety_123/feature/patient/profile/presentation/views/patient_profile_screen.dart';
import 'package:se7ety_123/feature/patient/search/views/patient_search.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;
  final List _pages = [
   const PatientHome(),
   const PatientSearch(),
   const PatientAppointment(),
   const PatientProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical:8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            ),
          ],
        ),
        child: GNav(
          curve: Curves.easeOutExpo,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,
          gap: 4,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.color1,
          textStyle: getBodyStyle(color: AppColors.white),
          tabs: const [
            GButton(
              iconSize: 25,
              icon: Icons.home,
              text: 'الرئيسية',
            ),
            GButton(
              icon: Icons.search,
              text: 'البحث',
            ),
            GButton(
              iconSize: 28,
              icon: Icons.calendar_month_rounded,
              text: 'المواعيد',
            ),
            GButton(
              iconSize: 29,
              icon: Icons.person,
              text: 'الحساب',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
    
  }
}