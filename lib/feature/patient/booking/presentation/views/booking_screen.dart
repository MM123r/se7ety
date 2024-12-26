// // feature/patient/presentation/views/booking/presentation/views/booking_screen.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:intl/intl.dart';
// import 'package:se7ety_123/core/constants/navigation.dart';
// import 'package:se7ety_123/core/utils/colors.dart';
// import 'package:se7ety_123/core/utils/text_style.dart';
// import 'package:se7ety_123/core/widgets/alert_dialog.dart';
// import 'package:se7ety_123/core/widgets/custom_button.dart';
// import 'package:se7ety_123/core/widgets/doctor_card.dart';
// import 'package:se7ety_123/feature/auht/data/doctor_model.dart';
// import 'package:se7ety_123/feature/patient/booking/data/available_appointments.dart';
// import 'package:se7ety_123/feature/patient/booking/presentation/widget/booking_text.dart';
// import 'package:se7ety_123/feature/patient/booking/presentation/widget/booking_textform.dart';
// import 'package:se7ety_123/feature/patient/nav_bar/nav_bar_screen.dart';

// class BookingScreen extends StatefulWidget {
//   final DoctorModel doctor;
//   const BookingScreen({super.key, required this.doctor});

//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   TimeOfDay currentTime = TimeOfDay.now();
//   String? bookingHour;
//   int selectedIndex = -1;
//   User? user;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController dateController = TextEditingController();

//   Future<void> _getUser() async {
//     user = FirebaseAuth.instance.currentUser;
//   }

//   List<int> times = [];

//   @override
//   void initState() {
//     super.initState();
//     _getUser();
//     nameController = TextEditingController(text: user?.displayName);
//     phoneController = TextEditingController(text: user?.phoneNumber);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColors.color1,
//         foregroundColor: AppColors.white,
//         title: const Text(
//           'احجز مع دكتورك',
//           style: TextStyle(color: AppColors.white),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               //doctor card
//               DoctorCard(
//                 doctor: widget.doctor,
//                 isClickable: false,
//               ),
//               const Gap(20),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Text(
//                       '-- ادخل بيانات الحجز --',
//                       style: getTitleStyle(),
//                     ),
//                     const Gap(20),
//                     //name
//                     const BookingText(
//                       text: 'اسم المريض',
//                     ),
//                     BookingTextform(
//                       nameController: nameController,
//                       validator: (value) {
//                         if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
//                         return null;
//                       },
//                       text: 'ادخل اسم المريض',
//                     ),
//                     const Gap(20),

//                     //phone
//                     const BookingText(text: 'رقم الهاتف'),
//                     BookingTextform(
//                         nameController: phoneController,
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'من فضلك ادخل رقم الهاتف';
//                           } else if (value.length < 10) {
//                             return 'يرجي ادخال رقم هاتف صحيح';
//                           }
//                           return null;
//                         },
//                         text: 'ادخل رقم الهاتف'),

//                     const Gap(10),

//                     //description
//                     const BookingText(text: 'وصف الحاله'),
//                     BookingTextform(
//                       nameController: descriptionController,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'من فضلك ادخل وصف الحاله';
//                         }
//                         return null;
//                       },
//                       text: 'ادخل وصف الحاله',
//                     ),

//                     const Gap(10),
//                     //date
//                     const BookingText(text: 'تاريخ الحجز'),

//                     TextFormField(
//                       readOnly: true,
//                       onTap: () {
//                         selectDate(context);
//                       },
//                       controller: dateController,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'من فضلك ادخل تاريخ الحجز';
//                         }
//                         return null;
//                       },
//                       textInputAction: TextInputAction.next,
//                       style: getBodyStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                       decoration: InputDecoration(
//                         hintText: 'ادخل تاريخ الحجز',
//                         filled: true,
//                         fillColor: AppColors.color2.withOpacity(.2),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 18),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(40)),
//                           borderSide: BorderSide.none,
//                         ),
//                         suffixIcon: const Padding(
//                           padding: EdgeInsets.all(4.0),
//                           child: CircleAvatar(
//                             backgroundColor: AppColors.color1,
//                             radius: 25,
//                             child: Icon(
//                               Icons.date_range_outlined,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 7,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Text(
//                             'وقت الحجز',
//                             style: getBodyStyle(color: AppColors.black),
//                           )
//                         ],
//                       ),
//                     ),
//                     Wrap(
//                         spacing: 8.0,
//                         children: times.map((hour) {
//                           return ChoiceChip(
//                             backgroundColor: AppColors.accentColor,
//                             checkmarkColor: AppColors.white,
//                             selectedColor: AppColors.color1,
//                             label: Text(
//                               '${(hour < 10) ? '0' : ''}${hour.toString()}:00',
//                               style: TextStyle(
//                                 color: hour == selectedIndex
//                                     ? AppColors.white
//                                     : AppColors.black,
//                               ),
//                             ),
//                             selected: hour == selectedIndex,
//                             onSelected: (selected) {
//                               setState(() {
//                                 selectedIndex = hour;
//                                 bookingHour =
//                                     '${(hour < 10) ? '0' : ''}${hour.toString()}:00'; // hh:mm
//                               });
//                             },
//                           );
//                         }).toList()),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12),
//         child: CustomButton(
//           text: 'تأكيد الحجز',
//           onPressed: () {
//             if (_formKey.currentState!.validate() && selectedIndex != -1) {
//               _createAppointment();

//               showAlertDialog(
//                 context,
//                 title: 'تم تسجيل الحجز !',
//                 ok: 'اضغط للانتقال',
//                 onTap: () {
//                   pushAndRemoveUntil(context, const NavBarScreen());
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> _createAppointment() async {
//     FirebaseFirestore.instance
//         .collection('appointments')
//         .doc('appointments')
//         .collection('pending')
//         .doc()
//         .set({
//       'patientID': user!.email,
//       'doctorID': widget.doctor.email,
//       'name': nameController.text,
//       'phone': phoneController.text,
//       'description': descriptionController.text,
//       'doctor': widget.doctor.name,
//       'location': widget.doctor.address,
//       'date': DateTime.parse(
//           '${dateController.text} ${bookingHour!}:00'), // yyyy-MM-dd HH:mm:ss
//       'isComplete': false,
//       'rating': null
//     }, SetOptions(merge: true));

//     FirebaseFirestore.instance
//         .collection('appointments')
//         .doc('appointments')
//         .collection('all')
//         .doc()
//         .set({
//       'patientID': user!.email,
//       'doctorID': widget.doctor.email,
//       'name': nameController.text,
//       'phone': phoneController.text,
//       'description': descriptionController.text,
//       'doctor': widget.doctor.name,
//       'location': widget.doctor.address,
//       'date': DateTime.parse('${dateController.text} ${bookingHour!}:00'),
//       'isComplete': false,
//       'rating': null
//     }, SetOptions(merge: true));
//   }

//   Future<void> selectDate(BuildContext context) async {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 5)),
//     ).then(
//       (date) {
//         if (date != null) {
//           setState(
//             () {
//               dateController.text = DateFormat('yyyy-MM-dd')
//                   .format(date); // to send the date to firebase
//               times = getAvailableAppointments(
//                   date,
//                   widget.doctor.openHour ?? "0",
//                   widget.doctor.closeHour ?? "0");
//             },
//           );
//         }
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/core/widgets/alert_dialog.dart';
import 'package:se7ety_123/core/widgets/custom_button.dart';
import 'package:se7ety_123/core/widgets/doctor_card.dart';
import 'package:se7ety_123/feature/auht/data/doctor_model.dart';
import 'package:se7ety_123/feature/patient/booking/data/available_appointments.dart';
import 'package:se7ety_123/feature/patient/nav_bar/nav_bar_screen.dart';

class BookingScreen extends StatefulWidget {
  final DoctorModel doctor;

  const BookingScreen({
    super.key,
    required this.doctor,
  });

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  TimeOfDay currentTime = TimeOfDay.now();
  String? booking_hour;

  int selectedIndex = -1;

  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  // هتشيل المةاعيد بتاعت اليوم اللي هنحدده
  List<int> times = [];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.white,
            )),
        elevation: 0,
        title: const Text(
          'احجز مع دكتورك',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DoctorCard(
                doctor: widget.doctor,
                isClickable: false,
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      '-- ادخل بيانات الحجز --',
                      style: getTitleStyle(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'اسم المريض',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
                        return null;
                      },
                      style: getBodyStyle(),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      style: getBodyStyle(),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 10) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وصف الحاله',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: getBodyStyle(),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'تاريخ الحجز',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        selectDate(context);
                      },
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل تاريخ الحجز';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: getBodyStyle(),
                      decoration: const InputDecoration(
                        hintText: 'ادخل تاريخ الحجز',
                        filled: true,
                        fillColor: AppColors.accentColor,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: AppColors.color1,
                            radius: 18,
                            child: Icon(
                              Icons.date_range_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وقت الحجز',
                            style: getBodyStyle(color: AppColors.black),
                          )
                        ],
                      ),
                    ),
                    Wrap(
                        spacing: 8.0,
                        children: times.map((hour) {
                          return ChoiceChip(
                            backgroundColor: AppColors.accentColor,
                            // showCheckmark: false,
                            checkmarkColor: AppColors.white,
                            // avatar: const Icon(Icons.abc),
                            selectedColor: AppColors.color1,
                            label: Text(
                              '${(hour < 10) ? '0' : ''}${hour.toString()}:00',
                              style: TextStyle(
                                color: hour == selectedIndex
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                            selected: hour == selectedIndex,
                            onSelected: (selected) {
                              setState(() {
                                selectedIndex = hour;
                                booking_hour =
                                    '${(hour < 10) ? '0' : ''}${hour.toString()}:00'; // hh:mm
                              });
                            },
                          );
                        }).toList()),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomButton(
          text: 'تأكيد الحجز',
          onPressed: () {
            if (_formKey.currentState!.validate() && selectedIndex != -1) {
              _createAppointment();
              showAlertDialog(
                context,
                title: 'تم تسجيل الحجز !',
                ok: 'اضغط للانتقال',
                onTap: () {
                  pushAndRemoveUntil(context, const NavBarScreen());
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc()
        .set({
      'patientID': user!.email,
      'doctorID': widget.doctor.email,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': widget.doctor.name,
      'location': widget.doctor.address,
      'date': DateTime.parse(
          '${_dateController.text} ${booking_hour!}:00'), // yyyy-MM-dd HH:mm:ss
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));

    FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc()
        .set({
      'patientID': user!.email,
      'doctorID': widget.doctor.email,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': widget.doctor.name,
      'location': widget.doctor.address,
      'date': DateTime.parse('${_dateController.text} ${booking_hour!}:00'),
      'isComplete': false,
      'rating': null
    }, SetOptions(merge: true));
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then(
      (date) {
        if (date != null) {
          setState(
            () {
              _dateController.text = DateFormat('yyyy-MM-dd')
                  .format(date); // to send the date to firebase
              times = getAvailableAppointments(
                  date,
                  widget.doctor.openHour ?? "0",
                  widget.doctor.closeHour ?? "0");
            },
          );
        }
      },
    );
  }
}
