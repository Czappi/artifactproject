import 'package:artifactproject/src/widgets/shared/MangapageCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:get/get.dart';

class MangapageBodyDescriptionCard extends StatelessWidget {
  final String? description;
  const MangapageBodyDescriptionCard({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MangapageCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "#description".tr.capitalize!,
            style: context.atheme.bodyTitleTextStyle,
          ),
          Text(
            description ?? "",
            style: context.atheme.bodyTextStyle,
          ),
        ],
      ),
    );
  }
}
