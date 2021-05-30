import 'dart:io';

import 'package:artifactproject/src/api/ApiClient.dart';
import 'package:artifactproject/src/models/MNChapterPage.dart' as mn_chapter;
import 'package:artifactproject/src/utils/FormatUtils.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:flutter/foundation.dart';
import 'package:artifactproject/src/models/MNMangaPage.dart' as mn_manga;
import 'package:artifactproject/src/models/MNMangaListPage.dart'
    as mn_mangalist;
import 'package:html/parser.dart';

class ManganatoAPI {
  final ApiClient apiClient = ApiClient();

  Future<mn_manga.Manga> mangaPage(String url, Cookie ciSession) async {
    var response = await apiClient.get(url, cookie: ciSession);

    return compute(
      _parseMangaPage,
      {"responseBody": response.document, "href": url},
    );
  }

  Future<mn_chapter.Chapter> chapterPage(String url) async {
    var response = await apiClient.get(url);

    return compute(
      _parseChapterPage,
      {"responseBody": response.document, "href": url},
    );
  }

  Future<List<mn_mangalist.MLElement>> mangaListPage(String url) async {
    var response = await apiClient.get(url);

    return compute(
      _parseMangaListPage,
      response.document,
    );
  }

  Future<List<mn_mangalist.MLElement>> search({
    SearchStatus status = SearchStatus.both,
    SearchOrderBy orderBy = SearchOrderBy.latest,
    SearchKeyword keyword = SearchKeyword.everything,
    List<mn_manga.Genre> genreInclude = const [],
    List<mn_manga.Genre> genreExclude = const [],
    String? search,
    int page = 1,
  }) async {
    String url = "https://manganato.com/advanced_search?s=all";

    // status
    switch (status) {
      case SearchStatus.both:
        break;
      case SearchStatus.completed:
        url + "&sts=completed";
        break;
      case SearchStatus.ongoing:
        url + "&sts=ongoing";
        break;
      default:
    }

    // orderBy
    switch (orderBy) {
      case SearchOrderBy.latest:
        break;
      case SearchOrderBy.az:
        url + "&orby=az";
        break;
      case SearchOrderBy.newM:
        url + "&orby=newest";
        break;
      case SearchOrderBy.topview:
        url + "&orby=topview";
        break;
      default:
    }

    // keyword, search
    if (search != null) {
      switch (keyword) {
        case SearchKeyword.everything:
          break;
        case SearchKeyword.nameTitle:
          url + "&keyt=title";
          break;
        case SearchKeyword.alternativeName:
          url + "&keyt=alternative";
          break;
        case SearchKeyword.author:
          url + "&keyt=author";
          break;
        default:
      }
      url + "&keyw=$search";
    }

    // genreInclude
    var genreIncludeIds = genreInclude.map((e) => e.id);
    if (genreIncludeIds.isNotEmpty) {
      String gIIdsString = genreIncludeIds.join("_");
      url + "&g_i=_${gIIdsString}_";
    }

    // genreExculde
    var genreExcludeIds = genreExclude.map((e) => e.id);
    if (genreExcludeIds.isNotEmpty) {
      String gEIdsString = genreExcludeIds.join("_");
      url + "&g_i=_${gEIdsString}_";
    }

    // page
    url + "&page=$page";

    return await mangaListPage(url);
  }
}

mn_chapter.Chapter _parseChapterPage(Map<String, String> map) {
  var document = parse(map["responseBody"]);

  // imageUrls
  var imageContainer = document.querySelector("div.container-chapter-reader")!;
  var imageElements = imageContainer.children;
  var imageUrls = imageElements.map((e) => e.attributes["src"]!).toList();

  // imageServers
  var currentImageServerElement =
      document.querySelector("a.server-image-btn.isactive")!;
  var otherImageServerElement =
      document.querySelector("a.server-image-btn.a-h")!;
  var currentImageServer =
      mn_chapter.ImageServer(currentImageServerElement.text);
  var otherImageServer = mn_chapter.ImageServer(otherImageServerElement.text,
      url: otherImageServerElement.attributes["data-l"]);

  // chapterList
  // indexes
  var chapterListIndexElements =
      document.querySelector("select.navi-change-chapter")!.children;
  var chapterListIndexes =
      chapterListIndexElements.map((e) => e.attributes["data-c"]!).toList();
  // baseurl
  var chapterListBaseUrlElementText = document
      .querySelectorAll("script")
      .firstWhere(
          (element) => element.text.contains("\$navi_change_chapter_address"))
      .text;
  var chapterListBaseUrl = RegExp(r"\$navi_change_chapter_address = (.*?);")
      .firstMatch(chapterListBaseUrlElementText)!
      .group(1)!
      .replaceAll(RegExp(r"['\+ ]"), "");
  var chapterList =
      mn_chapter.ChapterList(chapterListBaseUrl, chapterListIndexes);

  // title
  var title = document
      .querySelector("div.panel-chapter-info-bot > h2")!
      .text
      .replaceAll(" Summary", "");

  // next/prev href
  var nextHref = document
      .querySelector("a.navi-change-chapter-btn-next.a-h")!
      .attributes["href"]!;
  var prevHref = document
      .querySelector("a.navi-change-chapter-btn-prev.a-h")!
      .attributes["href"]!;

  return mn_chapter.Chapter(
      title: title,
      href: map["href"]!,
      nextHref: nextHref,
      prevHref: prevHref,
      imageUrls: imageUrls,
      currentImageServer: currentImageServer,
      otherImageServer: otherImageServer,
      chapterList: chapterList);
}

mn_manga.Manga _parseMangaPage(Map<String, String> map) {
  var document = parse(map["responseBody"]);

  // image
  String imageUrl =
      document.querySelector("span.info-image > img")!.attributes["src"]!;

  // title
  String title = document.querySelector("div.story-info-right > h1")!.text;

  // table
  var tableElements =
      document.querySelector("table.variations-tableInfo > tbody")!.children;

  String? alternativeTitle;
  mn_manga.Author? author;
  MangaStatus? status;
  List<mn_manga.Genre>? genres = [];

  for (var e in tableElements) {
    if (e.querySelector("i.info-alternative") != null) {
      alternativeTitle = e.querySelector("td.table-value > h2")!.text;
    }
    if (e.querySelector("i.info-author") != null) {
      var authorElement = e.querySelector("td.table-value > a.a-h")!;
      author = mn_manga.Author(
          authorElement.text, authorElement.attributes["href"]!);
    }
    if (e.querySelector("i.info-status") != null) {
      status = (e.querySelector("td.table-value")!.text == "Completed")
          ? MangaStatus.completed
          : MangaStatus.ongoing;
    }
    if (e.querySelector("i.info-genres") != null) {
      var genreElements = e.querySelectorAll("td.table-value > a.a-h");
      for (var element in genreElements) {
        var parsedGenre = mn_manga.Genre.fromLink(element.attributes["href"]!);

        if (parsedGenre != null) {
          genres.add(parsedGenre);
        } else {
          String parsedId = RegExp(r'[0-9]+')
              .firstMatch("https://manganelo.com/genre-29")!
              .group(0)!;
          genres.add(mn_manga.Genre(element.text, parsedId));
        }
      }
    }
  }

  // info
  var infoContainer = document
      .querySelectorAll("div.story-info-right-extent > p")
      .where((element) => element.querySelector("span.stre-value") != null);

  // updated
  DateTime updated = FormatUtils.formatDate(infoContainer
      .firstWhere((element) => element.querySelector("i.info-time") != null)
      .querySelector("span.stre-value")!
      .text
      .replaceFirst(" - ", " "));

  // view
  int views = FormatUtils.formatView(infoContainer
      .firstWhere((element) => element.querySelector("i.info-view") != null)
      .querySelector("span.stre-value")!
      .text);

  // rating

  double best = double.tryParse(document
          .querySelector(
              'em#rate_row_cmd > em > em > em > em[property="v:best"]')!
          .text) ??
      5;
  double average = (double.tryParse(document
              .querySelector(
                  'em#rate_row_cmd > em > em > em > em[property="v:average"]')!
              .text) ??
          0)
      .clamp(0, best);
  int votes = int.tryParse(document
          .querySelector('em#rate_row_cmd > em > em[property="v:votes"]')!
          .text) ??
      0;
  var rating = mn_manga.Rating(average, best, votes);

  // postId
  var postIdElementText = document
      .querySelectorAll('script[type="application/javascript"]')
      .firstWhere((element) => element.text.contains("\$postid"))
      .text;
  String postId =
      RegExp(r"\$postid = (.*?);").firstMatch(postIdElementText)!.group(1)!;

  // description
  String description = document
      .querySelector(
          "div#panel-story-info-description.panel-story-info-description")!
      .text
      .replaceAll("Description :\n", "");

  // chapters
  var chapterElements =
      document.querySelector("ul.row-content-chapter")!.children;
  List<mn_manga.Chapter> chapters = chapterElements.map((e) {
    var chaptername = e.querySelector("a.chapter-name")!;
    return mn_manga.Chapter.fromStrings(
        chaptername.text,
        e.querySelector("span.chapter-time")!.attributes["title"]!,
        e.querySelector("span.chapter-view")!.text,
        chaptername.attributes["href"]!);
  }).toList();

  return mn_manga.Manga(
    title: title,
    href: map["href"]!,
    img: imageUrl,
    alternativeTitle: alternativeTitle ?? "",
    author: author ?? const mn_manga.Author("", ""),
    status: status ?? MangaStatus.unknown,
    genres: genres,
    updated: updated,
    view: views,
    rating: rating,
    postId: postId,
    description: description,
    chapters: chapters,
  );
}

List<mn_mangalist.MLElement> _parseMangaListPage(String responseBody) {
  var document = parse(responseBody);

  // elementlist
  var elementlist = document
      .querySelectorAll("div.panel-content-genres > div.content-genres-item");

  // element
  return elementlist.map((e) {
    var aimg = e.querySelector("a.genres-item-img")!;
    var divinfo = e.querySelector("div.genres-item-info")!;

    // title
    String title = aimg.attributes["title"]!;

    // url
    String url = aimg.attributes["href"]!;

    // imgUrl
    String imgUrl = aimg.querySelector("img.img-loading")!.attributes["src"]!;

    // ratingAverage
    double ratingAverage = double.tryParse(
          aimg.querySelector("em.genres-item-rate")!.text,
        ) ??
        0.0;

    // latestChapter
    var alchap = divinfo.querySelector("a.genres-item-chap")!;
    String lchapTitle = alchap.text;
    String lchapHref = alchap.attributes["href"]!;

    mn_mangalist.LatestChapter latestChapter =
        mn_mangalist.LatestChapter(lchapTitle, lchapHref);

    // author
    String author = divinfo.querySelector("span.genres-item-author")!.text;

    // descriptionPiece
    String descriptionPiece = divinfo
        .querySelector("div.genres-item-description")!
        .text
        .replaceFirst("\n", "");

    // updated
    DateTime updated = FormatUtils.formatMLDate(
        divinfo.querySelector("span.genres-item-time")!.text);

    // views
    int views = FormatUtils.formatView(
        divinfo.querySelector("span.genres-item-view")!.text);

    return mn_mangalist.MLElement(
        title: title,
        author: author,
        imgUrl: imgUrl,
        url: url,
        descriptionPiece: descriptionPiece,
        updated: updated,
        ratingAverage: ratingAverage,
        views: views,
        latestChapter: latestChapter);
  }).toList();
}
