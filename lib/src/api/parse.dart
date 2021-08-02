import 'package:artifactproject/src/models/MLPage.dart';
import 'package:artifactproject/src/models/MNMangaPage.dart' as mn_manga;
import 'package:artifactproject/src/models/MNChapterPage.dart' as mn_chapter;
import 'package:artifactproject/src/models/MNMangaListPage.dart'
    as mn_mangalist;
import 'package:artifactproject/src/models/MNLogin.dart' as mn_login;
import 'package:artifactproject/src/utils/FormatUtils.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:html/parser.dart';

mn_chapter.Chapter parseChapterPage(Map<String, String> map) {
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

mn_manga.Manga parseMangaPage(Map<String, String> map) {
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
    // alternativeTitle
    if (e.querySelector("i.info-alternative") != null) {
      alternativeTitle = e.querySelector("td.table-value > h2")!.text;
    }

    // author
    if (e.querySelector("i.info-author") != null) {
      var authorElement = e.querySelector("td.table-value > a.a-h")!;
      author = mn_manga.Author(
          authorElement.text, authorElement.attributes["href"]!);
    }

    // status
    if (e.querySelector("i.info-status") != null) {
      status = (e.querySelector("td.table-value")!.text == "Completed")
          ? MangaStatus.completed
          : MangaStatus.ongoing;
    }

    // genres
    if (e.querySelector("i.info-genres") != null) {
      var genreElements = e.querySelectorAll("td.table-value > a.a-h");
      for (var element in genreElements) {
        var parsedGenre = mn_manga.Genre.fromLink(element.attributes["href"]!);

        if (parsedGenre != null) {
          genres.add(parsedGenre);
        } else {
          String parsedId = RegExp(r'[0-9]+')
              .firstMatch(element.attributes["href"]!)!
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

  // followed
  bool followed = document.querySelector("img.story-bookmark") == null;

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
    description: FormatUtils.formatDesc(description),
    chapters: chapters,
    followed: followed,
  );
}

MLPage parseMangaListPage(String responseBody) {
  try {
    var document = parse(responseBody);

    // elementlist
    var elementlist = document
        .querySelectorAll("div.panel-content-genres > div.content-genres-item");

    // element
    var elements = elementlist.map((e) {
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
      var alchap = divinfo.querySelector("a.genres-item-chap");
      mn_mangalist.Chapter? latestChapter;
      if (alchap != null) {
        String lchapTitle = alchap.text;
        String lchapHref = alchap.attributes["href"]!;
        latestChapter = mn_mangalist.Chapter(lchapTitle, lchapHref);
      }

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

    var lastPageElement = document
        .querySelector("div.panel-page-number > div.group-page > a.page-last");

    var match = RegExp(r"([0-9]+)").firstMatch(lastPageElement!.text)!.group(1);

    if (match != null) {
      return MLPage(elements, int.parse(match));
    }
    return MLPage(elements, 0);
  } catch (e) {
    return const MLPage([], 0);
  }
}

mn_login.LoginPage parseLoginPage(String body) {
  var document = parse(body);
  var captcha =
      document.querySelector("div.captchar > img")!.attributes["src"]!;
  var firstRedirect =
      RegExp(r"link_home_ref = '(.*?)';").firstMatch(body)!.group(1)!;
  return mn_login.LoginPage(captcha, firstRedirect);
}

bool isLoggedIn(String body) {
  var document = parse(body);
  return document.querySelector("span.user-name") != null;
}

String? parseLoginFirstRedirect(String body) {
  var regex = RegExp(r"\$url_ref = '(.*?)';").firstMatch(body);
  if (regex != null) {
    return regex.group(1);
  } else {
    return null;
  }
}

mn_login.BookmarkPage parseBookmarkPage(String body) {
  var document = parse(body);
  List<mn_login.Bookmark> bookmarks = [];

  var bookmarkElementList = document.querySelectorAll("div.bookmark-item");

  for (var bookmarkElement in bookmarkElementList) {
    var rowOne =
        bookmarkElement.querySelector("div.item-right > p.item-row-one")!;
    var titleElement = rowOne.querySelector("a.item-story-name")!;
    var chapterElements = bookmarkElement.querySelectorAll("span.item-title");

    var lastViewedChElement = chapterElements
        .firstWhere((element) => element.text.toLowerCase().contains("viewed"));
    var latestChElement = chapterElements.firstWhere(
        (element) => element.text.toLowerCase().contains("current"));

    var removeId =
        rowOne.querySelector("a.bookmark_remove")!.attributes["data-id"]!;
    var title = titleElement.text;
    var imgUrl = bookmarkElement
        .querySelector("a > img.img-loading")!
        .attributes["src"]!;
    var lastViewedChapterTitle = lastViewedChElement.children[0].text;
    var lastViewedChapterUrl =
        lastViewedChElement.children[0].attributes["href"]!;
    var latestChapterTitle = latestChElement.children[0].text;
    var latestChapterUrl = latestChElement.children[0].attributes["href"]!;
    var mangaUrl = titleElement.attributes["href"]!;

    bookmarks.add(mn_login.Bookmark(
      title: title,
      url: mangaUrl,
      id: removeId,
      imgUrl: imgUrl,
      latestChapter: mn_mangalist.Chapter(latestChapterTitle, latestChapterUrl),
      lastViewedChapter:
          mn_mangalist.Chapter(lastViewedChapterTitle, lastViewedChapterUrl),
    ));
  }

  var lastPage = document.querySelector("div.group-page > a.page-last");
  var currentPage = document.querySelector("div.group-page > a.page-blue");

  int lastPageInt = 1;
  int currentPageInt = 1;

  if (lastPage != null) {
    lastPageInt = int.tryParse(RegExp(r"page=([1-999])")
            .firstMatch(lastPage.attributes["href"]!)!
            .group(1)!) ??
        1;
  }
  if (currentPage != null) {
    currentPageInt = int.tryParse(RegExp(r"page=([1-999])")
            .firstMatch(currentPage.attributes["href"]!)!
            .group(1)!) ??
        1;
  }

  return mn_login.BookmarkPage(
      currentPage: currentPageInt, lastPage: lastPageInt, bookmarks: bookmarks);
}
