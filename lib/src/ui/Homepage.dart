import 'package:artifactproject/src/bloc/MangaList/HotMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/LatestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/NewestMangaListBloc.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/state.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/widgets/HomepageElement.dart';
import 'package:artifactproject/src/widgets/MLListHorizontalItem.dart';
import 'package:artifactproject/src/widgets/MLListVerticalItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: ListView(
        children: const [
          _LatestMangaHomepageElement(),
          _HotMangaHomepageElement(),
          _NewestMangaHomepageElement(),
        ],
      ),
    );
  }
}

class _HotMangaHomepageElement extends StatelessWidget {
  const _HotMangaHomepageElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomepageElement(
      title: "#hotmangahomepageelement-title".tr,
      subtitle: "#hotmangahomepageelement-desc".tr,
      onShowMore: () {},
      backgroundColor: Colors.indigo.withOpacity(0.1),
      child: SizedBox(
        height: 200.h,
        child: BlocBuilder<HotMangaListBloc, MangaListState>(
            builder: (context, state) {
          if (state is LoadedMLState &&
              state.controller.itemList != null &&
              state.controller.itemList!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (state.controller.itemList!.length < 10)
                  ? state.controller.itemList!.length
                  : 10,
              itemBuilder: (context, index) {
                var mlElement = state.controller.itemList![index];
                return MLListHorizontalItem(
                  mlElement: mlElement,
                  width: 125.w,
                  aspectRatio: 1 / 1,
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: context.atheme.buttonColor,
            ),
          );
        }),
      ),
    );
  }
}

class _LatestMangaHomepageElement extends StatelessWidget {
  const _LatestMangaHomepageElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomepageElement(
      title: "#latestmangahomepageelement-title".tr,
      subtitle: "#latestmangahomepageelement-desc".tr,
      onShowMore: () {},
      //backgroundColor: Colors.indigo.withOpacity(0.1),
      child: SizedBox(
        height: 260.h,
        child: BlocBuilder<LatestMangaListBloc, MangaListState>(
            builder: (context, state) {
          if (state is LoadedMLState &&
              state.controller.itemList != null &&
              state.controller.itemList!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (state.controller.itemList!.length < 10)
                  ? state.controller.itemList!.length
                  : 10,
              itemBuilder: (context, index) {
                var mlElement = state.controller.itemList![index];
                return MLListVerticalItem(
                  mlElement: mlElement,
                  width: 125.w,
                  //aspectRatio: 1 / 1,
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: context.atheme.buttonColor,
            ),
          );
        }),
      ),
    );
  }
}

class _NewestMangaHomepageElement extends StatelessWidget {
  const _NewestMangaHomepageElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomepageElement(
      title: "#newestmangahomepageelement-title".tr,
      subtitle: "#newestmangahomepageelement-desc".tr,
      onShowMore: () {},
      //backgroundColor: Colors.indigo.withOpacity(0.1),
      child: SizedBox(
        height: 200.h,
        child: BlocBuilder<NewestMangaListBloc, MangaListState>(
            builder: (context, state) {
          if (state is LoadedMLState &&
              state.controller.itemList != null &&
              state.controller.itemList!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (state.controller.itemList!.length < 10)
                  ? state.controller.itemList!.length
                  : 10,
              itemBuilder: (context, index) {
                var mlElement = state.controller.itemList![index];
                return MLListHorizontalItem(
                  mlElement: mlElement,
                  //height: 125.h,
                  width: 200.w,
                  //aspectRatio: 1 / 1.5,
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: context.atheme.buttonColor,
            ),
          );
        }),
      ),
    );
  }
}
