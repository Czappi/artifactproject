import 'package:artifactproject/src/bloc/ChapterPage/ChapterPage.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Chapterpage extends StatelessWidget {
  Chapterpage({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.atheme.systemUiOverlayStyle,
        child: Container(
          color: context.atheme.backgroundColor,
          child: BlocBuilder<ChapterPageBloc, ChapterPageState>(
            builder: (context, state) {
              return CustomScrollView(
                controller: _scrollController,
                cacheExtent: double.maxFinite,
                slivers: [
                  SliverToBoxAdapter(
                    child: SafeArea(
                      child: Container(
                        color: context.atheme.backgroundColor,
                        height: 60.h,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                PhosphorIcons.caretLeftBold,
                                size: 26.sp,
                                color: context.atheme.iconColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                state.chapter.title,
                                style: context.atheme.bodyTitleTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is LoadedCHPState)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Image(
                            image: NetworkImage(state.chapter.imageUrls![index],
                                scale: 1.0,
                                headers: {
                                  "referer": "https://readmanganato.com/",
                                  "accept":
                                      "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8",
                                  "accept-encoding": "gzip, deflate, br",
                                  "useragent":
                                      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36",
                                }),
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Container(
                                height: 200,
                                color: context.atheme.backgroundColor,
                                child: const Center(
                                  child: Icon(
                                    PhosphorIcons.warning,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return SizedBox(
                                height: 200.h,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: context.atheme.buttonColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: state.chapter.imageUrls!.length,
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.atheme.buttonColor,
                          ),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                          height: 80.h,
                          child: Row(
                            children: [
                              if (state.chapter.prevHref != null)
                                Flexible(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: TextButton(
                                      onPressed: () {
                                        if (state.chapter.prevHref != null) {
                                          context.read<ChapterPageBloc>().add(
                                              LoadCHPEvent(
                                                  state.chapter.prevHref!, ""));
                                          _scrollController.animateTo(0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeOutCubic);
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          context.atheme.buttonColor,
                                        ),
                                        overlayColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) {
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return Colors.white24;
                                            }
                                          },
                                        ),
                                        minimumSize: MaterialStateProperty.all(
                                          const Size(
                                              double.infinity, double.infinity),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: context
                                                .atheme.standardBorderRadius,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "#prevchapter".tr.capitalize!,
                                        style: context.atheme.titleTextStyle
                                            .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Expanded(
                                flex: 4,
                                child: Container(),
                              ),
                              if (state.chapter.nextHref != null)
                                Flexible(
                                  flex: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: TextButton(
                                      onPressed: () {
                                        if (state.chapter.nextHref != null) {
                                          context.read<ChapterPageBloc>().add(
                                              LoadCHPEvent(
                                                  state.chapter.nextHref!, ""));
                                          _scrollController.animateTo(0,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeOutCubic);
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          context.atheme.buttonColor,
                                        ),
                                        overlayColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) {
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return Colors.white24;
                                            }
                                          },
                                        ),
                                        minimumSize: MaterialStateProperty.all(
                                          const Size(
                                              double.infinity, double.infinity),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: context
                                                .atheme.standardBorderRadius,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "#nextchapter".tr.capitalize!,
                                        style: context.atheme.titleTextStyle
                                            .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
