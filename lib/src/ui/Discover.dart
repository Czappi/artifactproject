import 'package:artifactproject/src/bloc/MangaList/HotMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/LatestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/NewestMangaListBloc.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:artifactproject/src/widgets/MLGrid.dart';
import 'package:artifactproject/src/widgets/MLListVerticalItem.dart';
import 'package:flutter/material.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/widgets/shared/UnderlineTabIndicator.dart'
    as a;
import 'package:get/get.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DiscoverTabBar(
          tabController: tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              _LatestPage(),
              _MostViewedPage(),
              _NewestPage(),
            ],
          ),
        ),
      ],
    );
  }
}

class _DiscoverTabBar extends StatelessWidget {
  const _DiscoverTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: tabController,
      indicator: a.UnderlineTabIndicator(
        indicatorColor: context.atheme.buttonColor,
      ),
      labelStyle: context.atheme.mltitleTextStyle.copyWith(fontSize: 14.sp),
      labelColor: context.atheme.mltitleTextStyle.color,
      unselectedLabelStyle:
          context.atheme.mltitleTextStyle.copyWith(fontSize: 14.sp),
      unselectedLabelColor: context.atheme.mltitleTextStyle.color,
      tabs: [
        Tab(
          height: 40,
          text: "#latest".tr.capitalizeFirst,
        ),
        Tab(
          height: 40,
          text: "#mostviewed".tr.capitalizeFirst,
        ),
        Tab(
          height: 40,
          text: "#newest".tr.capitalizeFirst,
        ),
      ],
    );
  }
}

class _LatestPage extends StatelessWidget {
  const _LatestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MLGrid<LatestMangaListBloc>(
      builder: (context, element) => MLListVerticalItem(mlElement: element),
    );
  }
}

class _NewestPage extends StatelessWidget {
  const _NewestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MLGrid<NewestMangaListBloc>(
      builder: (context, element) => MLListVerticalItem(mlElement: element),
    );
  }
}

class _MostViewedPage extends StatelessWidget {
  const _MostViewedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MLGrid<HotMangaListBloc>(
      builder: (context, element) => MLListVerticalItem(mlElement: element),
    );
  }
}

/*
class _DiscoverDropdownButton extends StatelessWidget {
  const _DiscoverDropdownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Selector<NavigationProvider, DiscoverPage>(
        selector: (context, provider) => provider.currentDiscoverPage,
        builder: (context, discoverpage, child) {
          return DropdownButton<DiscoverPage>(
            icon: const Icon(PhosphorIcons.caretDownBold),
            underline: const SizedBox(),
            iconSize: 24,
            elevation: 16,
            style: context.atheme.mltitleTextStyle,
            borderRadius: context.atheme.standardBorderRadius,
            dropdownColor: context.atheme.cardColor,
            alignment: Alignment.centerRight,
            value: discoverpage,
            onChanged: (page) {
              context.read<NavigationProvider>().discoverPage(page!);
            },
            selectedItemBuilder: (context) => [
              Text(
                "latest",
                style:
                    context.atheme.mltitleTextStyle.copyWith(fontSize: 25.sp),
              ),
              Text(
                "mostviewed",
                style:
                    context.atheme.mltitleTextStyle.copyWith(fontSize: 25.sp),
              ),
              Text(
                "newest",
                style:
                    context.atheme.mltitleTextStyle.copyWith(fontSize: 25.sp),
              ),
            ],
            items: const [
              DropdownMenuItem(
                child: Text("latest"),
                value: DiscoverPage.latest,
              ),
              DropdownMenuItem(
                child: Text("mostviewed"),
                value: DiscoverPage.mostviewed,
              ),
              DropdownMenuItem(
                child: Text("newest"),
                value: DiscoverPage.newest,
              ),
            ],
          );
        },
      ),
    );
  }
}
*/
MLElement fakemlelement = MLElement(
  title: "Akkun To Kanojo",
  author: "Kakitsubata Waka",
  imgUrl: "https://avt.mkklcdnv6temp.com/18/n/22-1600657535.jpg",
  url: "url",
  descriptionPiece:
      'The romantic comedy follows the everyday life of an extremely tsundere (initially aloof and abrasive, but later kind-hearted) boy named Atsuhiro "Akkun" Kagari and his girlfriend Non "Nontan" Katagiri. Akkun\'s behavior is harsh towards Nontan with verbal abuse and neglect, but he actually is head-over-heels for her and habitually acts like a stalker by tailing her or eavesd',
  updated: DateTime.now(),
  ratingAverage: 4.7,
  views: 322286,
  latestChapter: const Chapter("Chapter 30.5", "chapurl"),
);
