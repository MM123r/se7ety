// feature/patient/presentation/views/home/oresentation/widget/specailize_banner.dart
import 'package:flutter/material.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/feature/patient/home/data/cart_list.dart';
import 'package:se7ety_123/feature/patient/home/presentation/widget/item_card_widget.dart';
import 'package:se7ety_123/feature/patient/home/presentation/widget/specialization_search_screen.dart';

class SpecialistsBanner extends StatelessWidget {
  const SpecialistsBanner({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("التخصصات", style: getTitleStyle(fontSize: 16)),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  pushTO(
                      context,
                      SpecializationSearchScreen(
                        specialization: cards[index].specialization,
                      ));
                },
                child: ItemCardWidget(model: 
                    cards[index]),
              );
            },
          ),
        ),
      ],
    );
 
  }
}
