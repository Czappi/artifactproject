import 'package:artifactproject/src/bloc/MangaPage/MangaPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum NavPage { home, discover, bookmarks, settings }

class NavigationProvider with ChangeNotifier, DiagnosticableTreeMixin {
  BuildContext context;
  NavigationProvider(this.context);

  PanelController panelController = PanelController();
  NavPage currentNavPage = NavPage.home;

  void navigateTo(String url) async {
    BlocProvider.of<MangaPageBloc>(context).add(LoadMPEvent(url));
    await panelController.open();
  }

  void gotoPage(NavPage navPage) {
    currentNavPage = navPage;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<NavPage>('currentNavPage', currentNavPage));
  }
}
