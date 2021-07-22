import 'package:artifactproject/src/bloc/MangaPage/MangaPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum NavPage { home, discover, bookmarks, settings }
enum DiscoverPage { latest, mostviewed, newest }

class NavigationProvider with ChangeNotifier, DiagnosticableTreeMixin {
  BuildContext context;
  NavigationProvider(this.context);

  PanelController panelController = PanelController();
  NavPage currentNavPage = NavPage.home;
  DiscoverPage currentDiscoverPage = DiscoverPage.latest;

  void navigateTo(String url) async {
    BlocProvider.of<MangaPageBloc>(context).add(LoadMPEvent(url));
    await panelController.open();
  }

  void gotoPage(NavPage navPage) {
    currentNavPage = navPage;
    notifyListeners();
  }

  void discoverPage(DiscoverPage discoverPage) {
    currentNavPage = NavPage.discover;
    currentDiscoverPage = discoverPage;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<NavPage>('currentNavPage', currentNavPage));
  }
}
