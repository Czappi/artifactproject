import 'package:artifactproject/src/bloc/MangaPage/MangaPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NavigationProvider {
  BuildContext context;
  NavigationProvider(this.context);

  // controller
  PanelController panelController = PanelController();

  // methods
  void navigateTo(String url) async {
    BlocProvider.of<MangaPageBloc>(context).add(LoadMPEvent(url));
    await panelController.open();
  }
}
