


import 'package:flutter/material.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/feature/doctor/presentation/appointments/appointments_list.dart';
import 'package:se7ety_123/feature/patient/appointment/appointments_list.dart';

class PatientAppointment extends StatefulWidget {
  const PatientAppointment({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<PatientAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: const Text(
         'مواعيد الحجز',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.color1,
        foregroundColor: AppColors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: AppointmentList(),
      ),
    );
  }
}