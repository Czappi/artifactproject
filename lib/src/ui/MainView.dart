import 'package:artifactproject/src/bloc/MangaList/HotMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/LatestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/NewestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/event.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/ui/Discover.dart';
import 'package:artifactproject/src/ui/Homepage.dart';
import 'package:artifactproject/src/ui/Mangapage.dart';
import 'package:artifactproject/src/widgets/MainviewAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mainview extends StatefulWidget {
  const Mainview({Key? key}) : super(key: key);

  @override
  State<Mainview> createState() => _MainviewState();
}

class _MainviewState extends State<Mainview> {
  @override
  void initState() {
    BlocProvider.of<HotMangaListBloc>(context).add(const InitEvent());
    BlocProvider.of<LatestMangaListBloc>(context).add(const InitEvent());
    BlocProvider.of<NewestMangaListBloc>(context).add(const InitEvent());
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
        body: const MainviewBody(),
      ),
    );
  }
}

class MainviewBody extends StatelessWidget {
  const MainviewBody({Key? key}) : super(key: key);

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
              MainviewAppBar(
                searchOnTap: () => context
                    .read<SettingsProvider>()
                    .setThemeOption(ThemeOption.light),
                notificationOnTap: () => context
                    .read<SettingsProvider>()
                    .setThemeOption(ThemeOption.dark),
              ),
              Expanded(
                child: Selector<NavigationProvider, NavPage>(
                  selector: (context, nav) => nav.currentNavPage,
                  builder: (context, nav, child) {
                    if (nav == NavPage.discover) {
                      return const Discover();
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
                    return const Homepage();
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
