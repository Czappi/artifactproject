import 'package:artifactproject/src/models/MNMangaPage.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:artifactproject/src/widgets/shared/MangapageCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MangapageBodyInformationCard extends StatelessWidget {
  final List<Genre>? genres;
  final String title;
  final String? altTitle;
  final Author author;
  final MangaStatus? status;
  final DateTime? updated;
  final int? view;
  final Rating rating;
  const MangapageBodyInformationCard({
    Key? key,
    required this.genres,
    required this.title,
    this.altTitle,
    required this.author,
    this.status,
    this.updated,
    this.view,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MangapageCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Genre(genres: genres ?? []),
          _CompleteInfo(
              title: title,
              altTitle: altTitle,
              author: author,
              status: status,
              view: view,
              rating: rating)
        ],
      ),
    );
  }
}

class _CompleteInfo extends StatelessWidget {
  const _CompleteInfo({
    Key? key,
    required this.title,
    required this.altTitle,
    required this.author,
    required this.status,
    required this.view,
    required this.rating,
  }) : super(key: key);

  final String title;
  final String? altTitle;
  final Author author;
  final MangaStatus? status;
  final int? view;
  final Rating rating;

  @override
  Widget build(BuildContext context) {
    String _status;

    switch (status) {
      case MangaStatus.completed:
        _status = "#status-completed";
        break;
      case MangaStatus.ongoing:
        _status = "#status-ongoing";
        break;
      default:
        _status = "unknown";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "#complete-info".tr.capitalize!,
          style: context.atheme.bodyTitleTextStyle,
        ),
        SizedBox(
          height: 12.h,
        ),
        _CompleteInfoQNA(
          question: "#title".tr.capitalize!,
          answer: title,
        ),
        _CompleteInfoQNA(
          question: "#alttitle".tr.capitalizeFirst!,
          answer: altTitle ?? "",
        ),
        _CompleteInfoQNA(
          question: "#author".tr.capitalize!,
          answer: author.name,
        ),
        _CompleteInfoQNA(
          question: "#status".tr.capitalize!,
          answer: _status.tr.capitalizeFirst!,
        ),
        _CompleteInfoQNACustom(
          question: "#views".tr.capitalize!,
          answer: Row(
            children: [
              Text(
                view.toString(),
                style: context.atheme.bodyTitleTextStyle.copyWith(
                  fontSize: 14.sp,
                  color:
                      context.atheme.bodyTitleTextStyle.color!.withOpacity(0.9),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Icon(
                PhosphorIcons.eyeBold,
                color:
                    context.atheme.bodyTitleTextStyle.color!.withOpacity(0.9),
                size: 18.sp,
              )
            ],
          ),
        ),
        _CompleteInfoQNACustom(
          question: "#rating".tr.capitalize!,
          answer: Row(
            children: [
              Text(
                rating.average.toString(),
                style: context.atheme.bodyTitleTextStyle.copyWith(
                  fontSize: 14.sp,
                  color:
                      context.atheme.bodyTitleTextStyle.color!.withOpacity(0.9),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Icon(
                PhosphorIcons.starFill,
                color: context.atheme.starColor.withOpacity(0.9),
                size: 18.sp,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                "(" +
                    rating.average.toString() +
                    " / " +
                    rating.best.toString() +
                    " - " +
                    rating.votes.toString() +
                    " " +
                    "#votes".tr +
                    ")",
                style: context.atheme.bodyTitleTextStyle.copyWith(
                  fontSize: 12.sp,
                  color:
                      context.atheme.bodyTitleTextStyle.color!.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class _Genre extends StatelessWidget {
  const _Genre({
    Key? key,
    required this.genres,
  }) : super(key: key);

  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "#genre".tr.capitalize!,
          style: context.atheme.bodyTitleTextStyle,
        ),
        SizedBox(
          height: 12.h,
        ),
        Wrap(
          spacing: 6.sp,
          children: List.generate(
            genres.length,
            (index) => ActionChip(
              label: Text(
                genres[index].name.tr.capitalizeFirst!,
              ),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class _CompleteInfoQNA extends StatelessWidget {
  final String question, answer;
  const _CompleteInfoQNA({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: context.atheme.bodySubtitleTextStyle,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            answer,
            style: context.atheme.bodyTitleTextStyle.copyWith(
              fontSize: 14.sp,
              color: context.atheme.bodyTitleTextStyle.color!.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompleteInfoQNACustom extends StatelessWidget {
  final String question;
  final Widget answer;
  const _CompleteInfoQNACustom({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: context.atheme.bodySubtitleTextStyle,
          ),
          SizedBox(
            height: 8.h,
          ),
          answer,
        ],
      ),
    );
  }
}
