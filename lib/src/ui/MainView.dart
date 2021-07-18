import 'package:artifactproject/src/bloc/MangaList/HotMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/LatestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/NewestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/event.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/ui/Mangapage.dart';
import 'package:artifactproject/src/widgets/HomepageAppBar.dart';
import 'package:artifactproject/src/widgets/MLList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/widgets/MLListItem.dart';
import 'package:artifactproject/src/models/MNMangaListPage/MangaListElement.dart';
import 'package:artifactproject/src/models/MNMangaListPage/Chapter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    //BlocProvider.of<HotMangaListBloc>(context).add(const InitEvent());
    //BlocProvider.of<LatestMangaListBloc>(context).add(const InitEvent());
    //BlocProvider.of<NewestMangaListBloc>(context).add(const InitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panelBuilder: (sc) => Mangapage(sc),
        controller: context.read<NavigationProvider>().panelController,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height,
        body: const MainViewBody(),
      ),
    );
  }
}

class MainViewBody extends StatelessWidget {
  const MainViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.atheme.systemUiOverlayStyle,
      child: Container(
        color: context.atheme.backgroundColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomepageAppBar(
                searchOnTap: () => context
                    .read<SettingsProvider>()
                    .setThemeOption(ThemeOption.light),
                notificationOnTap: () => context
                    .read<SettingsProvider>()
                    .setThemeOption(ThemeOption.dark),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Selector<NavigationProvider, NavPage>(
                  selector: (context, nav) => nav.currentNavPage,
                  builder: (context, nav, child) {
                    if (nav == NavPage.discover) {
                      return Container(
                        color: Colors.blue,
                      );
                    }
                    if (nav == NavPage.bookmarks) {
                      return Container(
                        color: Colors.red,
                      );
                    }
                    if (nav == NavPage.settings) {
                      return Container(
                        color: Colors.green,
                      );
                    }
                    return Container(
                      color: Colors.purple,
                    );
                  },
                ),
              ),
              Selector<NavigationProvider, NavPage>(
                selector: (context, nav) => nav.currentNavPage,
                builder: (context, nav, child) {
                  return BottomNavigationBar(
                    backgroundColor: context.atheme.backgroundColor,
                    selectedItemColor: context.atheme.iconColor,
                    unselectedItemColor: context.atheme.disabledIconColor,
                    elevation: 1,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: nav.index,
                    onTap: (index) => context
                        .read<NavigationProvider>()
                        .gotoPage(NavPage.values[index]),
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(
                            PhosphorIcons.houseSimpleBold,
                            size: 24.sp,
                          ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            PhosphorIcons.compassBold,
                            size: 24.sp,
                          ),
                          label: "Discover"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            PhosphorIcons.heartBold,
                            size: 24.sp,
                          ),
                          label: "Bookmarks"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            PhosphorIcons.dotsThreeOutlineBold,
                            size: 24.sp,
                          ),
                          label: "Settings"),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
