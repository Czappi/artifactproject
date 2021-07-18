import 'package:artifactproject/src/api/ManganatoAPI.dart';
import 'package:artifactproject/src/bloc/MangaList/HotMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/LatestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/NewestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaPage/MangaPage.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/translations/Translation.dart';
import 'package:artifactproject/src/ui/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Providers extends StatelessWidget {
  final Widget child;
  const Providers({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ManganatoAPI()),
        ChangeNotifierProvider(create: (context) => SettingsProvider(context)),
        Provider(create: (context) => NavigationProvider(context)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HotMangaListBloc(context)),
          BlocProvider(create: (context) => NewestMangaListBloc(context)),
          BlocProvider(create: (context) => LatestMangaListBloc(context)),
          BlocProvider(create: (context) => MangaPageBloc(context)),
        ],
        child: child,
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Providers(
      child: ScreenUtilInit(
        designSize: const Size(411.4, 891.4),
        builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: ArtifactTranslations(),
          theme: ThemeData(
            visualDensity: VisualDensity.standard,
          ),
          home: const Homepage(),
        ),
      ),
    );
  }
}
