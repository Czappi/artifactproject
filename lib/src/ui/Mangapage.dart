import 'package:artifactproject/src/bloc/MangaPage/MangaPage.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/widgets/MangapageAppbar.dart';
import 'package:artifactproject/src/widgets/MangapageBodyDescriptionCard.dart';
import 'package:artifactproject/src/widgets/MangapageBodyHeader.dart';
import 'package:artifactproject/src/widgets/MangapageBodyInformationCard.dart';
import 'package:artifactproject/src/widgets/MangapageBottomBar.dart';
import 'package:artifactproject/src/widgets/MangapageChaptersCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mangapage extends StatelessWidget {
  final ScrollController scrollController;
  const Mangapage(this.scrollController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: context.atheme.systemUiOverlayStyle,
      child: WillPopScope(
        onWillPop: () async {
          await context.read<NavigationProvider>().panelController.close();
          await context.read<NavigationProvider>().panelController.hide();
          return false;
        },
        child: Container(
          color: context.atheme.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: const [
                    MangapageAppbar(),
                    _Body(),
                  ],
                ),
              ),
              MangapageBottomBar(
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaPageBloc, MangaPageState>(
      builder: (context, state) {
        if (state is InitialMPState) {
          return SizedBox(
            height: 400,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                color: context.atheme.buttonColor,
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MangapageBodyHeader(
              title: state.manga.title,
              author: state.manga.author.name,
              imgUrl: state.manga.img,
              rating: state.manga.rating.average,
              followed: state.manga.followed,
            ),
            _MainBody(
              state: state,
            ),
          ],
        );
      },
    );
  }
}

class _MainBody extends StatelessWidget {
  final MangaPageState state;
  const _MainBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is LoadedMPState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MangapageBodyDescriptionCard(
            description: state.manga.description,
          ),
          MangapageBodyInformationCard(
            genres: state.manga.genres,
            author: state.manga.author,
            rating: state.manga.rating,
            title: state.manga.title,
            altTitle: state.manga.alternativeTitle,
            status: state.manga.status,
            view: state.manga.view,
            updated: state.manga.updated,
          ),
        ],
      );
    }
    if (state is LoadingMPState) {
      return SizedBox(
        height: 400,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color: context.atheme.buttonColor,
          ),
        ),
      );
    }
    return Container();
  }
}
