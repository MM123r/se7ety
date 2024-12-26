// feature/patient/presentation/views/home/oresentation/widget/home_search_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/core/widgets/doctor_card.dart';
import 'package:se7ety_123/feature/auht/data/doctor_model.dart';
import 'package:se7ety_123/feature/patient/home/presentation/widget/no_doctor_found.dart';

class HomeSearchScreen extends StatefulWidget {
    final String searchKey;
  const HomeSearchScreen({super.key,required this.searchKey});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color1,
        foregroundColor: AppColors.white,
        title: Text(
          'ابحث عن دكتورك',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('doctors')
              .orderBy('name')
              .startAt([widget.searchKey.trim()]).endAt(
                  ['${widget.searchKey.trim()}\uf8ff']).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data!.docs.isEmpty
                ?const NoDoctorFound()
                : Scrollbar(
                    child: ListView.builder(
                      itemCount: snapshot.data?.size,
                      itemBuilder: (context, index) {
                        DoctorModel doctor = DoctorModel.fromJson(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        );
                        if (doctor.specialization == '') {
                          return const SizedBox();
                        }
                        return DoctorCard(
                          doctor: doctor,
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
 
  }
}