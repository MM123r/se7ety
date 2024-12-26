// feature/patient/presentation/views/home/widget/item_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/feature/patient/home/data/cart_list.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.model,
  });
  final SpecializationModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10),
      decoration: BoxDecoration(
        color: model.cardBackground,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 10,
            color: model.cardLightColor.withOpacity(.8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: model.cardLightColor,
                radius: 60,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/images/doctor-card.svg',
                  width: 140,
                ),
                const Gap(10),
                Text(model.specialization,
                    textAlign: TextAlign.center,
                    style: getTitleStyle(
                        color: AppColors.white, fontSize: 14)),
                const SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}