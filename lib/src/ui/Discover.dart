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
          height: 40.h,
          text: "#latest".tr.capitalizeFirst,
        ),
        Tab(
          height: 40.h,
          text: "#mostviewed".tr.capitalizeFirst,
        ),
        Tab(
          height: 40.h,
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
